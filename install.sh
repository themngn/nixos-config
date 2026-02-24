#!/usr/bin/env bash
set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

CONFIG_REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ETC_NIXOS="/etc/nixos"
BACKUP_DIR="${ETC_NIXOS}.backup.$(date +%Y%m%d-%H%M%S)"

echo -e "${YELLOW}═══════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}  NixOS Config Installer${NC}"
echo -e "${YELLOW}═══════════════════════════════════════════════════════${NC}"
echo ""
echo "Config repository: $CONFIG_REPO"
echo "Will symlink to: $ETC_NIXOS"
echo ""

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}✗ This script must be run as root${NC}"
   echo "   Try: sudo bash $0"
   exit 1
fi

# Backup existing /etc/nixos if it exists
if [[ -e "$ETC_NIXOS" ]] && [[ ! -L "$ETC_NIXOS" ]]; then
  echo -e "${YELLOW}→ Backing up existing /etc/nixos to $BACKUP_DIR${NC}"
  mv "$ETC_NIXOS" "$BACKUP_DIR"
  echo -e "${GREEN}✓ Backed up to $BACKUP_DIR${NC}"
fi

# Remove old symlink if it exists
if [[ -L "$ETC_NIXOS" ]]; then
  echo -e "${YELLOW}→ Removing old symlink${NC}"
  rm "$ETC_NIXOS"
fi

# Create new symlink
echo -e "${YELLOW}→ Creating symlink: $ETC_NIXOS → $CONFIG_REPO${NC}"
ln -s "$CONFIG_REPO" "$ETC_NIXOS"
echo -e "${GREEN}✓ Symlink created${NC}"

# Try to restore flake.lock from backup if available
if [[ -f "${BACKUP_DIR}/flake.lock" ]] && [[ ! -f "${CONFIG_REPO}/flake.lock" ]]; then
  echo -e "${YELLOW}→ Restoring flake.lock from backup (avoids re-download)${NC}"
  cp "${BACKUP_DIR}/flake.lock" "${CONFIG_REPO}/flake.lock"
  echo -e "${GREEN}✓ flake.lock restored${NC}"
fi

echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✓ Installation complete!${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}"
echo ""
echo "Next steps:"
echo "  1. Review the config structure:"
echo "     ls -la $ETC_NIXOS"
echo ""
echo "  2. Rebuild the system:"
echo "     sudo nixos-rebuild switch --flake $ETC_NIXOS#nixos"
echo ""
echo "  3. Or use your update alias:"
echo "     update"
echo ""
echo "Backup location (if created):"
echo "  $BACKUP_DIR"
echo ""
