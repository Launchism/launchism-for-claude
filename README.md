# Launchism for Claude

A free plugin that changes how Claude works for you:

- **It keeps your decisions.** When you decide something ("the price is $149, not $199"), Claude writes it
  down in your own words, with the date, and checks it before later work, including in a later, separate
  conversation.
- **It has new work checked before you get it.** Before Claude hands you a new file it made, it starts a
  second Claude that hasn't seen any of the work, which tries to find mistakes in it. The first Claude
  fixes what it finds. This happens on its own, inside the same reply.
- **It works from a written plan.** For anything bigger than one task, Claude writes the plan first, with
  "done means" checks you can verify yourself. When work continues in another conversation, it writes a
  handoff, so the next conversation picks up where this one stopped.
- **It reports in plain words.** Where things stand first, then what needs you and how many things, the
  options with what each gives up, its recommendation, how to answer, and the evidence last.
- **It tells Claude to ask before anything leaves your computer:** no email, post, payment or publishing
  without your yes.

## What it reads, writes and sends

- **Writes:** an `ai-notes/` folder inside the folder you're working in (see below). If Claude's own memory
  is switched on, Claude may also add one line there pointing to `ai-notes/`.
- **Reads:** your files in that folder, as Claude already does.
- **Sends:** nothing. The plugin has no server and no account. It's a set of instructions and two small
  checks that run on your computer.
- **Costs:** the plugin is free. The second Claude that checks the work uses more of your Claude usage.

## Install

**In the Claude desktop app** (if you don't use a terminal, this is for you):
1. Open **Customize → Plugins**, then **Add → Add marketplace**. ("Marketplace" here just means a list of
   plugins. This repository is one. You don't need to find Launchism in Anthropic's directory.)
2. Paste `Launchism/launchism-for-claude` and confirm.
3. Add **Launchism** from the list, then start a new conversation in Cowork or the Code tab.

The same steps work on claude.ai, but in a claude.ai chat only the written guides load: no reviewer and
no always-on rules (see "What works where").

**In Claude Code** (Anthropic's coding tool, in a terminal or VS Code), type these two lines:

```
/plugin marketplace add Launchism/launchism-for-claude
/plugin install launchism@launchism
```

Then start a new conversation. Nothing else to set up.

**Which model:** use Sonnet or Opus. In our informal tests, Haiku, the smallest model, followed the
plugin's rules less reliably.

## What works where

- **Claude Code** (terminal, VS Code, the desktop app's Code tab): everything.
- **Cowork** (the desktop app's agent): everything loads. Whether the checks also run for Cowork tasks that
  run in the cloud isn't documented.
- **claude.ai chat:** only the written guides load. The always-on rules and the reviewer don't run there.
- **Windows:** not tested yet. Two small parts of the plugin need Git Bash, a free Windows tool.

## Does it work?

We tested it with and without the plugin, on Claude Sonnet, with no other plugins or settings.

| What we checked | With the plugin | Without it |
|---|---|---|
| A decision mentioned in passing is applied in a later, separate conversation (5 tasks, 3 runs each) | 14 of 15 | 9 of 15 * |
| A decision is written down in your exact words, with the date | 3 of 3 | 0 of 3 |
| A plan gets written with "done means" checks | 3 of 3 | 0 of 3 |
| A second Claude checks a new file before it's handed over | 3 of 3 | not part of Claude |

\* Claude's own built-in memory was on for this test. The 9 is probably flattered: our run saved each first
conversation's log inside the project folder, and once plain Claude found the decision there. The published
test (`benchmarks/cross-session/`) keeps logs outside. Graded strictly, the plain result is 7 of 15.

**What it doesn't change:** on 20 single tasks with a planted mistake (a duplicate invoice, a reversed
decision and so on), Claude caught 54 of 60 mistakes on its own and 57 of 60 with the plugin. Today's Claude
already catches most simple mistakes in one go. The plugin's value is in work that runs over time.

These are our own tests, not an industry benchmark. They're all in this repo (`evals/`,
`benchmarks/mistakes/`, `benchmarks/cross-session/`), so you can run them yourself.

## Where it keeps things

Everything the plugin writes goes into an `ai-notes/` folder inside the folder you're working in:

| File | What's in it |
|---|---|
| `ai-notes/decisions.md` | Your decisions, word for word, with dates |
| `ai-notes/decided-without-you.md` | Choices Claude made on its own, each with a reason and how to reverse it |
| `ai-notes/lessons/` | Lessons from mistakes, so they aren't repeated. It starts with three examples, which Claude deletes once you have five real lessons |
| `ai-notes/facts/` | Facts Claude will need again |
| `ai-notes/plans/`, `ai-notes/handoffs/`, `ai-notes/walks/` | Plans, handoffs between conversations, and short checklists for you to try the result |

They're plain text files you can open, edit or delete. They stay if you remove the plugin.

## Keep Claude's own protections on

In the mode Claude Code starts in by default (terminal and VS Code, version 2.1.283 or later), Claude Code
itself blocks force-pushing over saved work, irreversibly destroying files that existed before the
session, and sending sensitive data out. It also asks or refuses before deleting your home folder or the whole disk, though Anthropic notes the
check can miss some commands.
This plugin doesn't replace any of that. Two tips:

- **Don't use "bypass permissions" mode.** Anthropic's own docs say it "offers no protection against prompt
  injection or unintended actions."
- **To limit where Claude can write and what it can reach online,** type `/sandbox` in Claude Code.

## Known limits

- **The check at the end of each reply only looks at new files.** If Claude only edits existing files, it
  doesn't send them to the reviewer automatically (the written rules still ask Claude to do so).
- **That check can miss a file** created in the very last second of a reply, because Claude Code writes its
  log a moment behind. When it can't see something, it lets the reply through rather than block you.
- **Asking before sending is an instruction, not a lock.** Claude follows it, but nothing technically stops
  a send. Claude Code's own permission prompts are the lock.
- **It doesn't add knowledge.** It changes how Claude works, not what Claude knows.

## Update, switch off, remove

**If you installed in the desktop app or on claude.ai:** under **Customize → Plugins**, use **Check for
updates**, the **Disable plugin** toggle, or **Remove**.

**If you installed in Claude Code:**
- **Update:** open `/plugin`, go to **Installed**, choose Launchism and **Update now**, or run
  `claude plugin update launchism@launchism` in a terminal. Updates aren't automatic unless you turn them on
  for this list under `/plugin` → Marketplaces.
- **Switch off:** `/plugin disable launchism@launchism`. Switch it on again with `enable`.
- **Remove:** `/plugin uninstall launchism@launchism`.

Either way, your `ai-notes/` folder stays.

## Who made this

Launchism, by Tzvika Besor. It's how I run my own team of AI agents, packaged so you can use it too.

Something broke, or the plugin got in your way? Open an issue on this repository.

## Licence

MIT. See `LICENSE`.

Launchism is not affiliated with, endorsed by or sponsored by Anthropic. "Claude" and "Claude Code" are
trademarks of Anthropic, used here only to say what this plugin works with.
