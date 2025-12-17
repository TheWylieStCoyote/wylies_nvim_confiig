# Java Development

> LSP: jdtls (nvim-jdtls) | Formatter: google-java-format | Debugger: java-debug-adapter

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | jdtls (Eclipse JDT.LS via nvim-jdtls) |
| Formatter | google-java-format |
| Debugger | java-debug-adapter |
| Test Runner | java-test |
| TreeSitter | java |

## Features

- Full jdtls integration via nvim-jdtls
- Lombok support
- Code lens (implementations, references)
- Inlay hints
- Hot code replace during debug
- Test discovery and running
- Maven/Gradle support
- Extract variable/constant/method

## Keybindings

### Java-Specific

| Key | Action |
|-----|--------|
| `<leader>jo` | Organize Imports |
| `<leader>jv` | Extract Variable |
| `<leader>jc` | Extract Constant |
| `<leader>jm` | Extract Method (visual) |
| `<leader>jt` | Test Nearest Method |
| `<leader>jT` | Test Class |
| `<leader>jd` | Debug Nearest Test |
| `<leader>jD` | Debug Test Class |
| `<leader>ju` | Update Project Config |
| `<leader>jb` | Build Project |
| `<leader>jr` | Run Main |
| `<leader>jg` | Generate... |

### Debugging (DAP)

| Key | Action |
|-----|--------|
| `<F5>` | Start/Continue |
| `<F9>` | Toggle Breakpoint |
| `<F10>` | Step Over |
| `<F11>` | Step Into |
| `<S-F11>` | Step Out |

## Installation

### Mason Packages
```vim
:MasonInstall jdtls java-debug-adapter java-test google-java-format
```

### System Requirements

**JDK:**
```bash
# Arch
sudo pacman -S jdk-openjdk

# Or use SDKMAN
sdk install java
```

**Build tools:**
```bash
sudo pacman -S maven gradle
```

## Configuration

### jdtls Settings

Enabled features:
- Download sources (Eclipse, Maven)
- Interactive build configuration updates
- Code lens (implementations, references)
- Inlay hints (parameter names)
- Signature help
- Static member completions (JUnit, Mockito)

### Lombok

Lombok is automatically configured via the lombok.jar bundled with jdtls.

### Import Order

```
java
javax
com
org
```

## Debug Configurations

- Hot code replace: auto
- Main class discovery
- Test debugging support

## Usage Examples

### Quick Development
1. `<leader>jo` - Organize imports
2. `<leader>jb` - Build project
3. `<leader>jr` - Run main class

### Testing
1. Place cursor on test method
2. `<leader>jt` - Run test
3. Or `<leader>jd` - Debug test

### Refactoring
1. Select code (visual mode)
2. `<leader>jv` - Extract variable
3. `<leader>jm` - Extract method
4. `<leader>jc` - Extract constant

### Generate Code
1. `<leader>jg` - Open generate menu
2. Choose: constructor, getters, setters, etc.
