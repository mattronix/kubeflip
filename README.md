# kubeflip

A simple yet powerful utility to manage and switch between multiple Kubernetes context configurations.

## Overview

`kubeflip` allows you to store multiple kubectl configuration files and quickly switch between them. Perfect for managing different clusters, environments, or projects without the complexity of kubectl context switching within a single config file.

## Features

- **Quick Context Switching**: Switch between different kubectl configurations with a single command
- **Safe Storage**: Store and manage multiple kubectl configurations securely
- **Context Locking**: Lock contexts to prevent accidental modifications (uses `chflags` on macOS, `chattr` on Linux)
- **Tree View**: Visualize contexts and their clusters in a tree format
- **Protected Deletion**: Cannot delete locked or currently active contexts
- **Secure Permissions**: All context files are created with 600 permissions
- **Cross-Platform**: Works on macOS and Linux
- **Colored Output**: Clear, colorful terminal output for better UX

## Installation

### Quick Install

```bash
# Clone or download the kubeflip files
cd kubeflip
chmod +x install.sh
./install.sh
```

### Manual Install

```bash
# Copy the kubeflip script to your PATH
sudo cp kubeflip /usr/local/bin/kubeflip
sudo chmod +x /usr/local/bin/kubeflip
```

## Usage

### Store Contexts

Store your current kubectl configuration with a name:

```bash
# Store current config as "production"
kubeflip store production

# Store current config as "development"
kubeflip store development
```

### Switch Between Contexts

Activate a stored context configuration:

```bash
# Switch to production context
kubeflip activate production

# Switch to development context
kubeflip activate development
```

### Create New Empty Context

Create a new empty context configuration:

```bash
kubeflip new staging
```

### List Available Contexts

See all stored context configurations with lock status:

```bash
kubeflip list
```

Example output:
```
Available contexts:
  * production (active) (locked)
    development (unlocked)
    staging (unlocked)
```

### Tree View

View contexts and their clusters in a tree format:

```bash
kubeflip tree
```

Example output:
```
kubeflip contexts tree:
├── production (active)
│   └── prod-cluster
├── development
│   └── dev-cluster
└── staging
    └── (no clusters)
```

### Check Current Context

See which context is currently active (also the default when running `kubeflip` with no arguments):

```bash
kubeflip current
# or simply
kubeflip
```

### Lock/Unlock Contexts

Prevent accidental modifications to important contexts:

```bash
# Lock the current context
kubeflip lock

# Lock a specific context
kubeflip lock production

# Unlock a context
kubeflip unlock production

# Lock all contexts
kubeflip lock-all

# Unlock all contexts
kubeflip unlock-all
```

### Remove Contexts

Remove a stored context configuration (cannot remove locked or active contexts):

```bash
kubeflip remove old-cluster
```

## Commands Reference

| Command | Description | Example |
|---------|-------------|---------|
| `activate <name>` | Switch to the specified context | `kubeflip activate production` |
| `store <name>` | Store current kubectl config with name | `kubeflip store development` |
| `new <name>` | Create a new empty context | `kubeflip new staging` |
| `list` | List all stored contexts with lock status | `kubeflip list` |
| `tree` | Show contexts and clusters in tree format | `kubeflip tree` |
| `current` | Show currently active context | `kubeflip current` |
| `remove <name>` | Remove a stored context | `kubeflip remove old-cluster` |
| `lock [name]` | Lock context (current if no name) | `kubeflip lock production` |
| `unlock [name]` | Unlock context (current if no name) | `kubeflip unlock production` |
| `lock-all` | Lock all contexts | `kubeflip lock-all` |
| `unlock-all` | Unlock all contexts | `kubeflip unlock-all` |
| `help` | Show help information | `kubeflip help` |

## How It Works

kubeflip manages your kubectl configurations by:

1. **Storage**: Storing different kubectl config files in `~/.kubeflip/contexts/`
2. **Switching**: Creating symlinks from `~/.kube/config` to the selected context
3. **Locking**: Using filesystem immutable flags (`chflags uchg` on macOS, `chattr +i` on Linux)
4. **Tracking**: Keeping track of the currently active context via symlink

## Directory Structure

```
~/.kubeflip/
├── contexts/           # Stored context configurations
│   ├── production     # Your production cluster config
│   ├── development    # Your development cluster config
│   └── staging        # Your staging cluster config
└── current            # Symlink to currently active context
```

## Safety Features

- **Context Locking**: Lock important contexts to prevent accidental modifications
- **Active Context Protection**: Cannot delete the currently active context
- **Locked Context Protection**: Cannot delete locked contexts
- **Confirmation Prompts**: Destructive operations require confirmation
- **Secure Permissions**: All context files are created with 600 permissions
- **Error Handling**: Comprehensive error checking and helpful error messages

## Examples

### First-Time Setup

```bash
# Store your existing config
kubeflip store default

# Store configs for different environments
kubeflip store production
kubeflip store development

# Lock production to prevent changes
kubeflip lock production
```

### Daily Usage

```bash
# Check current context
kubeflip

# Switch to production
kubeflip activate production
kubectl get pods

# Switch to development
kubeflip activate development
kubectl get pods

# Check what's available
kubeflip list

# View tree structure
kubeflip tree
```

## Integration with kubectl

After activating a context with kubeflip, all `kubectl` commands will use that configuration:

```bash
kubeflip activate production
kubectl get namespaces    # Uses production config

kubeflip activate development
kubectl get namespaces    # Uses development config
```

## Troubleshooting

### kubeflip command not found
- Ensure `/usr/local/bin` is in your PATH
- Try restarting your terminal
- Verify installation with `ls -la /usr/local/bin/kubeflip`

### Context not found error
- Use `kubeflip list` to see available contexts
- Ensure you've stored the context with `kubeflip store <name>`

### Permission denied
- The installer may need sudo privileges for system-wide installation
- Check file permissions with `ls -la /usr/local/bin/kubeflip`

### Cannot delete context
- Check if context is locked with `kubeflip list`
- Unlock with `kubeflip unlock <name>` before removing
- Cannot delete the currently active context - switch to another first

## Contributing

Feel free to submit issues and pull requests to improve kubeflip!

## License

This project is open source. Feel free to use and modify as needed.
