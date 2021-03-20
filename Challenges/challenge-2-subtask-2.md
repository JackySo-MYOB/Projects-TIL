# Challenge2 Sub-task2 and validation

### Sub-task2 requirements
Make sure all your NetworkPolicies still allow DNS resolution.
• implement a NetworkPolicy for nginx pods to only allow egress to the internal api pods on
port 5764. No access to the outer world (but DNS).
• implement a NetworkPolicy for api pods to only allow ingress on port 5764 from the
internal nginx pods.
• implement a NetworkPolicy for api pods to only allow egress to (IP of quay.io) port 443.

#### Scenario Setup
```yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: security
  name: security
spec:
  volumes:
  - name: share
    emptyDir: {}
  containers:
  - command:
    - /bin/sh
    - -c
    - sleep 1d
    image: nginx
    name: sec1
    volumeMounts:
    - name: share
      mountPath: /tmp/share
  - command:
    - /bin/sh
    - -c
    - sleep 1d
    image: nginx
    name: sec2
    volumeMounts:
    - name: share
      mountPath: /tmp/share
  restartPolicy: Never
```

File `yaml/scenario.yaml` containing above scenario setup code

### Solution files in yaml folder - see highlighted

```diff
yaml
├── container-security-context.yaml
+├── network-policy-1.yaml
+├── network-policy-2.yaml
+├── network-policy-3.yaml
├── pod-environments.yaml
├── pod-security-context.yaml
├── scenario.yaml
├── secrets-template.yaml
└── secrets.yaml

```

#### Primarily, i will use GNU make as automation to walk through `sub-tasks 2` work and validation  - see menu below with highlighted and used in this sub-task

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
master-ip                                Run terraform output master node public IP
worker-ip                                Run terraform output worker node public IP
awscli-sts                               Run awscli aws sts get-caller-identity
copy-image                               Run awscli copy image to your region
ssh-master                               SSH into Kubernetes master node
ssh-worker                               SSH into Kubernetes worker node
kubectl-nodes                            SSH into Kubernetes master node and kubectl get nodes -o wide
kubectl-command                          SSH into Kubernetes master node and kubectl $(COMMAND)
apply-scenario                           Copy scenario file to master and apply into cluster
+apply-network-policy-1                   Copy network-policy-1 file to master and apply into cluster
+apply-network-policy-2                   Copy network-policy-2 file to master and apply into cluster
+apply-network-policy-3                   Copy network-policy-3 file to master and apply into cluster
delete-scenario                          Delete scenario from cluster
+get-pods                                 Get pods in default namespace
+get-networkpolicies                      Get networkpolicies in all namespaces
+run-test-pod-shell                       Run test pod in cluster and interactive shell
+run-test-pod-label-api-shell             Run test pod in cluster with label app=api and interactive shell
+run-web-pod                              Run web pod in cluster default namespace and expose por 80 for testing target
+delete-web-pod                           Delete web service and pod from cluster default namespace
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

### Validate running cluster are in default open state to allow ingress and egress connection before we start to apply network policies

#### Run `make run-web-pod` to launch nginx web pod for inner cluster testing

```bash
$ make run-web-pod
--- kubectl run web --image=nginx --labels app=web --expose --port 80
service/web created
pod/web created
NAME      READY   STATUS              RESTARTS   AGE   IP       NODE                                            NOMINATED NODE   READINESS GATES
pod/web   0/1     ContainerCreating   0          0s    <none>   ip-10-43-0-30.ap-southeast-2.compute.internal   <none>           <none>

NAME                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)   AGE     SELECTOR
service/kubernetes   ClusterIP   10.96.0.1        <none>        443/TCP   5h55m   <none>
service/web          ClusterIP   10.111.134.249   <none>        80/TCP    0s      app=web
```

#### Run `make get-networkpolicies` to check no network policies applied in default namespace

```bash
$ make get-networkpolicies
--- kubectl get networkpolicies -A
No resources found
```

#### Run `make run-test-pod-shell` to run test pod and validate successfully run nslookup, http://web, and https://quay.io

