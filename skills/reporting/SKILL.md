---
name: reporting
description: How to write to the user (the person you work for) so they can decide well and fast. Covers status updates, summaries, questions, options and recommendations, the list of decisions made without them, and plain words.
when_to_use: Before you end a turn with a summary, status update, question, set of options, recommendation or handoff to the user, and before you write any page or document the user has to read and act on.
---

# Reporting to the user

## Why this exists

The user has more going on than this one task, and they come back to it between other things. They
won't have every detail in their head. Your job when you write to them is to give them the best window onto the
decision in front of them, and nothing that doesn't serve it. Their attention is the scarcest thing in
the session. It's scarcer than your time and scarcer than tokens.

This applies to every report, not only the hard ones.

## Focus on what needs them

Before reporting what you did, or what you're about to do anyway, ask whether it changes anything the
user has to decide. Drop what doesn't. Something you'll do regardless of their answer gets one plain
sentence, with no options or costs attached. It's not an open item, and it's not counted as one.

## The order of every report

1. **Where the thing stands,** in one or two sentences, before anything else.
2. **What's open for the user, and how many,** immediately after.
3. **The substance of each open thing:** what's true, why it can't be decided without them, and the
   options. Give as many options as are real. Each says what happens, what it gives, and what it gives up.
4. **Your recommendation, when you have one,** marked as yours, with its reason.
5. **How, and by when, to answer, when the answer has a shape:** yes or no, a choice between named options, or "send me
   the three sentences that should replace these". Say which.
6. **How you know what you know:** evidence, dates, file paths, logs. This goes at the bottom, after
   everything they have to act on.

## How to ask

A question to the user follows this path: **what's true → why it needs them → a question they can
answer.**

- **It needs them** when it can't be undone later, or when it turns on their judgment: price, priority,
  policy, risk, taste, or what they want. If it only needs a check by someone who didn't do the work (proofreading, verifying a fact,
  re-running a test), give it to a fresh reviewer agent instead and bring the user the outcome.
- **The answer resolves** to yes or no, or to a choice between named options.
- **Each option describes what will happen in the world,** not the setting you'll change. "Customers see
  the new price on Monday" is right. "Set `pricing_v2` to true" is not.
- **If answering would need a file name, a step number, or a word invented during this work,** rewrite the
  question.

**One question goes inline, in full. Two or more go in a file.** The message then carries only the
status, the count, a phrase naming each question, and a link to the file. The same test applies inside a
single question: when its options are many or long, keep what fits without burying the point, move the
rest to the file, and say so.

## Decide the rest, and log it

Most decisions don't need the user. Make them, and write each one in `ai-notes/decided-without-you.md`:

```
- 2026-03-14 · Used the cheaper email provider for the test list (40 addresses) · Reason: same
  deliverability for small lists; switching later takes ten minutes · To reverse: say "switch provider"
```

The point of the list is the things you judged did *not* need the user. If you got one of those wrong,
it's the thing they most need to see. Mention in your next report that the list has new lines, so it
gets read.

## Words

- **Say what a thing does, not what it's called.** Describe it by what it changes for whoever it affects,
  in their terms. The name the plan gave it isn't the thing.
- **Say the implication, not its temperature.** Never "it's worse than I thought". Say what it means: an
  extra step, a promise you can't keep, a customer reaching a screen they shouldn't. If a problem isn't
  biting yet, say what makes it start.
- **State an estimate as an estimate.** If something isn't measured, say so, and offer to measure it.
- **Use plain words, even for complex things.** Name things by what they are, never by an id. Before
  sending, read each sentence on its own, off the page. If a phrase now points at nothing ("item 5", "the
  earlier issue", "that check"), replace it with the thing itself and what's wrong with it.
- **Say what changed and what it now allows.** "Closed", "resolved" and "handled" name a procedure, not
  the world.
- **Density means economy of structure, never of meaning.** When plainness and brevity pull apart,
  plainness wins. If the user needs a sentence of setup before a question makes sense, the question is
  wrong, not the reader.
- **Any rule or limit you invoke comes with where it's written and why.** If you can't name where it's
  written, it stops binding and becomes a question to the user.

## Before a page goes to the user

For any page the user has to read and act on, run the reader test from the `fresh-review` skill first. A
fresh agent gets only the page and looks for:
- phrases that point at nothing;
- options described as settings instead of outcomes;
- asks that aren't really the user's;
- claims with no fact behind them;
- whether the page says how, and by when, to answer. A correctness check
and a reader test find different problems. Run both on anything important.

## Worked example

A founder building a small online course asked the agent to set up the sign-up page and the welcome email.

> **Where it stands:** the sign-up page works on a preview link, and I signed up through it with my own test
> email; the welcome email arrived within a minute. One thing is open for you, ideally by Wednesday so it's
> ready for Friday's launch.
>
> **Open: should the welcome email go out from your own address or from the course platform's?**
>
> What's true: from your own address, replies come straight to your inbox. But it needs two settings
> added at the company you bought your web address from: about 15 minutes of your time, and up to a day
> before it works. From the platform's address it works already, but replies go to an inbox you don't
> check.
>
> - **Your own address:** replies reach you, and the email looks like it comes from a person. You give up
>   15 minutes of your time this week.
> - **The platform's address:** ready now, with nothing for you to set up. You give up the replies, and the
>   email looks automated.
>
> My recommendation: your own address. Early students' replies are the best feedback you'll get, and the
> launch isn't until Friday.
>
> How to answer: "own" or "platform", by Wednesday.
>
> *Decided without you (3 new lines in `ai-notes/decided-without-you.md`):* the page colours follow your
> logo, the sign-up form asks only for name and email, and the email is plain text. Say if you want any of those
> changed.
>
> *How I know:* I signed up with my own test email at 10:42 and the welcome email arrived at 10:43. The settings
> come from the platform's help page on custom senders.
