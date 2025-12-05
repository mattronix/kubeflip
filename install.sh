#!/usr/bin/env bash

# kubeflip installer script

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Installation paths
INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="kubeflip"
SCRIPT_PATH="$INSTALL_DIR/$SCRIPT_NAME"

echo -e "${BLUE}kubeflip installer${NC}"
echo "=================="

# Check if running with sudo for system-wide installation
if [[ "$INSTALL_DIR" == "/usr/local/bin" && "$EUID" -ne 0 ]]; then
    echo -e "${YELLOW}Note: Installing to $INSTALL_DIR requires sudo privileges${NC}"
    echo -e "${YELLOW}You may be prompted for your password${NC}"
    echo
fi

# Function to install kubeflip
install_kubeflip() {
    local source_script="./kubeflip"
    
    # Check if source script exists
    if [[ ! -f "$source_script" ]]; then
        echo -e "${RED}Error: kubeflip script not found in current directory${NC}"
        echo "Please run this installer from the kubeflip project directory"
        exit 1
    fi
    
    # Create install directory if it doesn't exist
    if [[ ! -d "$INSTALL_DIR" ]]; then
        echo -e "${YELLOW}Creating directory: $INSTALL_DIR${NC}"
        if [[ "$EUID" -eq 0 ]]; then
            mkdir -p "$INSTALL_DIR"
        else
            sudo mkdir -p "$INSTALL_DIR"
        fi
    fi
    
    # Copy script to install directory
    echo -e "${YELLOW}Installing kubeflip to $SCRIPT_PATH${NC}"
    if [[ "$EUID" -eq 0 ]]; then
        cp "$source_script" "$SCRIPT_PATH"
        chmod +x "$SCRIPT_PATH"
    else
        sudo cp "$source_script" "$SCRIPT_PATH"
        sudo chmod +x "$SCRIPT_PATH"
    fi
    
    echo -e "${GREEN}kubeflip installed successfully!${NC}"
    echo
}

# Function to verify installation
verify_installation() {
    if command -v kubeflip &> /dev/null; then
        echo -e "${GREEN}✓ kubeflip is available in PATH${NC}"
        echo -e "${BLUE}Version check:${NC}"
        kubeflip help | head -1
    else
        echo -e "${RED}✗ kubeflip not found in PATH${NC}"
        echo -e "${YELLOW}You may need to restart your terminal or add $INSTALL_DIR to your PATH${NC}"
        echo
        echo -e "${BLUE}To add to PATH, add this line to your ~/.zshrc or ~/.bash_profile:${NC}"
        echo "export PATH=\"$INSTALL_DIR:\$PATH\""
    fi
}

# Function to show usage examples
show_examples() {
    cat << EOF
${BLUE}Getting Started:${NC}

1. Store your current kubectl config:
   kubeflip store default

2. Store additional contexts:
   kubeflip store production
   kubeflip store development

3. Switch between contexts:
   kubeflip activate production
   kubeflip activate development

4. List all contexts:
   kubeflip list

5. Check current active context:
   kubeflip current

For more help: kubeflip help

EOF
}

# Main installation process
main() {
    echo -e "${YELLOW}Installing kubeflip...${NC}"
    echo
    
    install_kubeflip
    verify_installation
    
    echo
    show_examples
    
    echo -e "${GREEN}Installation complete!${NC}"
    echo -e "${BLUE}Happy context switching! 🚀${NC}"
}

# Check if user wants to proceed
echo -e "${YELLOW}This will install kubeflip to $INSTALL_DIR${NC}"
echo -e "${YELLOW}Proceed with installation? (Y/n)${NC}"
read -r response

if [[ "$response" =~ ^[nN]$ ]]; then
    echo "Installation cancelled."
    exit 0
fi

main