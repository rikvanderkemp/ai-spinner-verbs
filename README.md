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
| `verbs/project-hail-mary.txt` | Project Hail Mary-themed verbs (Andy Weir) |
| `verbs/the-expanse.txt` | The Expanse-themed verbs (James S. A. Corey) |
| `verbs/quantum-theory.txt` | Quantum theory-themed verbs (physics) |

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

## Randomize the verb list every session

Want a different themed spinner each time you open Claude Code? Use the bundled
`scripts/random-spinner-verbs.sh` as a `SessionStart` hook. It picks a random
`verbs/*.txt` and writes it into your `spinnerVerbs` setting.

1. Make the script executable (once, after cloning):

   ```sh
   chmod +x scripts/random-spinner-verbs.sh
   ```

2. Add a `SessionStart` hook to `~/.claude/settings.json`, pointing `command` at
   wherever you cloned this repo:

   ```json
   {
     "hooks": {
       "SessionStart": [
         {
           "hooks": [
             {
               "type": "command",
               "command": "~/code/ai-spinner-verbs/scripts/random-spinner-verbs.sh",
               "statusMessage": "Rotating spinner verbs"
             }
           ]
         }
       ]
     }
   }
   ```

The script requires [`jq`](https://jqlang.github.io/jq/). It rewrites
`spinnerVerbs` with `mode: "replace"` and the chosen list while preserving every
other setting, and exits without touching anything if `jq`, the settings file,
or the `verbs/` folder is missing — so it never breaks startup. The list
re-rolls on every session; depending on settings load order the freshly chosen
list may take effect from the next session.
