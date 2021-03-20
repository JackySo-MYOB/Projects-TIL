# ANZ code challenge task 1 - Spin-up and installation of a single-machine n-tier architecture.

This repository contains the infrastructure code and automation for task1 requirement

## Clear instructions for the reviewer to deploy your scripts/code.

```
anz-code-challenge-1
├── build
│   └── manifest.json
├── docker-compose.yml
├── Dockerfile
├── images
├── Makefile
├── packer
│   ├── ansible
│   │   ├── ansible.cfg
│   │   ├── apps
│   │   │   └── playbook.yml
│   │   ├── os
│   │   │   └── playbook.yml
│   │   └── vars
│   │       └── variables.yml
│   └── scripts
│       ├── ansible.sh
│       ├── clean.sh
│       └── python.sh
├── packer.json
├── README.md
├── terraform
│   ├── infrastructure
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── modules
│   │   └── terraform-aws-autoscaling
│   │       ├── CHANGELOG.md
│   │       ├── examples
│   │       │   ├── asg_ec2
│   │       │   │   ├── main.tf
│   │       │   │   ├── outputs.tf
│   │       │   │   └── README.md
│   │       │   ├── asg_ec2_external_launch_configuration
│   │       │   │   ├── main.tf
│   │       │   │   ├── outputs.tf
│   │       │   │   └── README.md
│   │       │   ├── asg_elb
│   │       │   │   ├── main.tf
│   │       │   │   ├── outputs.tf
│   │       │   │   └── README.md
│   │       │   └── asg_inital_lifecycle_hook
│   │       │       ├── main.tf
│   │       │       ├── outputs.tf
│   │       │       └── README.md
│   │       ├── LICENSE
│   │       ├── locals.tf
│   │       ├── main.tf
│   │       ├── Makefile
│   │       ├── outputs.tf
│   │       ├── README.md
│   │       ├── variables.tf
│   │       └── versions.tf
│   ├── scripts
│   │   └── user_data.sh
│   ├── terraform.tfstate
│   └── terraform.tfstate.backup
└── tests
    └── scripts
        └── validate_shell_scripts.sh

20 directories, 41 files

```

```
 Choose a command run:

test                                     Validation test all code including shell script, and packer json
test-lint-yaml                           Test Lint YAML - ansible playbook
test-validate-shell                      Test Validate Shell Scripts
test-validate-packer                     Test Validate Packer Template
package                                  Building AMI
terraform-version                        Show docker terraform version
terraform-state                          Query terraform state
terraform-plan                           Run terraform init and plan
terraform-deploy                         Run terraform init and deploy
terraform-undeploy                       Run terraform init and destroy
```

## Requirements for running. (Tooling pre-installed? AWS/GCP account?)
Alternatively, you can launch SSM session to connect running instance thru aws-cli

### Build and deploy box requirements
```
Requirement:
	- install GNU make
	- install docker and docker-compose
	- install AWS CLI and configure aws credentials
	- optional install SSM session manager plugin

```
### How to connect launched instance without SSH
```
Launch session CLI:
	- aws ssm start-session --target ${instance_id}
```

## Explanation of design choices, short comings and assumptions

### Design choices

### Assumptions

### Shortcomings

