#!/usr/bin/env bash
set -e

# ============================================
# GPG setup script (macOS only)
# - Generates or reuses a GPG key for an email
# - Configures gpg-agent with pinentry-mac
# - Configures Git to use the GPG key
# ============================================

echo "🔐 GPG setup (macOS)"
echo

# ----------------------------
# Ask for email
# ----------------------------
read -p "Email for GPG key: " EMAIL

if [[ -z "$EMAIL" ]]; then
  echo "❌ Email cannot be empty"
  exit 1
fi

# ----------------------------
# Ensure pinentry-mac is installed
# ----------------------------
echo "🔹 Checking for pinentry-mac..."

if ! command -v pinentry-mac &>/dev/null; then
  echo "pinentry-mac not found, installing via Homebrew..."
  brew install pinentry-mac
else
  echo "pinentry-mac is already installed ✅"
fi

PINENTRY_PATH="$(command -v pinentry-mac)"
if [[ -z "$PINENTRY_PATH" ]]; then
  echo "❌ pinentry-mac not found after installation"
  exit 1
fi

# ----------------------------
# Check for existing GPG key
# ----------------------------
echo "🔹 Checking for existing GPG key..."

KEY_ID=$(gpg --list-secret-keys --keyid-format=long "$EMAIL" 2>/dev/null |
  awk '/^sec/{print $2}' | cut -d'/' -f2)

if [[ -n "$KEY_ID" ]]; then
  echo "✅ Existing GPG key found: $KEY_ID"
else
  echo "🔹 No GPG key found for $EMAIL"
  echo "🔹 Launching interactive GPG key generation..."
  echo

  gpg --full-generate-key

  KEY_ID=$(gpg --list-secret-keys --keyid-format=long "$EMAIL" |
    awk '/^sec/{print $2}' | cut -d'/' -f2)

  if [[ -z "$KEY_ID" ]]; then
    echo "❌ No GPG key found for $EMAIL after generation"
    exit 1
  fi

  echo "✅ New GPG key created: $KEY_ID"
fi

# ----------------------------
# Export public key
# ----------------------------
PUBKEY_FILE="$HOME/gpg-public-key.asc"

echo "🔹 Exporting public key to:"
echo "   $PUBKEY_FILE"

gpg --armor --export "$KEY_ID" >"$PUBKEY_FILE"

# ----------------------------
# Configure gpg-agent
# ----------------------------
echo "🔹 Configuring gpg-agent..."

GNUPG_DIR="$HOME/.gnupg"
AGENT_CONF="$GNUPG_DIR/gpg-agent.conf"

mkdir -p "$GNUPG_DIR"

# Backup existing config if present
if [[ -f "$AGENT_CONF" ]]; then
  cp "$AGENT_CONF" "$AGENT_CONF.bak"
  echo "📦 Existing gpg-agent.conf backed up"
fi

cat >"$AGENT_CONF" <<EOF
default-cache-ttl 28800
max-cache-ttl 86400
pinentry-program $PINENTRY_PATH
EOF

killall gpg-agent &>/dev/null || true

# ----------------------------
# Configure Git for GPG signing
# ----------------------------
echo "🔹 Configuring Git to use GPG..."

git config --global user.email "$EMAIL"
git config --global user.signingkey "$KEY_ID"
git config --global commit.gpgsign true
git config --global tag.gpgSign true

# ----------------------------
# Final manual step (copy & paste)
# ----------------------------
echo
echo "────────────────────────────────────────────"
echo "ℹ️  Final manual step (copy & paste):"
echo
echo "echo 'export GPG_TTY=\$(tty)' >> ~/.zshrc"
echo "source ~/.zshrc"
echo
echo "Then restart your terminal if needed."
echo "────────────────────────────────────────────"

echo
echo "✅ GPG setup completed"
echo "Key ID: $KEY_ID"
echo
echo "Copy your public GPG key to the clipboard (macOS)"
echo "pbcopy < ~/gpg-public-key.asc"
echo
echo "➡️ Upload the public key to:"
echo "   - GitHub:  Settings → SSH and GPG keys"
echo "   - Forgejo: Settings → SSH / GPG keys"