```bash
$ make run-test-pod-shell
--- kubectl run --rm -i -t --image=alpine --labels app=test test-60211 -- sh
If you don't see a command prompt, try pressing enter.
/ # nslookup www.anz.com
Server:		10.96.0.10
Address:	10.96.0.10:53

Non-authoritative answer:
www.anz.com	canonical name = ksjnk4a.x.incapdns.net
Name:	ksjnk4a.x.incapdns.net
Address: 45.60.126.46

Non-authoritative answer:
www.anz.com	canonical name = ksjnk4a.x.incapdns.net

/ # wget -qO- http://web
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
/ # wget -qO- https://quay.io
<!DOCTYPE html>
<html ng-app="quay" class="hosted">
  <head>
    <base href="/">


  <title ng-bind="title + ' · Quay'">Quay</title>



  <base href="/">
```

### Apply scenario setup and first network policy to block ingress and egress except DNS query

```bash
$ make apply-scenario
--- SCP file into master node and kubectl apply
scenario.yaml                                                                                                                       100%  487    20.4KB/s   00:00
pod/security created

$ make apply-network-policy-1
--- SCP file into master node and kubectl apply
network-policy-1.yaml                                                                                                               100%  497    22.0KB/s   00:00
networkpolicy.networking.k8s.io/deny-all created
networkpolicy.networking.k8s.io/allow-dns created

$ make get-networkpolicies
--- kubectl get networkpolicies -A
NAMESPACE   NAME        POD-SELECTOR   AGE
default     allow-dns   <none>         16s
default     deny-all    <none>         16s

```

#### Validation for first network policy applied - http://web and https://quay.io are blocking and DNS query allowing

```bash
$ make run-test-pod-shell
--- kubectl run --rm -i -t --image=alpine --labels app=test test-19751 -- sh
If you don't see a command prompt, try pressing enter.
/ # nslookup www.anz.com
Server:		10.96.0.10
Address:	10.96.0.10:53

Non-authoritative answer:
www.anz.com	canonical name = ksjnk4a.x.incapdns.net
Name:	ksjnk4a.x.incapdns.net
Address: 45.60.126.46

Non-authoritative answer:
www.anz.com	canonical name = ksjnk4a.x.incapdns.net

/ # nslookup www.redhat.com
Server:		10.96.0.10
Address:	10.96.0.10:53

Non-authoritative answer:
www.redhat.com	canonical name = ds-www.redhat.com.edgekey.net
ds-www.redhat.com.edgekey.net	canonical name = ds-www.redhat.com.edgekey.net.globalredir.akadns.net
ds-www.redhat.com.edgekey.net.globalredir.akadns.net	canonical name = e3396.dscx.akamaiedge.net
Name:	e3396.dscx.akamaiedge.net
Address: 2600:1415:11:4ad::d44
Name:	e3396.dscx.akamaiedge.net
Address: 2600:1415:11:4a7::d44

Non-authoritative answer:
www.redhat.com	canonical name = ds-www.redhat.com.edgekey.net
ds-www.redhat.com.edgekey.net	canonical name = ds-www.redhat.com.edgekey.net.globalredir.akadns.net
ds-www.redhat.com.edgekey.net.globalredir.akadns.net	canonical name = e3396.dscx.akamaiedge.net
Name:	e3396.dscx.akamaiedge.net
Address: 104.98.41.96

/ # wget -qO- http://web
^C
/ # wget -qO- https://quay.io
^C
/ # exit
Session ended, resume using 'kubectl attach test-19751 -c test-19751 -i -t' command when the pod is running
pod "test-19751" deleted
Connection to 13.211.134.126 closed.
```

### Apply second set network polices to allow ingress and egree traffic between pod nginx and api

```bash
$ make apply-network-policy-2
--- SCP file into master node and kubectl apply
network-policy-2.yaml                                                                                                               100%  816    31.6KB/s   00:00
networkpolicy.networking.k8s.io/allow-egress-ngnix-to-api created
networkpolicy.networking.k8s.io/allow-ingress-api-from-nginx created
jso@ubunu2004:~/myob-work/work/aws-cf/git-repo/project-resources/project/anz-code-challenge-2$ make get-networkpolicies
--- kubectl get networkpolicies -A
NAMESPACE   NAME                           POD-SELECTOR   AGE
default     allow-dns                      <none>         6m37s
default     allow-egress-ngnix-to-api      app=nginx      11s
default     allow-ingress-api-from-nginx   app=api        11s
default     deny-all                       <none>         6m37s
```

