# Challenge2 Sub-task1 and validation

### Sub-task1 requirements
```
SubTask1: Kubernetes cluster setup/deployment
You may use the kubeadm init and join to create master and worker node cluster. Feel free to find
references from the web or GitHub /kubernetes.io or linux academy/acloud guru etc
Please make sure you will use automation via shell script, any IaaC tooling ( as mentioned in task #1) to
achieve the outcome in creating single master/single worker node cluster.
You may create the cluster locally on your local PC or on AWS/GCP if you choose and please ensure you
submit the codes to the GitHub for review.
```

#### Primarily, i will use GNU make as automation to walk through `sub-tasks 1` work and validation  - see menu below with highlighted and used in this sub-task

```diff
make

 Choose a command run:

kubeadm-terraform-shell                  Run docker kubeadm-terraform and /bin/bash
-kubeadm-terraform-genkey                 Run docker kubeadm-terraform and generate key
-kubeadm-terraform-token                  Run docker kubeadm-terraform and generate k8s token
kubeadm-terraform-version                Run docker kubeadm-terraform and show terraform version
+kubeadm-terraform-state                  Query terraform state
kubeadm-terraform-show                   Show terraform state key_pair
kubeadm-terraform-init                   Run terraform init
+kubeadm-terraform-plan                   Run terraform init and plan
+kubeadm-terraform-deploy                 Run terraform init and deploy
kubeadm-terraform-undeploy               Run terraform init and destroy
+master-ip                                Run terraform output master node public IP
worker-ip                                Run terraform output worker node public IP
-awscli-sts                               Run awscli aws sts get-caller-identity
copy-image                               Run awscli copy image to your region
+ssh-master                               SSH into Kubernetes master node
ssh-worker                               SSH into Kubernetes worker node
+kubectl-nodes                            SSH into Kubernetes master node and kubectl get nodes -o wide
+kubectl-command                          SSH into Kubernetes master node and kubectl $(COMMAND)
apply-scenario                           Copy scenario file to master and apply into cluster
apply-network-policy-1                   Copy network-policy-1 file to master and apply into cluster
apply-network-policy-2                   Copy network-policy-2 file to master and apply into cluster
apply-network-policy-3                   Copy network-policy-3 file to master and apply into cluster
delete-scenario                          Delete scenario from cluster
get-pods                                 Get pods in default namespace
get-networkpolicies                      Get networkpolicies in all namespaces
run-test-pod-shell                       Run test pod in cluster and interactive shell
run-web-pod                              Run web pod in cluster default namespace and expose por 80 for testing target
delete-web-pod                           Delete web service and pod from cluster default namespace
sec1-container-shell                     Run interactive shell into pod security container sec1
sec2-container-shell                     Run interactive shell into pod security container sec2
apply-pod-security-context               Copy pod security context file to master and apply into cluster
delete-pod-security-context              Delete pod security context file from cluster
apply-container-security-context         Copy container security context file to master and apply into cluster
delete-container-security-context        Delete container security context file from cluster
populate-secret-file                     Populate environments from file and generate yaml/$(SECRETS)
create-secret                            Copy secret file to master and apply to create secret into cluster default namespace
create-nginx-pod-environment             Copy nginx pod file to master and apply into cluster default namespace
nginx-container-shell                    Run interactive shell into pod nginx-secret-env-pod
nginx-container-env                      Query environment variables in running pod nginx-secret-env-pod

```

### Preparation works
- Similar to code challenge task 1 - Docker and docker-compose installed
- AWS environment variables and credentials
- Generate SSH key
- Generate Token for kubeadm use

#### Validate your AWS credentials

```bash
$ make awscli-sts
0XXXXXXXXXXXXXX	arn:aws:sts::XXXXXXXXXXXXXX:assumed-role/XXXXXXXXXXXXXX/Jacky.So@XXXX.com	XXXXXXXXXXXXXXXX:Jacky.So@XXXX.com

```

#### Generate SSH key pair

```bash
$ make kubeadm-terraform-genkey
Generating public/private rsa key pair.
Your identification has been saved in tf-kube.
Your public key has been saved in tf-kube.pub.
The key fingerprint is:
SHA256:6iEpqtW8ajbG06IkNsi6XIqsIyv/FOrNMN6F3+TRRAs root@8badf41c5c80
The key's randomart image is:
+---[RSA 2048]----+
|                 |
|                 |
|        E .      |
|         o .     |
|    .   S o      |
|o  + + . o       |
|o**oB + o .      |
|%=%O.* = .       |
|#&=** o o        |
+----[SHA256]-----+
$ ls -al aws-kubeadm-terraform/tf*
-rw------- 1 root root 1675 Nov 19 16:47 aws-kubeadm-terraform/tf-kube
-rw-r--r-- 1 root root  399 Nov 19 16:47 aws-kubeadm-terraform/tf-kube.pub

```

