---
name: browsing-with-robot
description: Automates browser interactions for web browsing, scraping, form filling, screenshots, and UI interaction. Use when the user needs to visit a webpage, check a live site, scrape content, fill forms, take screenshots, or interact with a web UI.
allowed-tools: Bash(robot:*)
---

# Browser Automation with `robot`

## Setup

```bash
# install robot if not on PATH
go install github.com/tmdgusya/robot.git@latest
# or build from source
git clone https://github.com/tmdgusya/robot.git /tmp/robot-build && cd /tmp/robot-build && go build -o /usr/local/bin/robot .
```

## Quick start

```bash
# start headless browser
robot start
# navigate to a page
robot navigate "https://example.com"
# extract page text (prefer over screenshot — saves tokens)
robot text
# interact with elements using CSS selectors
robot click "#my-button"
robot type "#email" "user@test.com"
# screenshot only when you need to see visuals
robot screenshot
# always clean up when done
robot stop
```

## Commands

### Browser lifecycle

```bash
robot start                    # headless default
robot start --headless=false   # visible browser
robot stop                     # always stop when done
robot status                   # current URL, title, state
```

### Navigation & extraction

```bash
robot navigate <url>           # navigate and wait for load
robot text                     # extract visible page text
robot screenshot               # save PNG, returns file path
```

### Interaction

```bash
robot click <selector>         # CSS selector (e.g. #btn, .link, button)
robot type <selector> <text>   # type into input field
```

## Output

All responses are JSON. View screenshots with the Read tool.

```json
{"ok": true, "url": "...", "title": "..."}
{"ok": true, "text": "..."}
{"ok": true, "path": "/tmp/robot/screenshot-1234.png"}
{"ok": false, "error": "...", "suggestion": "..."}
```

## Example: Scrape page content

```bash
robot start
robot navigate "https://example.com"
robot text
robot stop
```

## Example: Fill and submit form

```bash
robot start
robot navigate "https://example.com/form"
robot type "#email" "user@test.com"
robot type "#password" "secret"
robot click "button[type='submit']"
robot text
robot stop
```

## Tips

- **Start first.** "daemon already running" error? Run `robot stop` then `robot start`.
- **Prefer `text` over `screenshot`** — text is token-cheap. Screenshot only for visual layout.
- **Always `robot stop` when finished** to clean up the browser process.
