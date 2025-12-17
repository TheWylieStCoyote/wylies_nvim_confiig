# TypeScript/JavaScript Development

> LSP: vtsls | Formatter: prettier | Linter: eslint_d | Debugger: js-debug-adapter

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | vtsls (faster than tsserver) |
| Formatter | prettier |
| Linter | eslint_d |
| Debugger | js-debug-adapter (pwa-node) |
| TreeSitter | javascript, typescript, tsx, jsdoc, json, jsonc |

## Features

- Fast TypeScript server (vtsls)
- Complete function calls
- Auto-update imports on file move
- Inlay hints (types, parameters, return types)
- Server-side fuzzy matching
- Organize imports
- Fix all issues
- File references
- Jest/Mocha debugging

## Keybindings

### TypeScript-Specific

| Key | Action |
|-----|--------|
| `<leader>to` | Organize Imports |
| `<leader>tu` | Remove Unused Imports |
| `<leader>ti` | Add Missing Imports |
| `<leader>tf` | Fix All |
| `<leader>tD` | Go to Source Definition |
| `<leader>tR` | File References |
| `<leader>tr` | Rename File |
| `<leader>tn` | npm run |
| `<leader>tt` | npm test |

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
:MasonInstall vtsls prettier eslint_d js-debug-adapter
```

### System Requirements

**Node.js:**
```bash
# Arch
sudo pacman -S nodejs npm

# Or use nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install node
```

## Configuration

### vtsls Settings

Enabled features:
- Complete function calls
- Move to file code action
- Auto workspace TypeScript SDK
- Server-side fuzzy matching
- Update imports on file move
- Inlay hints (enum values, return types, parameter names/types)

### .prettierrc

Create in project root:
```json
{
  "semi": true,
  "singleQuote": true,
  "tabWidth": 2,
  "trailingComma": "es5"
}
```

### .eslintrc.js

```javascript
module.exports = {
  extends: ['eslint:recommended', 'plugin:@typescript-eslint/recommended'],
  parser: '@typescript-eslint/parser',
  plugins: ['@typescript-eslint'],
  root: true,
};
```

## Debug Configurations

Available configurations:
1. **Launch file** - Debug current file
2. **Attach** - Attach to running process
3. **Debug Jest Tests** - Run Jest in debug mode
4. **Debug Mocha Tests** - Run Mocha in debug mode

## Usage Examples

### Import Management
1. Write code with missing imports
2. `<leader>ti` - Add missing imports
3. `<leader>to` - Organize imports
4. `<leader>tu` - Remove unused imports

### Quick Fixes
1. `<leader>tf` - Fix all auto-fixable issues
2. Uses both TypeScript and ESLint fixes

### Debug Node.js App
1. `<F9>` - Set breakpoints
2. `<F5>` - Start debugging
3. Select "Launch file"

### Debug Jest Tests
1. `<F9>` - Set breakpoints in test file
2. `<F5>` - Start debugging
3. Select "Debug Jest Tests"

### Rename File with Import Updates
1. `<leader>tr` - Rename file
2. All imports across project are updated