#### Generate Token for kubeadm use - keep it and will prompt to input in terraform deploy and undeploy flow

```bash

$ make kubeadm-terraform-token
a9749f.7be46b28662c093a

```

### Run Infrastructue as code with Terraform - Game starts

#### Terraform init and plan

```bash
make kubeadm-terraform-plan
--- Terraform Plan

Initializing provider plugins...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 2.70"
* provider.template: version = "~> 2.2"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
var.k8stoken
  Enter a value: a9749f.7be46b28662c093a

Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

data.template_file.master-userdata: Refreshing state...

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
 <= read (data resources)

Terraform will perform the following actions:

 <= data.template_file.etcd-userdata
      id:                                          <computed>
      rendered:                                    <computed>
      template:                                    "#!/bin/bash -ve\ntouch /home/ubuntu/etcd.log\n\ncurl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -\ntouch /etc/apt/sources.list.d/kubernetes.list\n\nsu -c \"echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' >> \\\n    /etc/apt/sources.list.d/kubernetes.list\"\n\n# Install and start SSM agent \ncurl \"https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb\" -o \"amazon-ssm-agent.deb\"\napt-get install -y ./amazon-ssm-agent.deb && systemctl start amazon-ssm-agent.service\nuseradd -m -d /home/ec2-user -s /bin/bash ec2-user\nuseradd -m -d /home/ssm-user -s /bin/bash ssm-user\necho \"ssm-user ALL=(ALL) NOPASSWD:ALL\" > /etc/sudoers.d/ssm-agent-users\necho \"ec2-user ALL=(ALL) NOPASSWD:ALL\" > /etc/sudoers.d/ec2-user\n\n# Install kubelet kubeadm kubectl kubernetes-cni docker\napt-get update\napt-get install -y kubelet kubeadm kubectl kubernetes-cni\ncurl -sSL https://get.docker.com/ | sh\nsystemctl start docker\necho '[Finished] Installing kubelet kubeadm kubectl kubernetes-cni docker' >> /home/ubuntu/etcd.log\n\n# Install etcdctl for the version of etcd we're running\nGOOGLE_URL=https://storage.googleapis.com/etcd\nGITHUB_URL=https://github.com/etcd-io/etcd/releases/download\nDOWNLOAD_URL=$${GOOGLE_URL}\n\nETCD_VER=v$(kubeadm config images list | grep etcd | cut -d':' -f2 | cut -d'-' -f1)\ncurl -L $${DOWNLOAD_URL}/$${ETCD_VER}/etcd-$${ETCD_VER}-linux-amd64.tar.gz -o /tmp/etcd-$${ETCD_VER}-linux-amd64.tar.gz\ntar xzvf /tmp/etcd-$${ETCD_VER}-linux-amd64.tar.gz -C /usr/local/bin --strip-components=1\nrm -f /tmp/etcd-$${ETCD_VER}-linux-amd64.tar.gz\necho '[Finished] Installing etcdctl' >> /home/ubuntu/etcd.log\n\nsystemctl stop docker\nmkdir /mnt/docker\nchmod 711 /mnt/docker\ncat <<EOF > /etc/docker/daemon.json\n{\n    \"data-root\": \"/mnt/docker\",\n    \"log-driver\": \"json-file\",\n    \"log-opts\": {\n        \"max-size\": \"10m\",\n        \"max-file\": \"5\"\n    }\n}\nEOF\nsystemctl start docker\nsystemctl enable docker\necho '[Finished] docker configure' >> /home/ubuntu/etcd.log\n\n# Point kubelet at big ephemeral drive\nmkdir /mnt/kubelet\necho 'KUBELET_EXTRA_ARGS=\"--root-dir=/mnt/kubelet --cloud-provider=aws\"' > /etc/default/kubelet\necho '[Finished] kubelet configure' >> /home/ubuntu/etcd.log\n\n# ----------------- from here same with etcd.sh\n\n# Pass bridged IPv4 traffic to iptables chains (required by Flannel)\necho \"net.bridge.bridge-nf-call-iptables = 1\" > /etc/sysctl.d/60-flannel.conf\nservice procps start\n\necho '[Wait] kubeadm join until kubeadm cluster have been created.' >> /home/ubuntu/etcd.log\nfor i in {1..50}; do sudo kubeadm join --token=${k8stoken} --discovery-token-unsafe-skip-ca-verification --node-name=$(hostname -f) ${masterIP}:6443 && break || sleep 15; done\n"
      vars.%:                                      "2"
      vars.k8stoken:                               "a9749f.7be46b28662c093a"
      vars.masterIP:                               "10.43.0.40"

 <= data.template_file.worker-userdata
      id:                                          <computed>
      rendered:                                    <computed>
      template:                                    "#!/bin/bash -ve\ntouch /home/ubuntu/worker.log\n\ncurl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -\ntouch /etc/apt/sources.list.d/kubernetes.list\n\nsu -c \"echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' >> \\\n    /etc/apt/sources.list.d/kubernetes.list\"\n\n# Install and start SSM agent \ncurl \"https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb\" -o \"amazon-ssm-agent.deb\"\napt-get install -y ./amazon-ssm-agent.deb && systemctl start amazon-ssm-agent.service\nuseradd -m -d /home/ec2-user -s /bin/bash ec2-user\nuseradd -m -d /home/ssm-user -s /bin/bash ssm-user\necho \"ssm-user ALL=(ALL) NOPASSWD:ALL\" > /etc/sudoers.d/ssm-agent-users\necho \"ec2-user ALL=(ALL) NOPASSWD:ALL\" > /etc/sudoers.d/ec2-user\n\n# Install kubelet kubeadm kubectl kubernetes-cni docker\napt-get update\napt-get install -y kubelet kubeadm kubectl kubernetes-cni\ncurl -sSL https://get.docker.com/ | sh\nsystemctl start docker\necho '[Finished] Installing kubelet kubeadm kubectl kubernetes-cni docker' >> /home/ubuntu/worker.log\n\nsystemctl stop docker\nmkdir /mnt/docker\nchmod 711 /mnt/docker\ncat <<EOF > /etc/docker/daemon.json\n{\n    \"data-root\": \"/mnt/docker\",\n    \"log-driver\": \"json-file\",\n    \"log-opts\": {\n        \"max-size\": \"10m\",\n        \"max-file\": \"5\"\n    }\n}\nEOF\nsystemctl start docker\nsystemctl enable docker\necho '[Finished] docker configure' >> /home/ubuntu/worker.log\n\n# Point kubelet at big ephemeral drive\nmkdir /mnt/kubelet\necho 'KUBELET_EXTRA_ARGS=\"--root-dir=/mnt/kubelet --cloud-provider=aws\"' > /etc/default/kubelet\necho '[Finished] kubelet configure' >> /home/ubuntu/worker.log\n\n# ----------------- from here same with worker.sh\n\n# Pass bridged IPv4 traffic to iptables chains (required by Flannel)\necho \"net.bridge.bridge-nf-call-iptables = 1\" > /etc/sysctl.d/60-flannel.conf\nservice procps start\n\necho '[Wait] kubeadm join until kubeadm cluster have been created.' >> /home/ubuntu/worker.log\nfor i in {1..50}; do sudo kubeadm join --token=${k8stoken} --discovery-token-unsafe-skip-ca-verification --node-name=$(hostname -f) ${masterIP}:6443 && break || sleep 15; done\n"
      vars.%:                                      "2"
      vars.k8stoken:                               "a9749f.7be46b28662c093a"
      vars.masterIP:                               "10.43.0.40"

  + aws_iam_instance_profile.kubernetes
      id:                                          <computed>
      arn:                                         <computed>
      create_date:                                 <computed>
      name:                                        "kubernetes"
      path:                                        "/"
      role:                                        "kubernetes"
      roles.#:                                     <computed>
      unique_id:                                   <computed>

  + aws_iam_role.kubernetes
      id:                                          <computed>
      arn:                                         <computed>
      assume_role_policy:                          "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Effect\": \"Allow\",\n      \"Principal\": {\n        \"Service\": \"ec2.amazonaws.com\"\n      },\n      \"Action\": \"sts:AssumeRole\"\n    }\n  ]\n}\n"
      create_date:                                 <computed>
      force_detach_policies:                       "false"
      max_session_duration:                        "3600"
      name:                                        "kubernetes"
      path:                                        "/"
      unique_id:                                   <computed>

  + aws_iam_role_policy.kubernetes
      id:                                          <computed>
      name:                                        "kubernetes"
      policy:                                      "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\" : [\"ec2:*\"],\n      \"Effect\": \"Allow\",\n      \"Resource\": [\"*\"]\n    },\n    {\n      \"Action\" : [\"elasticloadbalancing:*\"],\n      \"Effect\": \"Allow\",\n      \"Resource\": [\"*\"]\n    },\n    {\n      \"Action\": \"route53:*\",\n      \"Effect\": \"Allow\",\n      \"Resource\": [\"*\"]\n    },\n    {\n      \"Action\": \"ssm:*\",\n      \"Effect\": \"Allow\",\n      \"Resource\": [\"*\"]\n    },\n    {\n      \"Action\": \"ssmmessages:*\",\n      \"Effect\": \"Allow\",\n      \"Resource\": [\"*\"]\n    },\n    {\n      \"Action\": \"ec2messages:*\",\n      \"Effect\": \"Allow\",\n      \"Resource\": [\"*\"]\n    },\n    {\n      \"Action\": \"ecr:*\",\n      \"Effect\": \"Allow\",\n      \"Resource\": \"*\"\n    }\n  ]\n}\n"
      role:                                        "${aws_iam_role.kubernetes.id}"

  + aws_instance.controller_etcd
      id:                                          <computed>
      ami:                                         "ami-0ec645db622b4411a"
      arn:                                         <computed>
      associate_public_ip_address:                 "true"
      availability_zone:                           "ap-southeast-2a"
      cpu_core_count:                              <computed>
      cpu_threads_per_core:                        <computed>
      ebs_block_device.#:                          <computed>
      ephemeral_block_device.#:                    <computed>
      get_password_data:                           "false"
      host_id:                                     <computed>
      iam_instance_profile:                        "${aws_iam_instance_profile.kubernetes.id}"
      instance_state:                              <computed>
      instance_type:                               "t2.medium"
      ipv6_address_count:                          <computed>
      ipv6_addresses.#:                            <computed>
      key_name:                                    "tf-kube"
      metadata_options.#:                          <computed>
      network_interface.#:                         <computed>
      network_interface_id:                        <computed>
      outpost_arn:                                 <computed>
      password_data:                               <computed>
      placement_group:                             <computed>
      primary_network_interface_id:                <computed>
      private_dns:                                 <computed>
      private_ip:                                  "10.43.0.40"
      public_dns:                                  <computed>
      public_ip:                                   <computed>
      root_block_device.#:                         <computed>
      security_groups.#:                           <computed>
      source_dest_check:                           "false"
      subnet_id:                                   "${aws_subnet.kubernetes.id}"
      tags.%:                                      "3"
      tags.Name:                                   "controller-etcd-0"
      tags.Owner:                                  "code-challenge-2"
      tags.kubernetes.io/cluster/code-challenge-2: "owned"
      tenancy:                                     <computed>
      user_data:                                   "524b0ae6caedd0c0acf5f53f41d38cae9298a8d6"
      volume_tags.%:                               <computed>
      vpc_security_group_ids.#:                    <computed>

  + aws_instance.worker
      id:                                          <computed>
      ami:                                         "ami-0ec645db622b4411a"
      arn:                                         <computed>
      associate_public_ip_address:                 "true"
      availability_zone:                           "ap-southeast-2a"
      cpu_core_count:                              <computed>
      cpu_threads_per_core:                        <computed>
      ebs_block_device.#:                          <computed>
      ephemeral_block_device.#:                    <computed>
      get_password_data:                           "false"
      host_id:                                     <computed>
      iam_instance_profile:                        "${aws_iam_instance_profile.kubernetes.id}"
      instance_state:                              <computed>
      instance_type:                               "t2.medium"
      ipv6_address_count:                          <computed>
      ipv6_addresses.#:                            <computed>
      key_name:                                    "tf-kube"
      metadata_options.#:                          <computed>
      network_interface.#:                         <computed>
      network_interface_id:                        <computed>
      outpost_arn:                                 <computed>
      password_data:                               <computed>
      placement_group:                             <computed>
      primary_network_interface_id:                <computed>
      private_dns:                                 <computed>
      private_ip:                                  "10.43.0.30"
      public_dns:                                  <computed>
      public_ip:                                   <computed>
      root_block_device.#:                         <computed>
      security_groups.#:                           <computed>
      source_dest_check:                           "false"
      subnet_id:                                   "${aws_subnet.kubernetes.id}"
      tags.%:                                      "3"
      tags.Name:                                   "worker-0"
      tags.Owner:                                  "code-challenge-2"
      tags.kubernetes.io/cluster/code-challenge-2: "owned"
      tenancy:                                     <computed>
      user_data:                                   "852a54d0e12960a650bed5b9a7f45a93f57a663b"
      volume_tags.%:                               <computed>
      vpc_security_group_ids.#:                    <computed>

  + aws_internet_gateway.gw
      id:                                          <computed>
      arn:                                         <computed>
      owner_id:                                    <computed>
      tags.%:                                      "3"
      tags.Name:                                   "kubernetes"
      tags.Owner:                                  "code-challenge-2"
      tags.kubernetes.io/cluster/code-challenge-2: "owned"
      vpc_id:                                      "${aws_vpc.kubernetes.id}"

  + aws_key_pair.default_keypair
      id:                                          <computed>
      arn:                                         <computed>
      fingerprint:                                 <computed>
      key_name:                                    "tf-kube"
      key_pair_id:                                 <computed>
      public_key:                                  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCnqahQpnHuvkNl9HKXYku5RQ+ac/Yvu9TaU0Q4Pex39r1c28f7pmbu6qV9lhxCGYbybDXZB59j1VZdiEZZb0qA1JV7KSsF8WBK9s5dw6As4LGLTm6+wDHSAaNA5biyavxAMDjdTU8imGDANP/5PLEumDNk5Cc4O/fojzksXmZDOj8WsrMVxr98VTdeklAECfPgoBDG5oiscgWzu/gsstW9llQQdtgeXWXaKBSb+QAype/Q+JAGxRATGi+rVmF+VR+mWdIwha/n9us7yI4JahHnTOsj2B/UHG8fLS2hnamiuXVtoPgopyDujkqQu/4jKIobpxyYKZRNx3CZeHhqjrop root@8badf41c5c80"

  + aws_route_table.kubernetes
      id:                                          <computed>
      owner_id:                                    <computed>
      propagating_vgws.#:                          <computed>
      route.#:                                     "1"
      route.~966145399.cidr_block:                 "0.0.0.0/0"
      route.~966145399.egress_only_gateway_id:     ""
      route.~966145399.gateway_id:                 "${aws_internet_gateway.gw.id}"
      route.~966145399.instance_id:                ""
      route.~966145399.ipv6_cidr_block:            ""
      route.~966145399.nat_gateway_id:             ""
      route.~966145399.network_interface_id:       ""
      route.~966145399.transit_gateway_id:         ""
      route.~966145399.vpc_peering_connection_id:  ""
      tags.%:                                      "3"
      tags.Name:                                   "kubernetes"
      tags.Owner:                                  "code-challenge-2"
      tags.kubernetes.io/cluster/code-challenge-2: "owned"
      vpc_id:                                      "${aws_vpc.kubernetes.id}"

  + aws_route_table_association.kubernetes
      id:                                          <computed>
      route_table_id:                              "${aws_route_table.kubernetes.id}"
      subnet_id:                                   "${aws_subnet.kubernetes.id}"

  + aws_security_group.kubernetes
      id:                                          <computed>
      arn:                                         <computed>
      description:                                 "Managed by Terraform"
      egress.#:                                    "1"
      egress.482069346.cidr_blocks.#:              "1"
      egress.482069346.cidr_blocks.0:              "0.0.0.0/0"
      egress.482069346.description:                ""
      egress.482069346.from_port:                  "0"
      egress.482069346.ipv6_cidr_blocks.#:         "0"
      egress.482069346.prefix_list_ids.#:          "0"
      egress.482069346.protocol:                   "-1"
      egress.482069346.security_groups.#:          "0"
      egress.482069346.self:                       "false"
      egress.482069346.to_port:                    "0"
      ingress.#:                                   "3"
      ingress.2242829830.cidr_blocks.#:            "1"
      ingress.2242829830.cidr_blocks.0:            "10.43.0.0/16"
      ingress.2242829830.description:              ""
      ingress.2242829830.from_port:                "0"
      ingress.2242829830.ipv6_cidr_blocks.#:       "0"
      ingress.2242829830.prefix_list_ids.#:        "0"
      ingress.2242829830.protocol:                 "-1"
      ingress.2242829830.security_groups.#:        "0"
      ingress.2242829830.self:                     "false"
      ingress.2242829830.to_port:                  "0"
      ingress.3068409405.cidr_blocks.#:            "1"
      ingress.3068409405.cidr_blocks.0:            "0.0.0.0/0"
      ingress.3068409405.description:              ""
      ingress.3068409405.from_port:                "8"
      ingress.3068409405.ipv6_cidr_blocks.#:       "0"
      ingress.3068409405.prefix_list_ids.#:        "0"
      ingress.3068409405.protocol:                 "icmp"
      ingress.3068409405.security_groups.#:        "0"
      ingress.3068409405.self:                     "false"
      ingress.3068409405.to_port:                  "0"
      ingress.482069346.cidr_blocks.#:             "1"
      ingress.482069346.cidr_blocks.0:             "0.0.0.0/0"
      ingress.482069346.description:               ""
      ingress.482069346.from_port:                 "0"
      ingress.482069346.ipv6_cidr_blocks.#:        "0"
      ingress.482069346.prefix_list_ids.#:         "0"
      ingress.482069346.protocol:                  "-1"
      ingress.482069346.security_groups.#:         "0"
      ingress.482069346.self:                      "false"
      ingress.482069346.to_port:                   "0"
      name:                                        "kubernetes"
      owner_id:                                    <computed>
      revoke_rules_on_delete:                      "false"
      tags.%:                                      "3"
      tags.Name:                                   "kubernetes"
      tags.Owner:                                  "code-challenge-2"
      tags.kubernetes.io/cluster/code-challenge-2: "owned"
      vpc_id:                                      "${aws_vpc.kubernetes.id}"

  + aws_subnet.kubernetes
      id:                                          <computed>
      arn:                                         <computed>
      assign_ipv6_address_on_creation:             "false"
      availability_zone:                           "ap-southeast-2a"
      availability_zone_id:                        <computed>
      cidr_block:                                  "10.43.0.0/16"
      ipv6_cidr_block:                             <computed>
      ipv6_cidr_block_association_id:              <computed>
      map_public_ip_on_launch:                     "false"
      owner_id:                                    <computed>
      tags.%:                                      "3"
      tags.Name:                                   "kubernetes"
      tags.Owner:                                  "code-challenge-2"
      tags.kubernetes.io/cluster/code-challenge-2: "owned"
      vpc_id:                                      "${aws_vpc.kubernetes.id}"

  + aws_vpc.kubernetes
      id:                                          <computed>
      arn:                                         <computed>
      assign_generated_ipv6_cidr_block:            "false"
      cidr_block:                                  "10.43.0.0/16"
      default_network_acl_id:                      <computed>
      default_route_table_id:                      <computed>
      default_security_group_id:                   <computed>
      dhcp_options_id:                             <computed>
      enable_classiclink:                          <computed>
      enable_classiclink_dns_support:              <computed>
      enable_dns_hostnames:                        "true"
      enable_dns_support:                          "true"
      instance_tenancy:                            "default"
      ipv6_association_id:                         <computed>
      ipv6_cidr_block:                             <computed>
      main_route_table_id:                         <computed>
      owner_id:                                    <computed>
      tags.%:                                      "3"
      tags.Name:                                   "kubeadm-kubernetes"
      tags.Owner:                                  "code-challenge-2"
      tags.kubernetes.io/cluster/code-challenge-2: "owned"

  + aws_vpc_dhcp_options.dns_resolver
      id:                                          <computed>
      arn:                                         <computed>
      domain_name:                                 "ap-southeast-2.compute.internal"
      domain_name_servers.#:                       "1"
      domain_name_servers.0:                       "AmazonProvidedDNS"
      owner_id:                                    <computed>
      tags.%:                                      "3"
      tags.Name:                                   "kubeadm-kubernetes"
      tags.Owner:                                  "code-challenge-2"
      tags.kubernetes.io/cluster/code-challenge-2: "owned"

  + aws_vpc_dhcp_options_association.dns_resolver
      id:                                          <computed>
      dhcp_options_id:                             "${aws_vpc_dhcp_options.dns_resolver.id}"
      vpc_id:                                      "${aws_vpc.kubernetes.id}"


Plan: 14 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

```

