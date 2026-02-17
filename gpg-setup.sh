#!/usr/bin/env bash
set -euo pipefail

# ============================================
# GPG setup script (macOS only)
# - Generates or reuses a GPG key for an email
# - Configures gpg-agent with pinentry-mac
# - Configures Git to use the GPG key
# ============================================

echo "🔐 GPG setup (macOS)"
echo

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "❌ This script supports macOS only"
  exit 1
fi

if ! command -v gpg >/dev/null 2>&1; then
  echo "❌ gpg is not installed. Install GnuPG first."
  exit 1
fi

# ----------------------------
# Ask for email
# ----------------------------
read -r -p "Email for GPG key: " EMAIL

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
  if ! command -v brew >/dev/null 2>&1; then
    echo "❌ Homebrew is required to install pinentry-mac"
    exit 1
  fi
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

get_matching_keys() {
  gpg --list-secret-keys --with-colons --fingerprint -- "$EMAIL" 2>/dev/null |
    awk -F: '
      $1=="sec" {in_sec=1; next}
      in_sec && $1=="fpr" {print $10; in_sec=0}
    ' || true
}

MATCHING_KEYS=()
KEYS_RAW="$(get_matching_keys)"
if [[ -n "$KEYS_RAW" ]]; then
  while IFS= read -r line; do
    MATCHING_KEYS+=("$line")
  done <<< "$KEYS_RAW"
fi

if [[ "${#MATCHING_KEYS[@]}" -eq 0 ]]; then
  echo "🔹 No GPG key found for $EMAIL"
  read -r -p "Name for GPG key UID: " NAME
  if [[ -z "${NAME:-}" ]]; then
    NAME="$(git config --global user.name || true)"
  fi
  if [[ -z "${NAME:-}" ]]; then
    echo "❌ Name cannot be empty"
    exit 1
  fi

  KEY_UID="$NAME <$EMAIL>"
  echo "🔹 Generating new key for: $KEY_UID"
  echo "   (algorithm: ed25519, usage: sign, expiry: 1y)"

  gpg --quick-generate-key "$KEY_UID" ed25519 sign 1y

  MATCHING_KEYS=()
  KEYS_RAW="$(get_matching_keys)"
  if [[ -n "$KEYS_RAW" ]]; then
    while IFS= read -r line; do
      MATCHING_KEYS+=("$line")
    done <<< "$KEYS_RAW"
  fi

  if [[ "${#MATCHING_KEYS[@]}" -eq 0 ]]; then
    echo "❌ No GPG key found for $EMAIL after generation"
    exit 1
  fi

  KEY_ID="${MATCHING_KEYS[0]}"
  echo "✅ New GPG key created: $KEY_ID"
elif [[ "${#MATCHING_KEYS[@]}" -eq 1 ]]; then
  KEY_ID="${MATCHING_KEYS[0]}"
  echo "✅ Existing GPG key found: $KEY_ID"
else
  echo "ℹ️ Multiple keys found for $EMAIL. Select one:"
  for i in "${!MATCHING_KEYS[@]}"; do
    printf "  %d) %s\n" "$((i + 1))" "${MATCHING_KEYS[$i]}"
  done
  read -r -p "Choose key number [1-${#MATCHING_KEYS[@]}]: " KEY_INDEX
  if ! [[ "$KEY_INDEX" =~ ^[0-9]+$ ]] || (( KEY_INDEX < 1 || KEY_INDEX > ${#MATCHING_KEYS[@]} )); then
    echo "❌ Invalid selection"
    exit 1
  fi
  KEY_ID="${MATCHING_KEYS[$((KEY_INDEX - 1))]}"
  echo "✅ Selected existing key: $KEY_ID"
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
chmod 700 "$GNUPG_DIR"

# Backup existing config if present
if [[ -f "$AGENT_CONF" ]]; then
  cp "$AGENT_CONF" "$AGENT_CONF.bak"
  echo "📦 Existing gpg-agent.conf backed up"
fi

touch "$AGENT_CONF"
chmod 600 "$AGENT_CONF"

set_agent_option() {
  local key="$1"
  local value="$2"
  local tmp_file
  tmp_file="$(mktemp)"

  awk -v k="$key" -v v="$value" '
    BEGIN {updated=0}
    $1==k {$0=k " " v; updated=1}
    {print}
    END {if (!updated) print k " " v}
  ' "$AGENT_CONF" >"$tmp_file"

  mv "$tmp_file" "$AGENT_CONF"
}

set_agent_option "default-cache-ttl" "28800"
set_agent_option "max-cache-ttl" "86400"
set_agent_option "pinentry-program" "$PINENTRY_PATH"

if command -v gpgconf >/dev/null 2>&1; then
  gpgconf --kill gpg-agent || true
else
  killall gpg-agent &>/dev/null || true
fi

# ----------------------------
# Configure Git for GPG signing
# ----------------------------
echo "🔹 Configuring Git to use GPG..."

read -r -p "Update global Git user.email to $EMAIL? [y/N]: " UPDATE_EMAIL
if [[ "${UPDATE_EMAIL:-}" =~ ^[Yy]$ ]]; then
  git config --global user.email "$EMAIL"
fi
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
