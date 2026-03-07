# Tiny Inline Diagnostic - Inline Diagnostic Display

Non-disruptive inline diagnostic messages with multiline support.

## Quick Reference

| Component | Value |
|-----------|-------|
| Plugin | rachartier/tiny-inline-diagnostic.nvim |
| Event | LspAttach |
| Preset | modern |

## Keybindings

No custom keybindings. Uses standard diagnostic navigation:

| Key | Action |
|-----|--------|
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

## Features

- Replaces default `virtual_text` diagnostics on LSP attach
- Shows diagnostic source alongside message
- Multiline diagnostic support
- Shows all diagnostics on the current cursor line
- Disabled during insert mode to avoid distraction
- Soft wraps long messages at 30 characters
- 100ms throttle to reduce rendering overhead

## Configuration

### Display Settings

| Setting | Value |
|---------|-------|
| Preset | modern |
| Transparent background | No |
| Show source | Yes |
| Multiline | Enabled (not always shown) |
| All diags on cursorline | Yes |
| Enable in insert mode | No |
| Throttle | 100ms |
| Soft wrap | 30 chars |
| Overflow mode | wrap |

### Highlight Groups

| Element | Highlight |
|---------|-----------|
| Error | DiagnosticError |
| Warn | DiagnosticWarn |
| Info | DiagnosticInfo |
| Hint | DiagnosticHint |
| Arrow | NonText |
| Background | CursorLine |
