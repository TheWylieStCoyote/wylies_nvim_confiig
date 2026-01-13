# TypeScript/JavaScript Development

> LSP: vtsls | Formatter: prettier | Linter: eslint_d | Debugger: js-debug-adapter

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | vtsls (faster than tsserver) |
| Formatter | prettier |
| Linter | eslint_d |
| Debugger | js-debug-adapter (pwa-node, pwa-chrome) |
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
- Jest/Vitest/Mocha debugging
- Chrome browser debugging

## Keybindings (`<leader>j...`)

### Import Management

| Key | Action |
|-----|--------|
| `<leader>jI` | Organize Imports |
| `<leader>ju` | Remove Unused Imports |
| `<leader>ji` | Add Missing Imports |

### Code Fixes

| Key | Action |
|-----|--------|
| `<leader>jf` | Fix All (TS + ESLint) |
| `<leader>jl` | ESLint Fix All |

### Navigation

| Key | Action |
|-----|--------|
| `<leader>jD` | Go to Source Definition |
| `<leader>jR` | File References |
| `<leader>jr` | Rename File (updates imports) |

### Type Checking

| Key | Action |
|-----|--------|
| `<leader>jc` | Type Check (tsc --noEmit) |
| `<leader>jC` | Type Check Watch Mode |

### Run & Build

| Key | Action |
|-----|--------|
| `<leader>jx` | Run File (tsx/node) |
| `<leader>jn` | npm run |
| `<leader>jt` | npm test |
| `<leader>jb` | npm build |
| `<leader>jd` | npm dev |

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

**For running TypeScript files:**
```bash
npm install -g tsx
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

Available configurations (select with `<F5>`):

### Node.js
| Config | Description |
|--------|-------------|
| Launch File | Debug current file |
| Attach to Process | Attach to running Node process |

### Test Runners
| Config | Description |
|--------|-------------|
| Debug Jest Tests | Run Jest in debug mode |
| Debug Vitest Tests | Run Vitest in debug mode |
| Debug Mocha Tests | Run Mocha in debug mode |

### Browser
| Config | Description |
|--------|-------------|
| Launch Chrome | Open URL in Chrome with debugging |
| Attach to Chrome | Attach to Chrome (start with `--remote-debugging-port=9222`) |

## Usage Examples

### Import Management
1. Write code with missing imports
2. `<leader>ji` - Add missing imports
3. `<leader>jI` - Organize imports
4. `<leader>ju` - Remove unused imports

### Quick Fixes
1. `<leader>jf` - Fix all auto-fixable issues (TS + ESLint)
2. `<leader>jl` - Fix ESLint issues only

### Type Check Project
1. `<leader>jc` - Run tsc type checker
2. View errors in terminal
3. Or use `<leader>jC` for watch mode

### Run TypeScript File
1. Open a `.ts` file
2. `<leader>jx` - Runs with `npx tsx`

### Debug Node.js App
1. `<F9>` - Set breakpoints
2. `<F5>` - Start debugging
3. Select "Launch File"

### Debug Vitest Tests
1. `<F9>` - Set breakpoints in test file
2. `<F5>` - Start debugging
3. Select "Debug Vitest Tests"

### Debug in Browser
1. Start your dev server (`<leader>jd`)
2. `<F9>` - Set breakpoints
3. `<F5>` - Select "Launch Chrome"
4. Enter URL (default: http://localhost:3000)

### Rename File with Import Updates
1. `<leader>jr` - Rename file
2. Enter new filename
3. All imports across project are updated