#### Terraform init and apply - Please input the token generated when prompts and yes on second prompt to proceed terraform apply

```bash

make kubeadm-terraform-deploy
--- Terraform Deploy

Initializing provider plugins...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 2.70"
* provider.template: version = "~> 2.2"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
var.k8stoken
  Enter a value: a9749f.7be46b28662c093a

data.template_file.master-userdata: Refreshing state...

...some output skipped...

aws_instance.worker: Still creating... (10s elapsed)
aws_instance.worker: Still creating... (20s elapsed)
aws_instance.worker: Still creating... (30s elapsed)
aws_instance.worker: Creation complete after 33s (ID: i-033ede3b0d02e4cfc)

Apply complete! Resources: 14 added, 0 changed, 0 destroyed.

Outputs:

kubernetes_master = 13.211.134.126
kubernetes_workers_public_ip = 13.55.91.220

```

#### Validation - Terraform state, master and worker node public IP, run remote kubectl commands through SSH to query nodes and all namespaces resources
```
$ make kubeadm-terraform-state
--- Query terraform deploying status
aws_iam_instance_profile.kubernetes
aws_iam_role.kubernetes
aws_iam_role_policy.kubernetes
aws_instance.controller_etcd
aws_instance.worker
aws_internet_gateway.gw
aws_key_pair.default_keypair
aws_route_table.kubernetes
aws_route_table_association.kubernetes
aws_security_group.kubernetes
aws_subnet.kubernetes
aws_vpc.kubernetes
aws_vpc_dhcp_options.dns_resolver
aws_vpc_dhcp_options_association.dns_resolver
template_file.etcd-userdata
template_file.master-userdata
template_file.worker-userdata

$ make master-ip
--- Terraform output master public IP: 13.211.134.126

$ make worker-ip
--- Terraform output worker public IP: 13.55.91.220

$ make kubectl-nodes
--- SSH into master node and kubectl get nodes -o wide
The authenticity of host '13.211.134.126 (13.211.134.126)' can't be established.
ECDSA key fingerprint is SHA256:q5/d8TimR2GZ/0fVkuiBHtSbyAd7dKOrRzDVfrQgJOw.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '13.211.134.126' (ECDSA) to the list of known hosts.
NAME                                            STATUS   ROLES    AGE     VERSION   INTERNAL-IP   EXTERNAL-IP      OS-IMAGE             KERNEL-VERSION     CONTAINER-RUNTIME
ip-10-43-0-30.ap-southeast-2.compute.internal   Ready    <none>   8m16s   v1.19.4   10.43.0.30    13.55.91.220     Ubuntu 16.04.1 LTS   4.4.0-45-generic   docker://19.3.13
ip-10-43-0-40.ap-southeast-2.compute.internal   Ready    master   8m40s   v1.19.4   10.43.0.40    13.211.134.126   Ubuntu 16.04.1 LTS   4.4.0-45-generic   docker://19.3.13

$ make kubectl-command
--- SSH into master node and kubectl get all -A
NAMESPACE     NAME                                                                        READY   STATUS    RESTARTS   AGE
kube-system   pod/calico-kube-controllers-5c6f6b67db-hj7gs                                1/1     Running   0          8m40s
kube-system   pod/canal-b4rbq                                                             2/2     Running   0          8m34s
kube-system   pod/canal-ltdzx                                                             2/2     Running   0          8m40s
kube-system   pod/coredns-f9fd979d6-gfwg9                                                 1/1     Running   0          8m40s
kube-system   pod/coredns-f9fd979d6-k82qk                                                 1/1     Running   0          8m40s
kube-system   pod/etcd-ip-10-43-0-40.ap-southeast-2.compute.internal                      1/1     Running   0          8m54s
kube-system   pod/kube-apiserver-ip-10-43-0-40.ap-southeast-2.compute.internal            1/1     Running   0          8m54s
kube-system   pod/kube-controller-manager-ip-10-43-0-40.ap-southeast-2.compute.internal   1/1     Running   0          8m54s
kube-system   pod/kube-proxy-j96q2                                                        1/1     Running   0          8m40s
kube-system   pod/kube-proxy-l2jzj                                                        1/1     Running   0          8m34s
kube-system   pod/kube-scheduler-ip-10-43-0-40.ap-southeast-2.compute.internal            1/1     Running   0          8m54s

NAMESPACE     NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE
default       service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP                  8m57s
kube-system   service/kube-dns     ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   8m55s

NAMESPACE     NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-system   daemonset.apps/canal        2         2         2       2            2           kubernetes.io/os=linux   8m52s
kube-system   daemonset.apps/kube-proxy   2         2         2       2            2           kubernetes.io/os=linux   8m55s

NAMESPACE     NAME                                      READY   UP-TO-DATE   AVAILABLE   AGE
kube-system   deployment.apps/calico-kube-controllers   1/1     1            1           8m52s
kube-system   deployment.apps/coredns                   2/2     2            2           8m55s

NAMESPACE     NAME                                                 DESIRED   CURRENT   READY   AGE
kube-system   replicaset.apps/calico-kube-controllers-5c6f6b67db   1         1         1       8m40s
kube-system   replicaset.apps/coredns-f9fd979d6                    2         2         2       8m40s
```

