#!/usr/bin/env bash
set -e

# 🔹 Prompt user for GPG and Git configuration
echo "🔹 Setting up a new GPG key"

read -p "Full name: " NAME
read -p "Email for Git/GPG: " EMAIL
read -p "Key comment (optional): " COMMENT
read -p "Key expiration (e.g., 1y, 6m, 0 for never): " EXPIRE_DATE

# Set defaults if user leaves input blank
EXPIRE_DATE=${EXPIRE_DATE:-1y}
COMMENT=${COMMENT:-git signing key}

KEY_TYPE="RSA"
KEY_LENGTH=4096

# 🔹 Check if pinentry-mac is installed (required for passphrase input)
echo "🔹 Checking for pinentry-mac..."
if ! command -v pinentry-mac &>/dev/null; then
  echo "pinentry-mac not found, installing with brew..."
  brew install pinentry-mac
else
  echo "pinentry-mac is already installed ✅"
fi

# 🔹 Check if a GPG key already exists for this email
EXISTING_KEY_ID=$(gpg --list-secret-keys --keyid-format=long "$EMAIL" 2>/dev/null | grep "sec" | awk '{print $2}' | cut -d'/' -f2 || true)

if [ -n "$EXISTING_KEY_ID" ]; then
  echo "🔹 A GPG key already exists for $EMAIL: $EXISTING_KEY_ID"
  KEY_ID="$EXISTING_KEY_ID"
else
  # 🔹 Generate a new GPG key
  echo "🔹 Generating a new GPG key..."
  gpg --batch --full-generate-key <<EOF
%echo Generating a GPG key
Key-Type: $KEY_TYPE
Key-Length: $KEY_LENGTH
Name-Real: $NAME
Name-Comment: $COMMENT
Name-Email: $EMAIL
Expire-Date: $EXPIRE_DATE
Passphrase: 
%commit
%echo Done
EOF

  KEY_ID=$(gpg --list-secret-keys --keyid-format=long "$EMAIL" | grep "sec" | awk '{print $2}' | cut -d'/' -f2)
  echo "🔹 New Key ID: $KEY_ID"
fi

# 🔹 Export the public key only (safe to share)
echo "🔹 Exporting public key to ~/gpg-public-key.asc..."
gpg --armor --export "$KEY_ID" >~/gpg-public-key.asc
echo "Upload this public key to GitHub and Forgejo."

# 🔹 Configure Git globally
echo "🔹 Configuring Git..."
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"
git config --global user.signingkey "$KEY_ID"
git config --global commit.gpgsign true
git config --global tag.gpgSign true

# 🔹 Set GPG_TTY in shell config if not already present
echo "🔹 Configuring GPG_TTY..."
if ! grep -q "export GPG_TTY=" ~/.zshrc 2>/dev/null; then
  echo 'export GPG_TTY=$(tty)' >>~/.zshrc
fi
source ~/.zshrc

# 🔹 Configure GPG agent
echo "🔹 Configuring GPG agent..."
mkdir -p ~/.gnupg
grep -qxF "default-cache-ttl 28800" ~/.gnupg/gpg-agent.conf 2>/dev/null || echo "default-cache-ttl 28800" >>~/.gnupg/gpg-agent.conf
grep -qxF "max-cache-ttl 86400" ~/.gnupg/gpg-agent.conf 2>/dev/null || echo "max-cache-ttl 86400" >>~/.gnupg/gpg-agent.conf
grep -qxF "pinentry-program $(which pinentry-mac)" ~/.gnupg/gpg-agent.conf 2>/dev/null || echo "pinentry-program $(which pinentry-mac)" >>~/.gnupg/gpg-agent.conf
killall gpg-agent || true

# 🔹 Final instructions
echo "✅ Script completed. You can test a signed commit with:"
echo "git commit -m \"test: signed commit\""
echo "and verify it with 'git log --show-signature'"
