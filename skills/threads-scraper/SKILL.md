---
name: threads-scraper
description: Scrape posts from Threads (threads.com) profiles. Handles login, infinite scroll, and post extraction. Use when the user wants to fetch posts from a Threads profile.
allowed-tools: Bash(robot:*), AskUserQuestion, Read
---

# Threads Scraper with `robot`

Threads requires Instagram login to view all posts on a profile. Without login, only the 2 most recent posts are visible.

## Prerequisites

- `robot` CLI must be installed and on PATH (`~/go/bin/robot`)
- Always set PATH: `export PATH="$HOME/go/bin:$PATH"`

## Step 1: Start browser

```bash
export PATH="$HOME/go/bin:$PATH"
# Clean up stale state if needed
rm -f /tmp/robot.pid
robot start
```

If "daemon already running" error occurs:
```bash
robot stop
# If stop fails with "no such process":
rm -f /tmp/robot.pid
robot start
```

## Step 2: Login to Threads

**IMPORTANT: Always ask the user for credentials using AskUserQuestion. Never hardcode or store credentials.**

### Login flow

```bash
# 1. Navigate to login page
robot navigate "https://www.threads.com/login"
# Wait for page load
sleep 2

# 2. Enter credentials (ask user first via AskUserQuestion)
robot type "input[autocomplete='username']" "<USERNAME>"
robot type "input[autocomplete='current-password']" "<PASSWORD>"
sleep 1

# 3. Click login button (use form div[role='button'], NOT button[type='submit'])
robot click "form div[role='button']"

# 4. Wait for redirect (login causes HTTP 500 briefly, this is normal)
sleep 8
```

### Known issues with Threads login

1. **HTTP 500 after login**: Threads often returns a server error page immediately after login. This is expected. Simply navigate away:
   ```bash
   robot navigate "https://www.threads.com/"
   sleep 3
   ```
   The session/cookies are still valid despite the error.

2. **QR code popup**: If you click the wrong element, a QR code popup ("Get the app") may appear. If this happens, re-navigate to the login page instead of trying to close it.

3. **Verify login success**: After login, navigate to home and check for logged-in indicators:
   ```bash
   robot navigate "https://www.threads.com/"
   sleep 3
   robot screenshot
   # Read the screenshot - look for "What's new?" input and "Post" button
   # If "Log in" button is shown at top-right, login failed
   ```

4. **Own profile check**: When viewing your own profile while logged in, the page shows "Edit profile" button instead of "Follow".

## Step 3: Navigate to target profile

```bash
robot navigate "https://www.threads.com/@USERNAME"
sleep 3
```

## Step 4: Extract posts

```bash
robot text
```

### Scrolling for more posts

`robot` does not have a built-in scroll command. To load more posts on infinite-scroll pages:

- **Option A**: Use `robot click` on elements near the bottom of the visible area to trigger scroll behavior.
- **Option B**: Take note that Threads may limit visible posts even when logged in, depending on the profile's post count.

Extract text after each scroll attempt:
```bash
robot text
```

## Step 5: Clean up

```bash
robot stop
```

## CSS Selectors Reference (Threads)

| Element | Selector |
|---------|----------|
| Username input | `input[autocomplete='username']` |
| Password input | `input[autocomplete='current-password']` |
| Login button | `form div[role='button']` |
| Profile tabs | Text-based: Threads, Replies, Media, Reposts |

## Output format

Present extracted posts in a structured format:

```
### Post N (timestamp) - Topic
[Post content]
- Likes: N, Comments: N, Shares: N
```

## Tips

- **Login button selector**: Use `form div[role='button']` not `button[type='submit']` - Threads uses custom div-based buttons.
- **HTTP 500 is normal**: After login, Threads briefly errors. Navigate to any page and the session works.
- **Prefer `text` over `screenshot`**: Text extraction is token-efficient. Only screenshot when debugging layout issues.
- **Always clean up**: Run `robot stop` when finished.
