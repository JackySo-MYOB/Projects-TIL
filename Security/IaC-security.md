## IaC-Security - checkov

### Routines

```bash
$ make

 Choose a command run:

fetch-github                             Git clone to $(REPO) - default current folder
readme                                   Read Github repo README.md
checkov                                  Check checkov installed and version
cloudformation                           List available cloudformation check
terraform                                List available terraform check
terraform_plan                           List available terraform_plan check
kubernetes                               List available kubernetes check
serverless                               List available serverless check
helm                                     List available helm check
arm                                      List available arm check
check-file                               Check IaC file
check-directory                          Check IaC in directory
terraform-plan                           Generate terraform plan output
check-terraform-plan                     Check IaC through terraform plan output
tf-hooks                                 Install packages for Terraform hooks use - terraform-docs, tflint, and tfsec
docker                                   Check IaC through docker
```

### checkov

#### Add checkov pre-commit configuration and activate pre-commit check

```bash
repos:
  - repo: https://github.com/bridgecrewio/checkov.git
    rev: '' # change to tag or sha
    hooks:
      - id: checkov
        verbose: true
        args: [--soft-fail]
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v3.2.0
    hooks:
      - id: trailing-whitespace
      - id: check-yaml
      - id: check-json
```

```bash
$ git add .pre-commit-config.yaml
$ git commit -m 'Pre-commit checkov
'
[WARNING] The 'rev' field of repo 'https://github.com/bridgecrewio/checkov.git' appears to be a mutable reference (moving tag / branch).  Mutable references are never updated after first install and are not supported.  See https://pre-commit.com/#using-the-latest-version-for-a-repository for more details.  Hint: `pre-commit autoupdate` often fixes this.
[INFO] Initializing environment for https://github.com/bridgecrewio/checkov.git.
[INFO] Initializing environment for https://github.com/pre-commit/pre-commit-hooks.
[INFO] Installing environment for https://github.com/bridgecrewio/checkov.git.
[INFO] Once installed this environment will be reused.
[INFO] This may take a few minutes...
[INFO] Installing environment for https://github.com/pre-commit/pre-commit-hooks.
[INFO] Once installed this environment will be reused.
[INFO] This may take a few minutes...
Checkov..............................................(no files to check)Skipped
- hook id: checkov
Trim Trailing Whitespace.................................................Passed
Check Yaml...............................................................Passed
Check JSON...........................................(no files to check)Skipped
[main b7a7722] Pre-commit checkov
 3 files changed, 17 insertions(+), 3 deletions(-)
 create mode 100644 .gitignore
 create mode 100644 .pre-commit-config.yaml
```

#### Pre-commit checkov terraform file

```bash
$ git add terraform/
$ git commit -m 'Terraform provider'
[WARNING] Unstaged files detected.
[INFO] Stashing unstaged files to /home1/jso/.cache/pre-commit/patch1615798039.
[WARNING] The 'rev' field of repo 'https://github.com/bridgecrewio/checkov.git' appears to be a mutable reference (moving tag / branch).  Mutable references are never updated after first install and are not supported.  See https://pre-commit.com/#using-the-latest-version-for-a-repository for more details.  Hint: `pre-commit autoupdate` often fixes this.
Checkov..................................................................Passed
- hook id: checkov
- duration: 2.08s

_               _
   ___| |__   ___  ___| | _______   __
  / __| '_ \ / _ \/ __| |/ / _ \ \ / /
 | (__| | | |  __/ (__|   < (_) \ V /
  \___|_| |_|\___|\___|_|\_\___/ \_/

By bridgecrew.io | version: 1.0.838

terraform scan results:

Passed checks: 1, Failed checks: 0, Skipped checks: 0

Check: CKV_AWS_41: "Ensure no hard coded AWS access key and secret key exists in provider"
	PASSED for resource: aws.default
	File: /terraform/provider.tf:1-11
	Guide: https://docs.bridgecrew.io/docs/bc_aws_secrets_5



Trim Trailing Whitespace.................................................Passed
Check Yaml...........................................(no files to check)Skipped
Check JSON...........................................(no files to check)Skipped
[INFO] Restored changes from /home1/jso/.cache/pre-commit/patch1615798039.
[main b17001d] Terraform provider
 1 file changed, 12 insertions(+)
 create mode 100644 terraform/provider.tf



```

### Terraform Pre-commit

#### Add Terraform pre-commit hook

```bash
$ make tf-hooks
make[1]: Entering directory '/home1/jso/myob-work/work/aws-cf/git-repo/project-resources/resources/devops/makefile/iac-security'
Check and install terraform-docs
terraform-docs version 0.11.2 bd351fc linux/amd64 BuildDate: 2021-02-22T23:52:49Z
Check and install tflint
TFLint version 0.25.0
Check and install tfsec
development
make[1]: Leaving directory '/home1/jso/myob-work/work/aws-cf/git-repo/project-resources/resources/devops/makefile/iac-security'

```

