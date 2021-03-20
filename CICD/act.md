# act - run action locally

### Check act version
```bash
$ act --version
act version 0.2.20
```

### act HELP page
```bash
$ act -h
Run Github actions locally by specifying the event name (e.g. `push`) or an action name directly.

Usage:
  act [event name to run]
If no event name passed, will default to "on: push" [flags]

Flags:
  -a, --actor string           user that triggered the event (default "nektos/act")
  -b, --bind                   bind working directory to container, rather than copy
      --defaultbranch string   the name of the main branch
      --detect-event           Use first event type from workflow as event that triggered the workflow
  -C, --directory string       working directory (default ".")
  -n, --dryrun                 dryrun mode
      --env stringArray        env to make available to actions with optional value (e.g. --e myenv=foo or -s myenv)
      --env-file string        environment file to read and use as env in the containers (default ".env")
  -e, --eventpath string       path to event JSON file
  -g, --graph                  draw workflows
  -h, --help                   help for act
      --insecure-secrets       NOT RECOMMENDED! Doesn't hide secrets while printing logs.
  -j, --job string             run job
  -l, --list                   list workflows
  -P, --platform stringArray   custom image to use per platform (e.g. -P ubuntu-18.04=nektos/act-environments-ubuntu:18.04)
      --privileged             use privileged mode
  -p, --pull                   pull docker image(s) if already present
  -q, --quiet                  disable logging of output from steps
  -r, --reuse                  reuse action containers to maintain state
  -s, --secret stringArray     secret to make available to actions with optional value (e.g. -s mysecret=foo or -s mysecret)
      --secret-file string     file with list of secrets to read from (e.g. --secret-file .secrets) (default ".secrets")
  -v, --verbose                verbose output
      --version                version for act
  -w, --watch                  watch the contents of the local repo and run when files change
  -W, --workflows string       path to workflow file(s) (default "./.github/workflows/")
```

### List folder structure
```bash
$  make tree
.
├── act.md
├── build_database.py
├── devops
│   └── Devops-VENV.md
├── .github
│   └── workflows
│       └── build.yml
├── .gitignore
├── Makefile
├── Makefile-devops-venv
├── Makefile-IaC-core
├── Makefile.venv
├── .pre-commit-config.yaml
├── README.md
├── requirements.txt
├── til.db
└── update_readme.py

3 directories, 14 files
```

### Show action graph
```bash
$  act -g
 ╭───────╮
 │ build │
 ╰───────╯
```

### Dry-run action
```bash
act -n
*DRYRUN* [Build README/build] 🚀  Start image=catthehacker/ubuntu:act-latest
*DRYRUN* [Build README/build]   🐳  docker run image=catthehacker/ubuntu:act-latest entrypoint=["/usr/bin/tail" "-f" "/dev/null"] cmd=[]
*DRYRUN* [Build README/build] ⭐  Run Check out repo
*DRYRUN* [Build README/build]   ✅  Success - Check out repo
*DRYRUN* [Build README/build] ⭐  Run Set up Python
*DRYRUN* [Build README/build]   ☁  git clone 'https://github.com/actions/setup-python' # ref=v1
*DRYRUN* [Build README/build]   ✅  Success - Set up Python
*DRYRUN* [Build README/build] ⭐  Run Configure pip caching
*DRYRUN* [Build README/build]   ☁  git clone 'https://github.com/actions/cache' # ref=v1
*DRYRUN* [Build README/build]   ✅  Success - Configure pip caching
*DRYRUN* [Build README/build] ⭐  Run Install Python dependencies
*DRYRUN* [Build README/build]   ✅  Success - Install Python dependencies
*DRYRUN* [Build README/build] ⭐  Run Build database
*DRYRUN* [Build README/build]   ✅  Success - Build database
*DRYRUN* [Build README/build] ⭐  Run Update README
*DRYRUN* [Build README/build]   ✅  Success - Update README
*DRYRUN* [Build README/build] ⭐  Run Commit and push if README changed
*DRYRUN* [Build README/build]   ✅  Success - Commit and push if README changed
```
