## Operation and automation in challenge 2

```bash
make

 Choose a command run:

kubeadm-terraform-shell                  Run docker kubeadm-terraform and /bin/bash
kubeadm-terraform-genkey                 Run docker kubeadm-terraform and generate key
kubeadm-terraform-token                  Run docker kubeadm-terraform and generate k8s token
kubeadm-terraform-version                Run docker kubeadm-terraform and show terraform version
kubeadm-terraform-state                  Query terraform state
kubeadm-terraform-show                   Show terraform state key_pair
kubeadm-terraform-init                   Run terraform init
kubeadm-terraform-plan                   Run terraform init and plan
kubeadm-terraform-deploy                 Run terraform init and deploy
kubeadm-terraform-undeploy               Run terraform init and destroy
master-ip                                Run terraform output master node public IP
worker-ip                                Run terraform output worker node public IP
awscli-sts                               Run awscli aws sts get-caller-identity
copy-image                               Run awscli copy image to your region
ssh-master                               SSH into Kubernetes master node
ssh-worker                               SSH into Kubernetes worker node
kubectl-nodes                            SSH into Kubernetes master node and kubectl get nodes -o wide
kubectl-command                          SSH into Kubernetes master node and kubectl $(COMMAND)
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
create-secret                            Copy secret file to master and apply to create secret into cluster default namespace
create-nginx-pod-environment             Copy nginx pod file to master and apply into cluster default namespace
nginx-container-shell                    Run interactive shell into pod security container nginx
```

### Run terraform plan

```bash
make kubeadm-terraform-plan
--- Terraform Plan

Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "template" (2.2.0)...
- Downloading plugin for provider "aws" (2.70.0)...

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
  Enter a value: 7d0e69.564b0e49a9f388c4

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
      vars.k8stoken:                               "7d0e69.564b0e49a9f388c4"
      vars.masterIP:                               "10.43.0.40"

 <= data.template_file.worker-userdata
      id:                                          <computed>
      rendered:                                    <computed>
      template:                                    "#!/bin/bash -ve\ntouch /home/ubuntu/worker.log\n\ncurl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -\ntouch /etc/apt/sources.list.d/kubernetes.list\n\nsu -c \"echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' >> \\\n    /etc/apt/sources.list.d/kubernetes.list\"\n\n# Install and start SSM agent \ncurl \"https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb\" -o \"amazon-ssm-agent.deb\"\napt-get install -y ./amazon-ssm-agent.deb && systemctl start amazon-ssm-agent.service\nuseradd -m -d /home/ec2-user -s /bin/bash ec2-user\nuseradd -m -d /home/ssm-user -s /bin/bash ssm-user\necho \"ssm-user ALL=(ALL) NOPASSWD:ALL\" > /etc/sudoers.d/ssm-agent-users\necho \"ec2-user ALL=(ALL) NOPASSWD:ALL\" > /etc/sudoers.d/ec2-user\n\n# Install kubelet kubeadm kubectl kubernetes-cni docker\napt-get update\napt-get install -y kubelet kubeadm kubectl kubernetes-cni\ncurl -sSL https://get.docker.com/ | sh\nsystemctl start docker\necho '[Finished] Installing kubelet kubeadm kubectl kubernetes-cni docker' >> /home/ubuntu/worker.log\n\nsystemctl stop docker\nmkdir /mnt/docker\nchmod 711 /mnt/docker\ncat <<EOF > /etc/docker/daemon.json\n{\n    \"data-root\": \"/mnt/docker\",\n    \"log-driver\": \"json-file\",\n    \"log-opts\": {\n        \"max-size\": \"10m\",\n        \"max-file\": \"5\"\n    }\n}\nEOF\nsystemctl start docker\nsystemctl enable docker\necho '[Finished] docker configure' >> /home/ubuntu/worker.log\n\n# Point kubelet at big ephemeral drive\nmkdir /mnt/kubelet\necho 'KUBELET_EXTRA_ARGS=\"--root-dir=/mnt/kubelet --cloud-provider=aws\"' > /etc/default/kubelet\necho '[Finished] kubelet configure' >> /home/ubuntu/worker.log\n\n# ----------------- from here same with worker.sh\n\n# Pass bridged IPv4 traffic to iptables chains (required by Flannel)\necho \"net.bridge.bridge-nf-call-iptables = 1\" > /etc/sysctl.d/60-flannel.conf\nservice procps start\n\necho '[Wait] kubeadm join until kubeadm cluster have been created.' >> /home/ubuntu/worker.log\nfor i in {1..50}; do sudo kubeadm join --token=${k8stoken} --discovery-token-unsafe-skip-ca-verification --node-name=$(hostname -f) ${masterIP}:6443 && break || sleep 15; done\n"
      vars.%:                                      "2"
      vars.k8stoken:                               "7d0e69.564b0e49a9f388c4"
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
      user_data:                                   "73bfda3838179a4340772aec7f82ad2909272a22"
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
      public_key:                                  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3A/n9FbJtKX3WzxoH4/cLpvwYhaGHW9ybVgkq+CzgQMjrsR2NovhqPvsy9034VfPVX/Z0ob7HJy59pszfz+PRDGeslynf4c2eDXZTqNzjosfuIXVSjssr03p85PK1xMMvypbQ+KcDP2fuo4DB4DlqT3KRkt4TcwDpNgTUtOAzZJ/+JJUDYfn8xrMAtJ0glUIbN+EuGMnKSHYgKU103xXl9uiy/PZ0o20XsJi8cBWfY0UF/L9SKls6zWzKh6NraPS7dXx3EFb7VuFeanhwXkH+rj38gHZ5aIO57NjXoMN8PmjC2Cm3Qr2Ygqg0OKwyZBH/uwZSTrRqfoDOmuAwxs6H root@25d71902fce3"

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