#### Remarks: No Valiation for second set of network policies as api and port 5764 are dummy and not exists

```bash
ubuntu@ip-10-43-0-40:~$ kubectl get pods -A
NAMESPACE     NAME                                                                    READY   STATUS    RESTARTS   AGE
default       security                                                                2/2     Running   0          19m
default       web                                                                     1/1     Running   0          31m
kube-system   calico-kube-controllers-5c6f6b67db-hj7gs                                1/1     Running   0          6h26m
kube-system   canal-b4rbq                                                             2/2     Running   0          6h26m
kube-system   canal-ltdzx                                                             2/2     Running   0          6h26m
kube-system   coredns-f9fd979d6-gfwg9                                                 1/1     Running   0          6h26m
kube-system   coredns-f9fd979d6-k82qk                                                 1/1     Running   0          6h26m
kube-system   etcd-ip-10-43-0-40.ap-southeast-2.compute.internal                      1/1     Running   0          6h26m
kube-system   kube-apiserver-ip-10-43-0-40.ap-southeast-2.compute.internal            1/1     Running   0          6h26m
kube-system   kube-controller-manager-ip-10-43-0-40.ap-southeast-2.compute.internal   1/1     Running   0          6h26m
kube-system   kube-proxy-j96q2                                                        1/1     Running   0          6h26m
kube-system   kube-proxy-l2jzj                                                        1/1     Running   0          6h26m
kube-system   kube-scheduler-ip-10-43-0-40.ap-southeast-2.compute.internal            1/1     Running   0          6h26m
```
### Apply last network policy to allow egress traffic to quay.io IPs

```bash
$ make apply-network-policy-3
--- SCP file into master node and kubectl apply
network-policy-3.yaml                                                                                                               100%  688    24.6KB/s   00:00
networkpolicy.networking.k8s.io/allow-https-quay.io created
jso@ubunu2004:~/myob-work/work/aws-cf/git-repo/project-resources/project/anz-code-challenge-2$ make get-networkpolicies
--- kubectl get networkpolicies -A
NAMESPACE   NAME                           POD-SELECTOR   AGE
default     allow-dns                      <none>         22m
default     allow-egress-ngnix-to-api      app=nginx      15m
default     allow-https-quay.io            app=api        11s
default     allow-ingress-api-from-nginx   app=api        15m
default     deny-all                       <none>         22m
```
#### First validation from test pod - you will fail to https://quay.io as network policy allow from pod label app=api but test label is app=test

```bash
$ make run-test-pod-shell
--- kubectl run --rm -i -t --image=alpine --labels app=test test-20985 -- sh
If you don't see a command prompt, try pressing enter.
/ # nslookup quay.io
Server:		10.96.0.10
Address:	10.96.0.10:53

Non-authoritative answer:
Non-authoritative answer:
Name:	quay.io
Address: 54.173.177.143
Name:	quay.io
Address: 54.210.241.179
Name:	quay.io
Address: 34.232.39.178
Name:	quay.io
Address: 54.211.185.136
Name:	quay.io
Address: 52.0.92.170
Name:	quay.io
Address: 3.225.137.144
Name:	quay.io
Address: 3.215.193.214
Name:	quay.io
Address: 52.201.153.168

/ # wget -qO- https://quay.io
^C
/ # wget -qO- https://quay.io
^C
/ # exit
Session ended, resume using 'kubectl attach test-20985 -c test-20985 -i -t' command when the pod is running
pod "test-20985" deleted
Connection to 13.211.134.126 closed.
```

#### Second validation from test pod - you will success to https://quay.io as network policy allow from test pod label app=api

