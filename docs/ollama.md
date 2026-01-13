# Ollama - Local AI

Local LLM integration for code generation, explanation, and review.

## Quick Reference

| Feature | Tool |
|---------|------|
| Plugin | ollama.nvim |
| Backend | Ollama (local) |
| Default Model | codellama:13b |

## Requirements

### 1. Install Ollama

```bash
# Linux/macOS
curl -fsSL https://ollama.com/install.sh | sh

# Or via package manager
# Arch: yay -S ollama
# Homebrew: brew install ollama
```

### 2. Pull a Model

```bash
# Code-focused models (recommended)
ollama pull codellama        # 7B, good balance
ollama pull codellama:13b    # Larger, better quality
ollama pull deepseek-coder   # Alternative code model

# General models
ollama pull llama2           # General purpose
ollama pull mistral          # Fast and capable
```

### 3. Start Server

```bash
# Ollama usually auto-starts, but if needed:
ollama serve
```

## Keybindings

| Key | Mode | Action |
|-----|------|--------|
| `<leader>oo` | n | Open Ollama prompt |
| `<leader>oO` | n | Select model |
| `<leader>og` | n, v | Generate code |
| `<leader>oe` | n, v | Explain code |
| `<leader>or` | n, v | Review code |
| `<leader>of` | n, v | Fix code |
| `<leader>ot` | n, v | Add tests |
| `<leader>od` | n, v | Add documentation |
| `<leader>os` | n, v | Simplify code |
| `<leader>ga` | n | Git add (stage) current file |
| `<leader>om` | n | Generate commit message |

## Usage

### Generate Code

```
1. Type a comment describing what you want
   // function to calculate fibonacci

2. Select the comment (V to select line)

3. Press <leader>og

4. AI generates the code below
```

### Explain Code

```
1. Select code you don't understand

2. Press <leader>oe

3. AI explains what it does
   - Line by line breakdown
   - Algorithm explanation
   - Complexity analysis
```

### Review Code

```
1. Select code to review

2. Press <leader>or

3. AI provides:
   - Bug identification
   - Performance issues
   - Best practice suggestions
   - Security concerns
```

### Fix Code

```
1. Select buggy code

2. Press <leader>of

3. AI returns fixed version
   - Corrects bugs
   - Handles edge cases
   - Maintains style
```

### Add Tests

```
1. Select function to test

2. Press <leader>ot

3. AI generates tests
   - Unit tests
   - Edge cases
   - Appropriate framework
```

### Add Documentation

```
1. Select code to document

2. Press <leader>od

3. AI adds:
   - Function docstrings
   - Parameter descriptions
   - Return value docs
   - Usage examples
```

### Simplify Code

```
1. Select complex code

2. Press <leader>os

3. AI refactors for:
   - Readability
   - Maintainability
   - Modern patterns
```

### Generate Commit Message

```
1. Stage your changes
   <leader>ga  (stage current file)
   - or -
   git add <files>

2. Press <leader>om

3. AI generates commit message in floating window:
   - Conventional commits format (feat:, fix:, etc.)
   - Subject line under 50 chars
   - Bullet points for details

4. Edit the message if needed (buffer is editable)

5. Press Enter to commit, or q/Esc to cancel
```

#### Commit Window Keybindings

| Key | Action |
|-----|--------|
| `<CR>` | Commit with message |
| `q` | Cancel |
| `<Esc>` | Cancel |
| Edit normally | Modify message before committing |

## Example Workflows

### Writing New Functions

```python
# 1. Write description
# Function to parse CSV file and return list of dictionaries

# 2. Select comment, press <leader>og

# 3. AI generates:
def parse_csv(filepath):
    """Parse CSV file and return list of dictionaries."""
    import csv
    with open(filepath, 'r') as f:
        reader = csv.DictReader(f)
        return list(reader)
```

### Understanding Legacy Code

```javascript
// 1. Select confusing code
const r = a.reduce((p, c) => (p[c.t] = (p[c.t] || 0) + c.v, p), {});

// 2. Press <leader>oe

// 3. AI explains:
// This code groups items by type (t) and sums their values (v)
// - Uses reduce to iterate through array 'a'
// - Creates an object with types as keys
// - Accumulates values for each type
```

### Code Review

```rust
// 1. Select function
fn process(data: &str) -> String {
    data.to_string()
}

// 2. Press <leader>or

// 3. AI suggests:
// - Consider returning &str to avoid allocation
// - Add error handling for empty strings
// - Document the function's purpose
```

### Git Commit Messages

```bash
# 1. Stage current file
<leader>ga

# 2. Generate commit message
<leader>om

# 3. Floating window appears with AI-generated message:
┌─ Commit Message (Enter=commit, q/Esc=cancel) ─┐
│ feat: Add commit message generation           │
│                                               │
│ - New keybinding <leader>om for staged changes│
│ - Uses conventional commits format            │
│ - Displays in floating window for review      │
└───────────────────────────────────────────────┘

# 4. Edit if needed, then:
#    - Press Enter to commit
#    - Press q or Esc to cancel
```

## Model Selection

### Change Default Model

Edit `lua/plugins/ollama.lua`:

```lua
opts = {
  model = "deepseek-coder",  -- Change from codellama
}
```

### Switch Models On-the-fly

```
<leader>oO - Opens model selector
Select from installed models
```

### Recommended Models

| Model | Size | Best For |
|-------|------|----------|
| codellama | 7B | General coding |
| codellama:13b | 13B | Complex tasks |
| deepseek-coder | 6.7B | Code completion |
| mistral | 7B | Fast responses |
| llama2 | 7B | General questions |

## Custom Prompts

### Adding New Prompts

Edit `lua/plugins/ollama.lua`:

```lua
prompts = {
  -- Add your own
  Optimize_Code = {
    prompt = "Optimize this code for performance:\n```$ftype\n$sel\n```",
    action = "display",
  },
}
```

### Prompt Variables

| Variable | Description |
|----------|-------------|
| `$sel` | Selected text |
| `$ftype` | Current filetype |
| `$buf` | Buffer contents |
| `$line` | Current line |

## Tips

### Offline Development

Ollama runs completely locally:
- No internet required after model download
- Data never leaves your machine
- Works on airplane, VPN, etc.

### GPU Acceleration

If you have NVIDIA GPU:
```bash
# Ollama auto-detects CUDA
# Check with:
ollama run codellama "test"
# Look for "using GPU" in output
```

### Response Quality

For better responses:
- Select complete functions, not fragments
- Include context (imports, types)
- Use larger models for complex tasks

### Combine with Copilot

```
- Use Copilot for inline completion
- Use Ollama for explanations/reviews
- Ollama works offline, Copilot needs internet
```

## Troubleshooting

### Connection Refused

```bash
# Check if Ollama is running
curl http://localhost:11434/api/tags

# Start if needed
ollama serve
```

### Model Not Found

```bash
# List installed models
ollama list

# Pull if missing
ollama pull codellama
```

### Slow Responses

- Use smaller model (7B vs 13B)
- Check GPU is being used
- Close other GPU-intensive apps
- Consider CPU-only mode if no GPU

### Out of Memory

```bash
# Use quantized model
ollama pull codellama:7b-q4_0

# Or use smaller model
ollama pull phi
```

## Commands

| Command | Action |
|---------|--------|
| `:Ollama` | Open prompt |
| `:OllamaModel` | Select model |
| `:OllamaServe` | Start server |
| `:OllamaServeStop` | Stop server |
