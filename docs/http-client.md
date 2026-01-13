# HTTP Client

Execute HTTP requests from `.http` files using rest.nvim.

## Quick Reference

| Feature | Tool |
|---------|------|
| Plugin | rest.nvim |
| File Type | `.http` |
| Formatter | jq (JSON), tidy (HTML) |

## Keybindings

| Key | Action | Context |
|-----|--------|---------|
| `<leader>rr` | Run request under cursor | .http files |
| `<leader>rl` | Re-run last request | Any file |
| `<leader>re` | Show current environment | .http files |
| `<leader>rE` | Select environment | .http files |
| `<Enter>` | Run request under cursor | .http files |
| `<leader>rp` | Preview request | .http files |

## File Format

Create a file with `.http` extension:

```http
### Request Name (comment)
METHOD URL
Headers

Body
```

## Example Requests

### GET Request

```http
### Get all users
GET https://jsonplaceholder.typicode.com/users
```

### GET with Headers

```http
### Get authenticated resource
GET https://api.example.com/profile
Authorization: Bearer your-token-here
Accept: application/json
```

### POST with JSON Body

```http
### Create a new post
POST https://jsonplaceholder.typicode.com/posts
Content-Type: application/json

{
  "title": "Hello World",
  "body": "This is my first post",
  "userId": 1
}
```

### PUT Request

```http
### Update a post
PUT https://jsonplaceholder.typicode.com/posts/1
Content-Type: application/json

{
  "id": 1,
  "title": "Updated Title",
  "body": "Updated body content",
  "userId": 1
}
```

### DELETE Request

```http
### Delete a post
DELETE https://jsonplaceholder.typicode.com/posts/1
```

### Form Data

```http
### Submit form
POST https://httpbin.org/post
Content-Type: application/x-www-form-urlencoded

username=john&password=secret
```

## Environment Variables

### Create Environment File

Create `.env` in your project root:

```env
# .env
API_URL=https://api.example.com
API_KEY=your-secret-key
USER_ID=123
```

### Use Variables in Requests

```http
### Get user profile
GET {{API_URL}}/users/{{USER_ID}}
Authorization: Bearer {{API_KEY}}
```

### Multiple Environments

Create different env files:

```
.env           # Default
.env.local     # Local development
.env.staging   # Staging server
.env.prod      # Production
```

Select environment with `<leader>rE`.

## Example Workflow

### 1. Create HTTP File

```
1. Create requests.http in your project
   :e requests.http

2. Add your requests
   ### Health Check
   GET http://localhost:3000/health

   ### Get Users
   GET http://localhost:3000/api/users
   Authorization: Bearer {{API_KEY}}
```

### 2. Execute Requests

```
1. Place cursor on a request
2. Press <leader>rr or <Enter>
3. Response appears in split window
```

### 3. View Response

The response window shows:
- Status code and time
- Response headers
- Formatted body (JSON auto-formatted with jq)
- Curl command used

### 4. Re-run Last Request

```
1. Make changes to your API
2. Press <leader>rl from anywhere
3. Last request runs again
```

## Complete Example File

```http
# api-tests.http
# API Testing Collection

### Variables (from .env file)
# API_URL=http://localhost:3000
# API_KEY=dev-token-123

#####################################
# Authentication
#####################################

### Login
POST {{API_URL}}/auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123"
}

### Get current user
GET {{API_URL}}/auth/me
Authorization: Bearer {{API_KEY}}

#####################################
# Users API
#####################################

### List all users
GET {{API_URL}}/users
Authorization: Bearer {{API_KEY}}

### Get single user
GET {{API_URL}}/users/1
Authorization: Bearer {{API_KEY}}

### Create user
POST {{API_URL}}/users
Content-Type: application/json
Authorization: Bearer {{API_KEY}}

{
  "name": "John Doe",
  "email": "john@example.com"
}

### Update user
PATCH {{API_URL}}/users/1
Content-Type: application/json
Authorization: Bearer {{API_KEY}}

{
  "name": "Jane Doe"
}

### Delete user
DELETE {{API_URL}}/users/1
Authorization: Bearer {{API_KEY}}

#####################################
# File Upload
#####################################

### Upload file (requires multipart support)
POST {{API_URL}}/upload
Content-Type: multipart/form-data; boundary=boundary

--boundary
Content-Disposition: form-data; name="file"; filename="test.txt"
Content-Type: text/plain

Hello, World!
--boundary--
```

## Response Formatting

| Content Type | Formatter |
|--------------|-----------|
| JSON | jq (auto-formatted) |
| HTML | tidy |
| XML | tidy |
| Others | Raw |

## Tips

### Quick API Testing

```
1. Create a scratch.http file
2. Write quick requests
3. <Enter> to execute
4. Iterate rapidly
```

### Save Common Requests

```
1. Create project-specific .http files
2. Commit to version control
3. Share with team
4. Document your API
```

### Debug API Issues

```
1. Check the curl command in response
2. Copy and run in terminal if needed
3. Compare with expected behavior
```

## Troubleshooting

### Request Not Running

- Ensure cursor is on a request line (METHOD URL)
- Check file extension is `.http`
- Verify URL is valid

### Variables Not Expanding

- Check `.env` file exists in project root
- Verify variable names match exactly
- Use `<leader>re` to see current environment

### JSON Not Formatted

- Ensure `jq` is installed: `which jq`
- Install: `sudo pacman -S jq` or `brew install jq`

### SSL Errors

- For self-signed certs, you may need to skip verification
- Check your API's SSL configuration
