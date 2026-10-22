---
name: memory
description: Keep the user's decisions, the lessons from mistakes, and the facts that matter in plain files in the project's ai-notes folder, and read them before acting, so work doesn't start blank and mistakes aren't repeated.
when_to_use: When the user says "I decided", "let's go with", "from now on", "remember that", "don't do that again" or states a preference; at the start of substantial work; when something went wrong and the cause is understood; when you learn a fact you'll need again; when a decision or fact changes; and before quoting anyone.
---

# Memory, lessons and decisions

## Why this exists

Every session starts blank unless something carries the work forward. Without that, the AI repeats a
mistake it already made, reopens a question the user already settled, or quotes the user wrongly. This
skill keeps those things in plain files the user can open, read and correct. They live in the project, so
they travel with it, and they stay if the plugin is removed.

## Where things live

All of it is in the `ai-notes/` folder in the project. Create the folder and files the first time you need
them. If Claude's built-in memory is on, `ai-notes/` is still the home for decisions, lessons
and facts: keep at most a one-line pointer to it in the built-in memory, not a second copy.

| File | What goes in it |
|---|---|
| `ai-notes/decisions.md` | The user's decisions, word for word, with the date and what they were about |
| `ai-notes/decided-without-you.md` | Decisions you made alone, each with a reason and how to reverse it (see the `reporting` skill) |
| `ai-notes/lessons/` | One lesson per file, from a mistake whose cause is understood |
| `ai-notes/facts/` | One fact per file that you'll need again: about the user, the project, or where something is |
| `ai-notes/tried-and-rejected.md` | Approaches tried and dropped, with why, so nobody tries them again blind |
| `ai-notes/INDEX.md` | One line per lesson and fact file: its title, and a hook saying when it matters |

## Read before acting

At the start of substantial work, read `ai-notes/INDEX.md`, `ai-notes/decisions.md` and
`ai-notes/tried-and-rejected.md`. Open every lesson or fact file whose hook touches the work. A lesson you didn't read can't stop the mistake it records.

## Recording the user's decisions

When the user decides something, add it to `ai-notes/decisions.md` straight away:

```
## 2026-03-14 · Welcome email sender
> "own address. replies matter more than the extra 15 minutes"

What it was about: whether the course welcome email comes from their address or the platform's.
My reading: use their own address for all course emails (my reading, not their words).
```

- **Paste the user's words; never retype them from memory.** Retyping reshapes a quote toward what you
  wanted it to say. Mark every cut with "…", and don't cut anything that changes the meaning.
- **Keep the scope.** Record what the decision was about. A comment about one thing ("this logo feels too
  busy") is not a general rule ("never use busy designs"). If you generalise, mark it as your reading,
  never as their rule.
- **Keep the verb.** "They recommended" is not "they decided". Record what kind of statement it was.
- **Never write "their words" for something you didn't paste.**
- **The date is the date it was said,** written in full (2026-03-14, not "yesterday"). Don't write
  weekdays, and don't turn "Friday" or "next week" into a date in your head, because models get this
  wrong. If you need the date, get it from the computer (for example the `date` command), and mark it as
  your reading.

## Lessons

Write a lesson when something went wrong and you understand why. One lesson per file in
`ai-notes/lessons/`:

```
---
title: Short name of the lesson
when: One line saying when it matters
---
The rule, in one or two sentences.

**Why:** what happened, with the date, and what it cost.
**How to apply:** what to do differently, concretely.
```

Add a line to `ai-notes/INDEX.md` for it. Before writing a new lesson, check whether an existing one already
covers it; if so, update that one.

### The starter examples

In a project with an `ai-notes/` folder, the plugin copies three example lessons into `ai-notes/lessons/`
at the start of a session. If they're missing, copy them yourself from `${CLAUDE_SKILL_DIR}/examples/`
(this skill's own `examples/` folder). List them in the index. They show the
user and you the shape. Each one's title starts with "EXAMPLE:".

**Once the user has 5 real lessons, delete the example files and their lines in the index.** Real lessons
are worth more than examples, and examples left lying around get mistaken for real ones. Check this every
time you write a lesson: count the lesson files whose title doesn't start with "EXAMPLE:". At 5 or more,
delete the examples.

## Tried and rejected

When an approach is tried and dropped, add an entry to `ai-notes/tried-and-rejected.md`, so nobody tries it
again blind:

```
- 2026-03-20 · Posting the course in three Facebook groups · Dropped: two removed the post as promotion,
  one got no clicks in a week · Would revisit if: a group admin invites it
```

## Facts

One fact per file in `ai-notes/facts/`, with the same three parts as a lesson: the fact, why it matters,
and how to apply it. Facts are about the user (role, preferences), the project (goals, deadlines,
constraints that aren't written elsewhere) and references (where something lives: a folder, a dashboard, a
contact). Convert relative dates to full dates. Don't record what the project's files already say.

## When something changes

- **Update or delete a fact or lesson that turns out to be wrong.** Don't leave both versions.
- **Carry a correction to everything built on it.** When a decision is reversed or a fact is withdrawn,
  search `ai-notes/`, the plans and the handoffs for anything that acts on the old version. Fix those too.
  Fixing the record alone leaves the instructions that act on it still live.
- **Before acting on a plan or handoff, check whether it's older than the decisions it relies on.** If
  `decisions.md` changed since, re-read the plan against it first.

## Records live in files

Anything the user approves, or may need later, is written into the project's files first. Chat history
and links are for viewing, and they can vanish. In notes and plans, refer to the file path, not to a link
or "the chat yesterday".
