# browsing-with-robot

A [Claude Code](https://docs.anthropic.com/en/docs/claude-code) plugin that gives Claude browser automation superpowers — web browsing, scraping, form filling, screenshots, and UI interaction.

## Prerequisites

You need the `robot` CLI installed and available on your PATH:

```bash
go install github.com/tmdgusya/robot@latest
```

## Install

In Claude Code, run these commands:

```
/plugin marketplace add tmdgusya/browsing-with-robot
/plugin install browsing-with-robot@browsing-with-robot-marketplace
```

## Usage

Once installed, just ask Claude Code to do browser tasks in natural language:

- "Go to https://example.com and grab the page content"
- "Take a screenshot of https://example.com"
- "Fill out the login form on https://example.com with these credentials"
- "Check if my site is showing the right content"
- "Scrape the pricing table from this page"

Claude will automatically use the skill when your request involves web browsing or interaction.

## What it can do

| Capability | Example |
|---|---|
| **Browse pages** | Navigate to any URL and extract text |
| **Take screenshots** | Capture full-page PNGs for visual inspection |
| **Click elements** | Click buttons, links, and other elements via CSS selectors |
| **Fill forms** | Type into input fields and submit forms |
| **Scrape content** | Extract visible page text (token-efficient) |

## Commands reference

The skill uses the `robot` CLI under the hood:

```bash
robot start                    # start headless browser
robot start --headless=false   # start visible browser
robot navigate <url>           # go to a page
robot text                     # extract visible text
robot screenshot               # capture screenshot
robot click <selector>         # click an element
robot type <selector> <text>   # type into a field
robot status                   # check browser state
robot stop                     # clean up browser
```

## License

MIT