#### Alternatively, you can shell or SSM session in master node for local validation

##### SSH into master node

```bash
make ssh-master
--- SSH into master node
Welcome to Ubuntu 16.04.1 LTS (GNU/Linux 4.4.0-45-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

264 packages can be updated.
181 updates are security updates.

New release '18.04.5 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@ip-10-43-0-40:~$ kubectl config get-contexts
CURRENT   NAME                          CLUSTER      AUTHINFO           NAMESPACE
*         kubernetes-admin@kubernetes   kubernetes   kubernetes-admin
ubuntu@ip-10-43-0-40:~$ kubectl config current-context
kubernetes-admin@kubernetes
ubuntu@ip-10-43-0-40:~$ kubectl get nodes -o wide
NAME                                            STATUS   ROLES    AGE   VERSION   INTERNAL-IP   EXTERNAL-IP      OS-IMAGE             KERNEL-VERSION     CONTAINER-RUNTIME
ip-10-43-0-30.ap-southeast-2.compute.internal   Ready    <none>   14m   v1.19.4   10.43.0.30    13.55.91.220     Ubuntu 16.04.1 LTS   4.4.0-45-generic   docker://19.3.13
ip-10-43-0-40.ap-southeast-2.compute.internal   Ready    master   14m   v1.19.4   10.43.0.40    13.211.134.126   Ubuntu 16.04.1 LTS   4.4.0-45-generic   docker://19.3.13
ubuntu@ip-10-43-0-40:~$ kubectl get all -A
NAMESPACE     NAME                                                                        READY   STATUS    RESTARTS   AGE
kube-system   pod/calico-kube-controllers-5c6f6b67db-hj7gs                                1/1     Running   0          14m
kube-system   pod/canal-b4rbq                                                             2/2     Running   0          14m
kube-system   pod/canal-ltdzx                                                             2/2     Running   0          14m
kube-system   pod/coredns-f9fd979d6-gfwg9                                                 1/1     Running   0          14m
kube-system   pod/coredns-f9fd979d6-k82qk                                                 1/1     Running   0          14m
kube-system   pod/etcd-ip-10-43-0-40.ap-southeast-2.compute.internal                      1/1     Running   0          14m
kube-system   pod/kube-apiserver-ip-10-43-0-40.ap-southeast-2.compute.internal            1/1     Running   0          14m
kube-system   pod/kube-controller-manager-ip-10-43-0-40.ap-southeast-2.compute.internal   1/1     Running   0          14m
kube-system   pod/kube-proxy-j96q2                                                        1/1     Running   0          14m
kube-system   pod/kube-proxy-l2jzj                                                        1/1     Running   0          14m
kube-system   pod/kube-scheduler-ip-10-43-0-40.ap-southeast-2.compute.internal            1/1     Running   0          14m

NAMESPACE     NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE
default       service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP                  14m
kube-system   service/kube-dns     ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   14m

NAMESPACE     NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-system   daemonset.apps/canal        2         2         2       2            2           kubernetes.io/os=linux   14m
kube-system   daemonset.apps/kube-proxy   2         2         2       2            2           kubernetes.io/os=linux   14m

NAMESPACE     NAME                                      READY   UP-TO-DATE   AVAILABLE   AGE
kube-system   deployment.apps/calico-kube-controllers   1/1     1            1           14m
kube-system   deployment.apps/coredns                   2/2     2            2           14m

NAMESPACE     NAME                                                 DESIRED   CURRENT   READY   AGE
kube-system   replicaset.apps/calico-kube-controllers-5c6f6b67db   1         1         1       14m
kube-system   replicaset.apps/coredns-f9fd979d6                    2         2         2       14m

ubuntu@ip-10-43-0-40:~$ exit
logout
Connection to 13.211.134.126 closed.

```

