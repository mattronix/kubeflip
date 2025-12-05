# kubeflip 🔄

A simple yet powerful utility to manage and switch between multiple Kubernetes context configurations.

## Overview

`kubeflip` allows you to store multiple kubectl configuration files and quickly switch between them. Perfect for managing different clusters, environments, or projects without the complexity of kubectl context switching within a single config file.

## Features

- 🔄 **Quick Context Switching**: Switch between different kubectl configurations with a single command
- 💾 **Safe Storage**: Automatically backs up your current config before switching
- 📋 **Easy Management**: List, store, and remove context configurations
- 🎯 **Simple Interface**: Intuitive command-line interface
- 🔒 **Backup Protection**: Automatic timestamped backups prevent data loss
- 🎨 **Colored Output**: Clear, colorful terminal output for better UX

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

# Store current config as "staging"
kubeflip store staging
```

### Switch Between Contexts

Activate a stored context configuration:

```bash
# Switch to production context
kubeflip activate production

# Switch to development context
kubeflip activate development
```

### List Available Contexts

See all stored context configurations:

```bash
kubeflip list
```

Example output:
```
Available contexts:
  * production (active)
    development
    staging
    local-minikube
```

### Check Current Context

See which context is currently active:

```bash
kubeflip current
```

### Remove Contexts

Remove a stored context configuration:

```bash
kubeflip remove old-cluster
```

## Commands Reference

| Command | Description | Example |
|---------|-------------|---------|
| `activate <name>` | Switch to the specified context | `kubeflip activate production` |
| `store <name>` | Store current kubectl config with name | `kubeflip store development` |
| `list` | List all stored contexts | `kubeflip list` |
| `current` | Show currently active context | `kubeflip current` |
| `remove <name>` | Remove a stored context | `kubeflip remove old-cluster` |
| `help` | Show help information | `kubeflip help` |

## How It Works

kubeflip manages your kubectl configurations by:

1. **Storage**: Storing different kubectl config files in `~/.kubeflip/contexts/`
2. **Switching**: Copying the selected context file to `~/.kube/config`
3. **Backup**: Creating timestamped backups before each switch
4. **Tracking**: Keeping track of the currently active context

## Directory Structure

```
~/.kubeflip/
├── contexts/           # Stored context configurations
│   ├── production     # Your production cluster config
│   ├── development    # Your development cluster config
│   └── staging        # Your staging cluster config
├── current            # Symlink to currently active context
└── backup-*          # Timestamped backup files
```

## Safety Features

- **Automatic Backups**: Every context switch creates a timestamped backup
- **Confirmation Prompts**: Destructive operations require confirmation
- **Existing Config Preservation**: Your current config is automatically stored as "default" on first run
- **Error Handling**: Comprehensive error checking and helpful error messages

## Examples

### First-Time Setup

```bash
# kubeflip automatically backs up your existing config
kubeflip store default

# Store configs for different environments
kubectl config use-context prod-cluster
kubeflip store production

kubectl config use-context dev-cluster  
kubeflip store development
```

### Daily Usage

```bash
# Switch to production
kubeflip activate production
kubectl get pods

# Switch to development
kubeflip activate development
kubectl get pods

# Check what's available
kubeflip list

# See current context
kubeflip current
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

## Contributing

Feel free to submit issues and pull requests to improve kubeflip!

## License

This project is open source. Feel free to use and modify as needed.

---

**Happy context switching!** 🚀