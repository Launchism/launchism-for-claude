---
name: fresh-review
description: Have finished work checked by a fresh reviewer agent that never saw it being done, and run a reader test on pages the user will act on. Use it before calling substantial work done.
when_to_use: Before you tell the user that substantial work is done, works, or is true; before the user reads a page they must act on; and whenever a mistake would cost the user money, time, trust or a decision.
---

# Fresh review

## Why this exists

When you check your own work, you check it against what you meant to do, so the same blind spots that
produced a mistake also hide it. A reviewer that never saw you work checks it against the world instead:
the actual files, pages and numbers. A second opinion inside the same conversation tends to agree with the
first. A fresh reviewer is a separate Claude agent that starts with no memory of this conversation, so it
meets the facts without your assumptions.

There are two kinds of check, and they find different problems:
- **The reviewer** (`reviewer` agent) asks: *is this true?* It tries to prove the work wrong.
- **The reader** (`reader` agent) asks: *can the user act on this?* It gets only the page and finds where
  it fails a reader who isn't technical.

In one real case, two reviewers found 4 serious errors in a plan. A reader given only the one-page summary
the user was meant to decide from found 44 places where that page failed them, including that it never
said how to answer. Neither check replaces the other.

## When to run it

- **Before you say substantial work is done:** a document, a plan, research, a set-up, an automation, a
  data change, or a page of numbers.
- **Before the user reads a page they must act on:** run the reader as well.
- **Skip it for small things** whose mistakes are cheap and obvious, such as a one-line answer or a
  formatting change.

Each review uses more of the user's Claude usage, because another agent does the work. That's usually worth it: the user's time and a wrong decision cost
more.

## How to run it

1. **Save the work to a file first.** A reviewer can't check a chat message it can't see.
2. **Start the `reviewer` agent** with:
   - where the work is (the file path);
   - where its sources are: files, folders, links, `ai-notes/decisions.md`;
   - what the work is for, in one sentence.

   Don't give it your own summary of why the work is right, and don't give it your own notes on the work.
   It should form its own view from the sources.
3. **For a page the user will act on, start the `reader` agent** with only the page's file path. Nothing
   else.
4. **Start both at once** when you need both. They don't depend on each other.
5. **Fix what they find.** For each finding, either fix it, or decide it's wrong and write down why.
   Nothing stays just "open".
6. **Review again after each round of fixes.** Fixes bring their own mistakes, so give the reviewer the
   changed parts and the findings they were meant to fix.
7. **If a finding would change a major decision, check the finding too.** A second fresh reviewer, given
   the finding and the sources, confirms or rejects it. Reviewers can be wrong.

## What to tell the user

Not the review itself. Tell them the outcome: "A fresh reviewer checked this and found 3 problems, all
fixed: …". If a finding needs their judgment, ask it the way the `reporting` skill (this plugin's guide to writing to
the user) says. Keep the
reviewer's full findings in a file next to the work, in case the user wants them.
