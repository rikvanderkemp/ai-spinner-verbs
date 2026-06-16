# ai-spinner-verbs

My personal AI-verbs list to use with Claude AI or other systems that support this.

## Quick install prompt (copy/paste)

Use this prompt with your AI assistant:

```text
Update my ~/.claude/settings.json and set the spinner verbs to https://raw.githubusercontent.com/<OWNER>/<REPO>/main/verbs/<VERBS_FILENAME>.txt using mode: replace or append
```

`~/.claude/settings.json` is the Claude local settings file (create it first if it does not exist).

Example with this repository:

```text
Update my ~/.claude/settings.json and set the spinner verbs to https://raw.githubusercontent.com/rikvanderkemp/ai-spinner-verbs/main/verbs/rambo.txt using mode: replace
```

If you use your own fork, replace `rikvanderkemp/ai-spinner-verbs` with your owner/repo.

## Verbs file index

This repository stores verb lists as text files in `/verbs`.

| File | Description |
| --- | --- |
| `verbs/rambo.txt` | Rambo-themed action verbs |
| `verbs/discworld.txt` | Discworld-themed verbs (Terry Pratchett) |
| `verbs/bobiverse.txt` | Bobiverse-themed verbs (Dennis E. Taylor) |

## Repository structure and AI update workflow

Expected structure:

```text
ai-spinner-verbs/
├─ README.md
└─ verbs/
   └─ *.txt
```

Each verbs file should be plain text with one verb per line.

### Prompt to add new verbs with AI

Use this prompt when you want AI to add a new list:

```text
Add the following verbs to this repository <LIST_OF_VERBS>.
Create a new file in verbs/ (for example verbs/<name>.txt), write one verb per line, and update the "Verbs file index" table in README.md with the new file and description.
```
