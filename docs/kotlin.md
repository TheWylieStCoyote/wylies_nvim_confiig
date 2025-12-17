# Kotlin Development

> LSP: kotlin-language-server | Formatter: ktlint | Linter: ktlint | Debugger: kotlin-debug-adapter

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | kotlin-language-server |
| Formatter | ktlint |
| Linter | ktlint |
| Debugger | kotlin-debug-adapter |
| TreeSitter | kotlin |

## Features

- Full Kotlin language server support
- Type hints and parameter hints
- Snippet completions
- Gradle integration
- Android support
- Maven support

## Keybindings

### Kotlin-Specific

| Key | Action |
|-----|--------|
| `<leader>kr` | Run Script |
| `<leader>kR` | Compile & Run |
| `<leader>ki` | Kotlin REPL |

### Gradle

| Key | Action |
|-----|--------|
| `<leader>kb` | Gradle Build |
| `<leader>kB` | Gradle Build (refresh) |
| `<leader>kc` | Gradle Clean |
| `<leader>kt` | Gradle Test |
| `<leader>kT` | Gradle Test (filtered) |
| `<leader>kx` | Gradle Run |
| `<leader>kd` | Gradle Dependencies |
| `<leader>kD` | Gradle Tasks |

### Android

| Key | Action |
|-----|--------|
| `<leader>kaa` | Android Assemble Debug |
| `<leader>kar` | Android Assemble Release |
| `<leader>kai` | Android Install Debug |
| `<leader>kat` | Android Connected Tests |

### Maven

| Key | Action |
|-----|--------|
| `<leader>kmb` | Maven Compile |
| `<leader>kmt` | Maven Test |
| `<leader>kmx` | Maven Exec |

### Other

| Key | Action |
|-----|--------|
| `<leader>kf` | Format (ktlint) |
| `<leader>kF` | Format All |
| `<leader>ka` | Code Actions |
| `<leader>kh` | Hover Info |
| `<leader>kn` | New Gradle Project |

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
:MasonInstall kotlin-language-server ktlint kotlin-debug-adapter
```

### System Requirements

**Kotlin:**
```bash
# Arch
sudo pacman -S kotlin

# Or via SDKMAN
sdk install kotlin
```

**Gradle:**
```bash
sudo pacman -S gradle
```

## Configuration

### LSP Settings

- JVM target: 17
- Type hints enabled
- Parameter hints enabled
- Chain hints enabled
- Snippet completions enabled
- Indexing enabled
- External sources with KLS scheme

### .editorconfig

```ini
[*.kt]
indent_size = 4
max_line_length = 120
```

## Usage Examples

### Gradle Project
1. `<leader>kb` - Build project
2. `<leader>kt` - Run tests
3. `<leader>kx` - Run application

### Android Development
1. `<leader>kaa` - Assemble debug APK
2. `<leader>kai` - Install on device
3. `<leader>kat` - Run instrumented tests

### Quick Script
1. Create `.kts` file
2. `<leader>kr` - Run as script