##### SSM session into master node

```bash
$ ssm-session --list
i-0f56b8edf21c0c509   ip-10-43-0-40.ap-southeast-2.compute.internal   controller-etcd-0   10.43.0.40 13.211.134.126
i-033ede3b0d02e4cfc   ip-10-43-0-30.ap-southeast-2.compute.internal   worker-0            10.43.0.30 13.55.91.220

$ ssm-session controller-etcd-0

Starting session with SessionId: Jacky.So@myob.com-003175d7c02b14ada
$ id
uid=1001(ec2-user) gid=1001(ec2-user) groups=1001(ec2-user)
$ sudo bash
root@ip-10-43-0-40:/usr/bin# su - ubuntu
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@ip-10-43-0-40:~$ id
uid=1000(ubuntu) gid=1000(ubuntu) groups=1000(ubuntu),4(adm),20(dialout),24(cdrom),25(floppy),27(sudo),29(audio),30(dip),44(video),46(plugdev),109(netdev),110(lxd)

ubuntu@ip-10-43-0-40:~$ kubectl get nodes -o wide
NAME                                            STATUS   ROLES    AGE   VERSION   INTERNAL-IP   EXTERNAL-IP      OS-IMAGE             KERNEL-VERSION     CONTAINER-RUNTIME
ip-10-43-0-30.ap-southeast-2.compute.internal   Ready    <none>   16m   v1.19.4   10.43.0.30    13.55.91.220     Ubuntu 16.04.1 LTS   4.4.0-45-generic   docker://19.3.13
ip-10-43-0-40.ap-southeast-2.compute.internal   Ready    master   17m   v1.19.4   10.43.0.40    13.211.134.126   Ubuntu 16.04.1 LTS   4.4.0-45-generic   docker://19.3.13

ubuntu@ip-10-43-0-40:~$ exit
logout
root@ip-10-43-0-40:/usr/bin# exit
exit
$ exit
Exiting session with sessionId: Jacky.So@myob.com-003175d7c02b14ada.

```