```bash
repos:
  - repo: https://github.com/bridgecrewio/checkov.git
    rev: '' # change to tag or sha
    hooks:
      - id: checkov
        verbose: true
        args: [--soft-fail]
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v3.2.0
    hooks:
      - id: trailing-whitespace
      - id: check-yaml
      - id: check-json
  - repo: https://github.com/gruntwork-io/pre-commit
    rev: v0.1.12 # Get the latest from: https://github.com/gruntwork-io/pre-commit/releases
    hooks:
      - id: tflint ## Automatically run tflint on all Terraform code (*.tf files).
        args:
          - "--module"
          - "--deep"
          - "--config=.tflint.hcl"
      - id: terraform-fmt ## Automatically run terraform fmt on all Terraform code (*.tf files).
      - id: terraform-validate ## Automatically run terraform validate on all Terraform code (*.tf files).
```
#### Troubleshoot Pre-commit fails - terraform-fmt

```bash
$ git commit -m 'Terraform pre-commit check'
[WARNING] The 'rev' field of repo 'https://github.com/bridgecrewio/checkov.git' appears to be a mutable reference (moving tag / branch).  Mutable references are never updated after first install and are not supported.  See https://pre-commit.com/#using-the-latest-version-for-a-repository for more details.  Hint: `pre-commit autoupdate` often fixes this.
Checkov..................................................................Passed
- hook id: checkov
- duration: 1.57s

_               _
   ___| |__   ___  ___| | _______   __
  / __| '_ \ / _ \/ __| |/ / _ \ \ / /
 | (__| | | |  __/ (__|   < (_) \ V /
  \___|_| |_|\___|\___|_|\_\___/ \_/

By bridgecrew.io | version: 1.0.838

terraform scan results:

Passed checks: 1, Failed checks: 0, Skipped checks: 0

Check: CKV_AWS_41: "Ensure no hard coded AWS access key and secret key exists in provider"
	PASSED for resource: aws.default
	File: /terraform/provider.tf:1-11
	Guide: https://docs.bridgecrew.io/docs/bc_aws_secrets_5



Trim Trailing Whitespace.................................................Passed
Check Yaml...........................................(no files to check)Skipped
Check JSON...........................................(no files to check)Skipped
tflint...................................................................Passed
Terraform fmt............................................................Failed
- hook id: terraform-fmt
- exit code: 3

terraform/provider.tf
--- old/terraform/provider.tf
+++ new/terraform/provider.tf
@@ -1,6 +1,6 @@
 provider "aws" {
   version = "> 2"
-  region = "ap-southeast-2"
+  region  = "ap-southeast-2"

   # Make it faster by skipping something
   skip_get_ec2_platforms      = true

Terraform validate.......................................................Passed

 $ vi terraform/provider.tf
 $ git status
On branch main
Your branch is ahead of 'origin/main' by 2 commits.
  (use "git push" to publish your local commits)

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	modified:   terraform/provider.tf

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   terraform/provider.tf

$ git add terraform/provider.tf
$ git commit -m 'Terraform pre-commit check'
[WARNING] The 'rev' field of repo 'https://github.com/bridgecrewio/checkov.git' appears to be a mutable reference (moving tag / branch).  Mutable references are never updated after first install and are not supported.  See https://pre-commit.com/#using-the-latest-version-for-a-repository for more details.  Hint: `pre-commit autoupdate` often fixes this.
Checkov..................................................................Passed
- hook id: checkov
- duration: 1.42s

_               _
   ___| |__   ___  ___| | _______   __
  / __| '_ \ / _ \/ __| |/ / _ \ \ / /
 | (__| | | |  __/ (__|   < (_) \ V /
  \___|_| |_|\___|\___|_|\_\___/ \_/

By bridgecrew.io | version: 1.0.838

terraform scan results:

Passed checks: 1, Failed checks: 0, Skipped checks: 0

Check: CKV_AWS_41: "Ensure no hard coded AWS access key and secret key exists in provider"
	PASSED for resource: aws.default
	File: /terraform/provider.tf:1-11
	Guide: https://docs.bridgecrew.io/docs/bc_aws_secrets_5



Trim Trailing Whitespace.................................................Passed
Check Yaml...........................................(no files to check)Skipped
Check JSON...........................................(no files to check)Skipped
tflint...................................................................Passed
Terraform fmt............................................................Passed
Terraform validate.......................................................Passed
[main bc0e437] Terraform pre-commit check
 1 file changed, 1 insertion(+), 2 deletions(-)
```
