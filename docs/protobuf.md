# Protocol Buffers (Protobuf) Development

> LSP: bufls | Formatter: buf | Linter: buf lint, protolint

## Quick Reference

| Component | Tool |
|-----------|------|
| LSP | buf-language-server |
| Formatter | buf format |
| Linter | buf lint, protolint |
| TreeSitter | proto |

## Features

- Buf language server
- Buf CLI integration
- Breaking change detection
- Multi-language code generation
- Buf Schema Registry (BSR)
- Protolint linting
- Service templates

## Keybindings

### Buf Commands (`<leader>P...`)

| Key | Action |
|-----|--------|
| `<leader>Pb` | Buf Build |
| `<leader>Pl` | Buf Lint |
| `<leader>PL` | Buf Lint (file) |
| `<leader>Pf` | Buf Format |
| `<leader>PF` | Buf Format (file) |

### Breaking Changes

| Key | Action |
|-----|--------|
| `<leader>PB` | Breaking Changes (vs main) |
| `<leader>PBt` | Breaking Changes (vs tag) |

### Code Generation

| Key | Action |
|-----|--------|
| `<leader>Pg` | Generate Code |
| `<leader>PG` | Generate (template) |

### Protoc (Direct)

| Key | Action |
|-----|--------|
| `<leader>Ppc` | Protoc (Go) |
| `<leader>Ppp` | Protoc (Python) |
| `<leader>Ppj` | Protoc (JS) |
| `<leader>Ppr` | Protoc (Rust) |

### Protolint

| Key | Action |
|-----|--------|
| `<leader>Pll` | Protolint |
| `<leader>Plf` | Protolint Fix |

### BSR (Buf Schema Registry)

| Key | Action |
|-----|--------|
| `<leader>Prp` | Push to BSR |
| `<leader>Prd` | Update Dependency |

### Init/Config

| Key | Action |
|-----|--------|
| `<leader>Pi` | Init Module |
| `<leader>PI` | Create buf.yaml |
| `<leader>PIG` | Create buf.gen.yaml |

### Templates

| Key | Action |
|-----|--------|
| `<leader>Pn` | New Service |

### LSP

| Key | Action |
|-----|--------|
| `<leader>Pa` | Code Actions |
| `<leader>Ph` | Hover Info |

## Installation

### Mason Packages
```vim
:MasonInstall buf buf-language-server protolint
```

### System Requirements

```bash
# Arch - buf
yay -S buf

# Or via npm
npm install -g @bufbuild/buf

# Protoc (if needed)
sudo pacman -S protobuf

# Language-specific plugins
# Go
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

# Python
pip install grpcio-tools
```

## Configuration

### buf.yaml

```yaml
version: v1
name: buf.build/your-org/your-repo
deps: []
lint:
  use:
    - DEFAULT
  except:
    - PACKAGE_VERSION_SUFFIX
breaking:
  use:
    - FILE
```

### buf.gen.yaml

```yaml
version: v1
managed:
  enabled: true
  go_package_prefix:
    default: github.com/your-org/your-repo/gen
plugins:
  # Go
  - plugin: buf.build/protocolbuffers/go
    out: gen/go
    opt: paths=source_relative
  - plugin: buf.build/grpc/go
    out: gen/go
    opt: paths=source_relative
  # Python
  - plugin: buf.build/protocolbuffers/python
    out: gen/python
  # TypeScript
  - plugin: buf.build/bufbuild/es
    out: gen/ts
```

### .protolint.yaml

```yaml
lint:
  rules:
    remove:
      - ENUM_FIELD_NAMES_UPPER_SNAKE_CASE
  rules_option:
    max_line_length:
      max_chars: 120
```

## Service Template

Generated with `<leader>pn`:
```protobuf
syntax = "proto3";

package user.v1;

option go_package = "github.com/your-org/your-repo/gen/user/v1;userv1";

// UserService provides ...
service UserService {
  rpc GetUser(GetUserRequest) returns (GetUserResponse) {}
  rpc ListUsers(ListUsersRequest) returns (ListUsersResponse) {}
  rpc CreateUser(CreateUserRequest) returns (CreateUserResponse) {}
  rpc UpdateUser(UpdateUserRequest) returns (UpdateUserResponse) {}
  rpc DeleteUser(DeleteUserRequest) returns (DeleteUserResponse) {}
}

message User {
  string id = 1;
  string name = 2;
}

message GetUserRequest {
  string id = 1;
}

message GetUserResponse {
  User user = 1;
}
// ... more messages
```

## Usage Examples

### Development Workflow
1. Write proto file
2. `<leader>Pl` - Lint
3. `<leader>Pf` - Format
4. `<leader>Pg` - Generate code

### Breaking Change Check
1. `<leader>PB` - Compare against main
2. `<leader>PBt` - Compare against tag

### New Service
1. `<leader>Pn` - Generate service template
2. Edit messages and RPCs
3. `<leader>Pg` - Generate stubs

### Buf Setup
1. `<leader>Pi` - Init module
2. `<leader>PI` - Create buf.yaml
3. `<leader>PIG` - Create buf.gen.yaml
