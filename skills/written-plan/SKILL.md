---
name: written-plan
description: Use when the user asks to plan, launch, build, set up, organise or prepare something with several parts or a deadline. Writes the plan to a file and works from it, writes a handoff when work continues in another chat, and writes the user a short walk to try the result before calling it done.
when_to_use: "Plan it", "help me launch…", "set up…", "in six weeks", any goal bigger than one task; when a chat is getting long or the work will continue later; and before telling the user that something they'll use is done.
---

# Working from a plan

## Why this exists

Without a written plan, the AI works from its own guesses about what the user wants, and those guesses
drift. Without a handoff, long work falls apart when the chat fills up or the next step happens tomorrow:
the next chat guesses again, and reopens questions that were already settled. And a user who can't read
the work can still always try it. The walk lets them check the result in their own world, not in the AI's
report of it.

## The plan

For any goal bigger than a single task, write the plan to `ai-notes/plans/<short-name>.md` before starting.
Have a fresh reviewer check it (the `fresh-review` skill), then show it to the user. Questions for the
user go in the plan file, not in a long chat message.

```
# Plan: <goal in plain words>

Why: what this is for, in the user's words where possible.

Done means (fixed once the user agrees):
- <a check anyone could make, e.g. "a new student can sign up and gets the welcome email within a minute">
- …

Steps:
- [ ] <one deliverable each> — serves: <which "done means" line>
- …

Open questions for the user:
- …
```

**Rules for working from it:**
- **Read the plan before each work session,** together with `ai-notes/decisions.md`.
- **Finished steps don't mean the goal is met.** The goal is met when every "done means" line has been
  checked and shown. "All steps done, goal not yet met" is a normal state; say so plainly.
- **Don't change the "done means" lines to fit what you built.** If one turns out to be wrong, tell the
  user what's wrong with it and ask. Changing the goal is their call.
- **Found missing work?** Add a step, and say which "done means" line it serves.
- **Every step serves a "done means" line.** A step that serves none is either missing a line (ask) or not
  needed (drop it).
- **Mark steps honestly:** done only with proof (it ran on real input, or you followed a real example
  through every step), and blocked only by something
  real and named. "Waiting on X" must name who owns X; otherwise make X a step.

## The handoff

When a chat is getting long, when the work will continue later, or when another chat or agent takes over,
write a handoff to `ai-notes/handoffs/<date>-<short-name>.md`. A fresh chat with no memory of this one must
be able to pick the work up from the handoff and the files alone.

**What it contains, in this order:**
1. **Where it stands:** what the plan says, and what is really true now, checked now, not copied from an
   earlier note. Name the handoff before this one, if there was one.
2. **The next chat's job,** in one or two sentences.
3. **What's already decided,** quoted from `ai-notes/decisions.md` with dates, so it isn't reopened.
   Include any questions that look open but are already settled, and what not to add (things the user
   ruled out).
4. **Open questions for the user.** These move to the next chat. This chat stops asking them, so the user
   isn't asked twice.
5. **What it may touch, and what it must not.**
6. **What was tried and rejected,** quoted from `ai-notes/tried-and-rejected.md`, and any traps found on the
   way. Point to the standing rules and the `ai-notes/` files rather than copying them.
7. **When to stop and ask the user.**
8. **What "done" means** for the next piece of work.
9. **How I know:** files, dates and sources, at the bottom.

**Before you finish a handoff, re-read it as a hostile reviewer would.** List anything you couldn't verify.
A handoff with a missing section is not ready.

**When you pick up a handoff,** check its "where it stands" claims against the files before acting on
them. If `ai-notes/decisions.md` is newer than the handoff, re-read the handoff against it.

## The walk

Before telling the user that something they'll use is done (a page, a form, an automation, a spreadsheet,
a document), write them a walk at `ai-notes/walks/<short-name>.md`. It's a short checklist they can follow
themselves. Keep it as short as it can be, and say at the top how long it takes:

```
# Walk: <what you're trying>

About 10 minutes. Tick each box as it holds; where it doesn't, write what you saw.

- [ ] Open <exact place>. You should see <exactly what>.
- [ ] Do <exact action>. Within <time>, <exactly what should happen>.
- [ ] …
```

- **Each line says what to do and what should happen,** in the user's words, with nothing technical.
- **Cover the main path and one thing that could go wrong** (a wrong input, a cancelled payment, an empty
  list).
- **Before you send it, run the reader test on it** (the `fresh-review` skill), so every line makes sense
  to someone who isn't technical.
- **When they send the walk back,** fix what failed, and update the walk if it was unclear.

For anything bigger, offer a quick mock-up or sketch before building, so the user can react to it before
the work is done.