```bash
$ make run-test-pod-label-api-shell
--- kubectl run --rm -i -t --image=alpine --labels app=api test-53109 -- sh
If you don't see a command prompt, try pressing enter.
/ # nslookup quay.io
Server:		10.96.0.10
Address:	10.96.0.10:53

Non-authoritative answer:
Name:	quay.io
Address: 54.210.241.179
Name:	quay.io
Address: 52.201.153.168
Name:	quay.io
Address: 54.211.185.136
Name:	quay.io
Address: 3.215.193.214
Name:	quay.io
Address: 34.232.39.178
Name:	quay.io
Address: 3.225.137.144
Name:	quay.io
Address: 54.173.177.143
Name:	quay.io
Address: 34.200.178.190

Non-authoritative answer:
/ # wget -qO- https://quay.io
<!DOCTYPE html>
<html ng-app="quay" class="hosted">
  <head>
    <base href="/">


  <title ng-bind="title + ' · Quay'">Quay</title>



  <base href="/">

  <meta id="descriptionTag" name="description" content="Quay is the best place to build, store, and distribute your containers. Public repositories are always free." />
```
### Cleanup network policies and validation pods

```bash

$ make get-pods
--- kubectl get pods -o wide
NAME       READY   STATUS    RESTARTS   AGE   IP           NODE                                            NOMINATED NODE   READINESS GATES
security   2/2     Running   0          44m   10.244.1.5   ip-10-43-0-30.ap-southeast-2.compute.internal   <none>           <none>
web        1/1     Running   0          56m   10.244.1.3   ip-10-43-0-30.ap-southeast-2.compute.internal   <none>           <none>
jso@ubunu2004:~/myob-work/work/aws-cf/git-repo/project-resources/project/anz-code-challenge-2$ make delete-web-pod
--- kubectl delete pod/web; kubectl delete service/web
service "web" deleted
pod "web" deleted
NAME           READY   STATUS    RESTARTS   AGE   IP           NODE                                            NOMINATED NODE   READINESS GATES
pod/security   2/2     Running   0          44m   10.244.1.5   ip-10-43-0-30.ap-southeast-2.compute.internal   <none>           <none>

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE     SELECTOR
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   6h51m   <none>
jso@ubunu2004:~/myob-work/work/aws-cf/git-repo/project-resources/project/anz-code-challenge-2$ make get-pods
--- kubectl get pods -o wide
NAME       READY   STATUS    RESTARTS   AGE   IP           NODE                                            NOMINATED NODE   READINESS GATES
security   2/2     Running   0          44m   10.244.1.5   ip-10-43-0-30.ap-southeast-2.compute.internal   <none>           <none>
jso@ubunu2004:~/myob-work/work/aws-cf/git-repo/project-resources/project/anz-code-challenge-2$ ssh-master
ssh-master: command not found
jso@ubunu2004:~/myob-work/work/aws-cf/git-repo/project-resources/project/anz-code-challenge-2$ make ssh-master
--- SSH into master node
Welcome to Ubuntu 16.04.1 LTS (GNU/Linux 4.4.0-45-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud
Last login: Thu Nov 19 12:44:47 2020 from 101.182.40.233

ubuntu@ip-10-43-0-40:~$ ls
master.log  network-policy-1.yaml  network-policy-2.yaml  network-policy-3.yaml  scenario.yaml

ubuntu@ip-10-43-0-40:~$ kubectl delete -f network-policy-1.yaml
networkpolicy.networking.k8s.io "deny-all" deleted
networkpolicy.networking.k8s.io "allow-dns" deleted

ubuntu@ip-10-43-0-40:~$ kubectl delete -f network-policy-2.yaml
networkpolicy.networking.k8s.io "allow-egress-ngnix-to-api" deleted
networkpolicy.networking.k8s.io "allow-ingress-api-from-nginx" deleted

ubuntu@ip-10-43-0-40:~$ kubectl delete -f network-policy-3.yaml
networkpolicy.networking.k8s.io "allow-https-quay.io" deleted

ubuntu@ip-10-43-0-40:~$ kubectl get networkpolicies
No resources found in default namespace.
ubuntu@ip-10-43-0-40:~$ kubectl get networkpolicies -A
No resources found
ubuntu@ip-10-43-0-40:~$ exit
logout
Connection to 13.211.134.126 closed.
```
