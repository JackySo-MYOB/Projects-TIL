# Challenge2 Sub-task4 and validation

### Sub-task4 requirements
```
We have the following file containing environment variables:
CREDENTIAL_001=-bQ(ETLPGE[uT?6C;ed
CREDENTIAL_002=C_;SU@ev7yg.8m6hNqS
CREDENTIAL_003=ZA#$$-Ml6et&4?pKdvy
CREDENTIAL_004=QlIc3$5*+SKsw==9=p{
CREDENTIAL_005=C_2\a{]XD}1#9BpE[k?
CREDENTIAL_006=9*KD8_w<);ozb:ns;JC
CREDENTIAL_007=C[V$Eb5yQ)c~!..{LRT
SETTING_USE_SEC=true
SETTING_ALLOW_ANON=true
SETTING_PREVENT_ADMIN_LOGIN=true
Make all key/values available in a Pod
• Create a Secret that contains all environment variables from that file
• Create a pod of image nginx that makes all secret entries available as environment
variables. For example usable by echo $CREDENTIAL_001 etc…
```

#### File `sub-tasks-4.txt` containing above environment variables

```bash
cat sub-tasks-4.txt
CREDENTIAL_001=-bQ(ETLPGE[uT?6C;ed
CREDENTIAL_002=C_;SU@ev7yg.8m6hNqS
CREDENTIAL_003=ZA#$$-Ml6et&4?pKdvy
CREDENTIAL_004=QlIc3$5*+SKsw==9=p{
CREDENTIAL_005=C_2\a{]XD}1#9BpE[k?
CREDENTIAL_006=9*KD8_w<);ozb:ns;JC
CREDENTIAL_007=C[V$Eb5yQ)c~!..{LRT
SETTING_USE_SEC=true
SETTING_ALLOW_ANON=true
SETTING_PREVENT_ADMIN_LOGIN=true
```

#### Primarily, i will use GNU make as automation to walk through `sub-tasks 4` work and validation  - see menu below with highlighted and used in this sub-task

```diff
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
-master-ip                                Run terraform output master node public IP
worker-ip                                Run terraform output worker node public IP
awscli-sts                               Run awscli aws sts get-caller-identity
copy-image                               Run awscli copy image to your region
-ssh-master                               SSH into Kubernetes master node
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
+populate-secret-file                     Populate environments from file and generate yaml/$(SECRETS)
+create-secret                            Copy secret file to master and apply to create secret into cluster default namespace
+create-nginx-pod-environment             Copy nginx pod file to master and apply into cluster default namespace
+nginx-container-shell                    Run interactive shell into pod nginx-secret-env-pod
+nginx-container-env                      Query environment variables in running pod nginx-secret-env-pod

```

### Run `make populate-secret-file` to populate secrets manifest yaml file

```bash
make populate-secret-file
--- Populate environments into secret manifest file yaml/secrets.yaml
apiVersion: v1
kind: Secret
metadata:
  name: environment
type: Opaque
stringData:
    CREDENTIAL_001: '-bQ(ETLPGE[uT?6C;ed'
    CREDENTIAL_002: 'C_;SU@ev7yg.8m6hNqS'
    CREDENTIAL_003: 'ZA#$$-Ml6et&4?pKdvy'
    CREDENTIAL_004: 'QlIc3$5*+SKsw==9=p{'
    CREDENTIAL_005: 'C_2\a{]XD}1#9BpE[k?'
    CREDENTIAL_006: '9*KD8_w<);ozb:ns;JC'
    CREDENTIAL_007: 'C[V$Eb5yQ)c~!..{LRT'
    SETTING_USE_SEC: 'true'
    SETTING_ALLOW_ANON: 'true'
    SETTING_PREVENT_ADMIN_LOGIN: 'true'
```

### Run `make create-secret` to upload secrets manifest file to master node and kubectl apply secrets

```bash
make create-secret
--- SCP file into master node and kubectl apply
secrets.yaml                                                                                                                        100%  476    17.9KB/s   00:00
secret/environment created

NAME                  TYPE                                  DATA   AGE
default-token-4hmkd   kubernetes.io/service-account-token   3      5h11m
environment           Opaque                                10     1s
```

### Run `make create-nginx-pod-environment` to create nginx pod with environment variable configuration from secret `environment`
```bash
make create-nginx-pod-environment
--- SCP file into master node and kubectl apply
pod-environments.yaml                                                                                                               100% 1576    55.5KB/s   00:00
pod/nginx-secret-env-pod created
```

### Run `make nginx-container-env` to run env command and grep for `CREDENTIAL_00` and `SETTING_` pattern in pod `nginx-secret-env-pod`
```bash
make nginx-container-env
--- kubectl exec --stdin --tty nginx-secret-env-pod env
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
SETTING_USE_SEC=true
CREDENTIAL_003=ZA#$$-Ml6et&4?pKdvy
CREDENTIAL_005=C_2\a{]XD}1#9BpE[k?
CREDENTIAL_006=9*KD8_w<);ozb:ns;JC
CREDENTIAL_007=C[V$Eb5yQ)c~!..{LRT
SETTING_PREVENT_ADMIN_LOGIN=true
CREDENTIAL_001=-bQ(ETLPGE[uT?6C;ed
CREDENTIAL_002=C_;SU@ev7yg.8m6hNqS
CREDENTIAL_004=QlIc3$5*+SKsw==9=p{
SETTING_ALLOW_ANON=true
Connection to 54.79.134.71 closed.
```

### Run `make nginx-container-shell` to shell in pod `nginx-secret-env-pod` and run display environments variables
```bash
make nginx-container-shell
--- kubectl exec --stdin --tty nginx-secret-env-pod  -- /bin/bash

root@nginx-secret-env-pod:/# echo $CREDENTIAL_001
-bQ(ETLPGE[uT?6C;ed

root@nginx-secret-env-pod:/# echo $CREDENTIAL_002
C_;SU@ev7yg.8m6hNqS

root@nginx-secret-env-pod:/# echo $CREDENTIAL_003
ZA#$$-Ml6et&4?pKdvy

root@nginx-secret-env-pod:/# echo $CREDENTIAL_004
QlIc3$5*+SKsw==9=p{

root@nginx-secret-env-pod:/# echo $CREDENTIAL_005
C_2\a{]XD}1#9BpE[k?

root@nginx-secret-env-pod:/# echo $CREDENTIAL_006
9*KD8_w<);ozb:ns;JC

root@nginx-secret-env-pod:/# echo $CREDENTIAL_007
C[V$Eb5yQ)c~!..{LRT

root@nginx-secret-env-pod:/# echo $SETTING_PREVENT_ADMIN_LOGIN
true
```

#### Alternatively, you can shell in master node for local validation

```bash
make master-ip
--- Terraform output master public IP: 54.79.134.71

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

Last login: Thu Nov 19 04:30:20 2020 from 101.182.40.233
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@ip-10-43-0-40:~$
ubuntu@ip-10-43-0-40:~$ kubectl get pods -o wide
NAME                   READY   STATUS    RESTARTS   AGE   IP           NODE                                            NOMINATED NODE   READINESS GATES
nginx-secret-env-pod   1/1     Running   0          42m   10.244.1.3   ip-10-43-0-30.ap-southeast-2.compute.internal   <none>           <none>

ubuntu@ip-10-43-0-40:~$ kubectl get secrets -o wide
NAME                  TYPE                                  DATA   AGE
default-token-4hmkd   kubernetes.io/service-account-token   3      5h54m
environment           Opaque                                10     42m
from-file             Opaque                                1      5h41m

ubuntu@ip-10-43-0-40:~$ exit
logout
Connection to 54.79.134.71 closed.
```
