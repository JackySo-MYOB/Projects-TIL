# Challenge2 Sub-task3 and validation

### Sub-task3 requirements
```
Log into container sec1 and create a file in the shared volume. View that file and its permissions via container sec2.
• Create a pod wide Security Context so that programs on all containers are run as user 1331.
Apply the changes and repeat step 1. Check file permissions and owner. Hint: use whoami: you will find error as did 1331 is not a predefined userid but that’s ok
• Create a Security Context for container sec1 to run programs as root. Hence files should be created as root too. Repeat step 1. Check file permissions and owner. Try do delete the file container
sec1 created from container sec2. Does it work?
```

### Solution files in yaml folder - see highlighted

```diff
yaml
+├── container-security-context.yaml
├── network-policy-1.yaml
├── network-policy-2.yaml
├── network-policy-3.yaml
├── network-policy-4.yaml
├── pod-environments.yaml
+├── pod-security-context.yaml
├── scenario.yaml
├── secrets-template.yaml
└── secrets.yaml

```

#### Primarily, i will use GNU make as automation to walk through `sub-tasks 3` work and validation  - see menu below with highlighted and used in this sub-task

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
+kubectl-command                          SSH into Kubernetes master node and kubectl $(COMMAND)
+apply-scenario                           Copy scenario file to master and apply into cluster
apply-network-policy-1                   Copy network-policy-1 file to master and apply into cluster
apply-network-policy-2                   Copy network-policy-2 file to master and apply into cluster
apply-network-policy-3                   Copy network-policy-3 file to master and apply into cluster
delete-scenario                          Delete scenario from cluster
get-pods                                 Get pods in default namespace
get-networkpolicies                      Get networkpolicies in all namespaces
run-test-pod-shell                       Run test pod in cluster and interactive shell
run-web-pod                              Run web pod in cluster default namespace and expose por 80 for testing target
delete-web-pod                           Delete web service and pod from cluster default namespace
+sec1-container-shell                     Run interactive shell into pod security container sec1
+sec2-container-shell                     Run interactive shell into pod security container sec2
+apply-pod-security-context               Copy pod security context file to master and apply into cluster
+delete-pod-security-context              Delete pod security context file from cluster
+apply-container-security-context         Copy container security context file to master and apply into cluster
+delete-container-security-context        Delete container security context file from cluster
populate-secret-file                     Populate environments from file and generate yaml/$(SECRETS)
create-secret                            Copy secret file to master and apply to create secret into cluster default namespace
create-nginx-pod-environment             Copy nginx pod file to master and apply into cluster default namespace
nginx-container-shell                    Run interactive shell into pod nginx-secret-env-pod
nginx-container-env                      Query environment variables in running pod nginx-secret-env-pod

```

### Log into container sec1 and create a file in the shared volume. View that file and its permissions via container sec2.

```bash
$ make get-pods
--- kubectl get pods -o wide
NAME       READY   STATUS    RESTARTS   AGE   IP           NODE                                            NOMINATED NODE   READINESS GATES
security   2/2     Running   0          59m   10.244.1.5   ip-10-43-0-30.ap-southeast-2.compute.internal   <none>           <none>
jso@ubunu2004:~/myob-work/work/aws-cf/git-repo/project-resources/project/anz-code-challenge-2$ make sec1-container-shell
--- kubectl exec --stdin --tty security -c sec1 -- /bin/bash
root@security:/# df -h
Filesystem      Size  Used Avail Use% Mounted on
overlay         7.8G  2.8G  4.6G  38% /
tmpfs            64M     0   64M   0% /dev
tmpfs           2.0G     0  2.0G   0% /sys/fs/cgroup
/dev/xvda1      7.8G  2.8G  4.6G  38% /etc/hosts
shm              64M     0   64M   0% /dev/shm
tmpfs           2.0G   12K  2.0G   1% /run/secrets/kubernetes.io/serviceaccount
tmpfs           2.0G     0  2.0G   0% /proc/acpi
tmpfs           2.0G     0  2.0G   0% /proc/scsi
tmpfs           2.0G     0  2.0G   0% /sys/firmware
root@security:/# id -a
uid=0(root) gid=0(root) groups=0(root)
root@security:/# echo "This is from sec1" > /tmp/share/testfile.txt
root@security:/# ls -al /tmp/share/testfile.txt
-rw-r--r-- 1 root root 18 Nov 19 13:07 /tmp/share/testfile.txt
root@security:/# exit
exit
Connection to 13.211.134.126 closed.
jso@ubunu2004:~/myob-work/work/aws-cf/git-repo/project-resources/project/anz-code-challenge-2$ make sec2-container-shell
--- kubectl exec --stdin --tty security -c sec2 -- /bin/bash
root@security:/# df -h
Filesystem      Size  Used Avail Use% Mounted on
overlay         7.8G  2.8G  4.6G  38% /
tmpfs            64M     0   64M   0% /dev
tmpfs           2.0G     0  2.0G   0% /sys/fs/cgroup
/dev/xvda1      7.8G  2.8G  4.6G  38% /tmp/share
shm              64M     0   64M   0% /dev/shm
tmpfs           2.0G   12K  2.0G   1% /run/secrets/kubernetes.io/serviceaccount
tmpfs           2.0G     0  2.0G   0% /proc/acpi
tmpfs           2.0G     0  2.0G   0% /proc/scsi
tmpfs           2.0G     0  2.0G   0% /sys/firmware
root@security:/# id -a
uid=0(root) gid=0(root) groups=0(root)
root@security:/# ls -al /tmp/share/testfile.txt
-rw-r--r-- 1 root root 18 Nov 19 13:07 /tmp/share/testfile.txt
root@security:/# cat /tmp/share/testfile.txt
This is from sec1
root@security:/# exit
exit
Connection to 13.211.134.126 closed.
```

### Create a pod wide Security Context so that programs on all containers are run as user 1331.

```bash

$ make delete-scenario
--- kubectl delete scenario
pod "security" deleted
jso@ubunu2004:~/myob-work/work/aws-cf/git-repo/project-resources/project/anz-code-challenge-2$ make apply-pod-security-context
--- SCP file into master node and kubectl apply
pod-security-context.yaml                                                                                                           100%  526    20.5KB/s   00:00
pod/security created

$ make kubectl-command COMMAND="get pod/security -o yaml"
--- SSH into master node and kubectl get pod/security -o yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    cni.projectcalico.org/podIP: 10.244.1.10/32
    cni.projectcalico.org/podIPs: 10.244.1.10/32
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"creationTimestamp":null,"labels":{"run":"security"},"name":"security","namespace":"default"},"spec":{"containers":[{"command":["/bin/sh","-c","sleep 1d"],"image":"nginx","name":"sec1","volumeMounts":[{"mountPath":"/tmp/share","name":"share"}]},{"command":["/bin/sh","-c","sleep 1d"],"image":"nginx","name":"sec2","volumeMounts":[{"mountPath":"/tmp/share","name":"share"}]}],"restartPolicy":"Never","securityContext":{"runAsUser":1331},"volumes":[{"emptyDir":{},"name":"share"}]}}
  creationTimestamp: "2020-11-19T13:13:17Z"
  labels:
    run: security
  managedFields:
  - apiVersion: v1
    fieldsType: FieldsV1
    fieldsV1:
      f:metadata:
        f:annotations:
          f:cni.projectcalico.org/podIP: {}
          f:cni.projectcalico.org/podIPs: {}
    manager: calico
    operation: Update
    time: "2020-11-19T13:13:17Z"
  - apiVersion: v1
    fieldsType: FieldsV1
    fieldsV1:
      f:metadata:
        f:annotations:
          .: {}
          f:kubectl.kubernetes.io/last-applied-configuration: {}
        f:labels:
          .: {}
          f:run: {}
      f:spec:
        f:containers:
          k:{"name":"sec1"}:
            .: {}
            f:command: {}
            f:image: {}
            f:imagePullPolicy: {}
            f:name: {}
            f:resources: {}
            f:terminationMessagePath: {}
            f:terminationMessagePolicy: {}
            f:volumeMounts:
              .: {}
              k:{"mountPath":"/tmp/share"}:
                .: {}
                f:mountPath: {}
                f:name: {}
          k:{"name":"sec2"}:
            .: {}
            f:command: {}
            f:image: {}
            f:imagePullPolicy: {}
            f:name: {}
            f:resources: {}
            f:terminationMessagePath: {}
            f:terminationMessagePolicy: {}
            f:volumeMounts:
              .: {}
              k:{"mountPath":"/tmp/share"}:
                .: {}
                f:mountPath: {}
                f:name: {}
        f:dnsPolicy: {}
        f:enableServiceLinks: {}
        f:restartPolicy: {}
        f:schedulerName: {}
        f:securityContext:
          .: {}
          f:runAsUser: {}
        f:terminationGracePeriodSeconds: {}
        f:volumes:
          .: {}
          k:{"name":"share"}:
            .: {}
            f:emptyDir: {}
            f:name: {}
    manager: kubectl-client-side-apply
    operation: Update
    time: "2020-11-19T13:13:17Z"
  - apiVersion: v1
    fieldsType: FieldsV1
    fieldsV1:
      f:status:
        f:conditions:
          k:{"type":"ContainersReady"}:
            .: {}
            f:lastProbeTime: {}
            f:lastTransitionTime: {}
            f:status: {}
            f:type: {}
          k:{"type":"Initialized"}:
            .: {}
            f:lastProbeTime: {}
            f:lastTransitionTime: {}
            f:status: {}
            f:type: {}
          k:{"type":"Ready"}:
            .: {}
            f:lastProbeTime: {}
            f:lastTransitionTime: {}
            f:status: {}
            f:type: {}
        f:containerStatuses: {}
        f:hostIP: {}
        f:phase: {}
        f:podIP: {}
        f:podIPs:
          .: {}
          k:{"ip":"10.244.1.10"}:
            .: {}
            f:ip: {}
        f:startTime: {}
    manager: kubelet
    operation: Update
    time: "2020-11-19T13:13:25Z"
  name: security
  namespace: default
  resourceVersion: "60648"
  selfLink: /api/v1/namespaces/default/pods/security
  uid: 3c5710b2-a458-4e2e-ac57-3d12ed7d71f0
spec:
  containers:
  - command:
    - /bin/sh
    - -c
    - sleep 1d
    image: nginx
    imagePullPolicy: Always
    name: sec1
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /tmp/share
      name: share
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: default-token-94bqv
      readOnly: true
  - command:
    - /bin/sh
    - -c
    - sleep 1d
    image: nginx
    imagePullPolicy: Always
    name: sec2
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /tmp/share
      name: share
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: default-token-94bqv
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  nodeName: ip-10-43-0-30.ap-southeast-2.compute.internal
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Never
  schedulerName: default-scheduler
  securityContext:
    runAsUser: 1331
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - emptyDir: {}
    name: share
  - name: default-token-94bqv
    secret:
      defaultMode: 420
      secretName: default-token-94bqv
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2020-11-19T13:13:17Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2020-11-19T13:13:25Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2020-11-19T13:13:25Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2020-11-19T13:13:17Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: docker://7a6da3b7551cd376cc31964271e9367534c08ab8b3b7118a41022b072b0bd283
    image: nginx:latest
    imageID: docker-pullable://nginx@sha256:c3a1592d2b6d275bef4087573355827b200b00ffc2d9849890a4f3aa2128c4ae
    lastState: {}
    name: sec1
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2020-11-19T13:13:21Z"
  - containerID: docker://76e9c01103a4ccd99bb6a5ca8783ea48045ab59dda18a703385ef431cdaf5b3b
    image: nginx:latest
    imageID: docker-pullable://nginx@sha256:c3a1592d2b6d275bef4087573355827b200b00ffc2d9849890a4f3aa2128c4ae
    lastState: {}
    name: sec2
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2020-11-19T13:13:24Z"
  hostIP: 10.43.0.30
  phase: Running
  podIP: 10.244.1.10
  podIPs:
  - ip: 10.244.1.10
  qosClass: BestEffort
  startTime: "2020-11-19T13:13:17Z"


```

#### Apply the changes and repeat step 1. Check file permissions and owner. Hint: use whoami: you will find error as did 1331 is not a predefined userid but that’s ok

```bash
$ make sec1-container-shell
--- kubectl exec --stdin --tty security -c sec1 -- /bin/bash
I have no name!@security:/$ id -a
uid=1331 gid=0(root) groups=0(root)
I have no name!@security:/$ whoami
whoami: cannot find name for user ID 1331
I have no name!@security:/$ ls -al /tmp/share
total 8
drwxrwxrwx 2 root root 4096 Nov 19 13:13 .
drwxrwxrwt 1 root root 4096 Nov 19 13:13 ..
I have no name!@security:/$ echo "From sec1" > /tmp/share/testfile.txt
I have no name!@security:/$ cat /tmp/share/testfile.txt
From sec1
I have no name!@security:/$ ls -al /tmp/share/testfile.txt
-rw-r--r-- 1 1331 root 10 Nov 19 13:21 /tmp/share/testfile.txt
I have no name!@security:/$
I have no name!@security:/$ exit
exit
Connection to 13.211.134.126 closed.
jso@ubunu2004:~/myob-work/work/aws-cf/git-repo/project-resources/project/anz-code-challenge-2$ make sec2-container-shell
--- kubectl exec --stdin --tty security -c sec2 -- /bin/bash
I have no name!@security:/$ id -a
uid=1331 gid=0(root) groups=0(root)
I have no name!@security:/$ whoami
whoami: cannot find name for user ID 1331
I have no name!@security:/$ ls -al /tmp/share/testfile.txt
-rw-r--r-- 1 1331 root 10 Nov 19 13:21 /tmp/share/testfile.txt
I have no name!@security:/$ cat /tmp/share/testfile.txt
From sec1
I have no name!@security:/$
I have no name!@security:/$ exit
exit
Connection to 13.211.134.126 closed.

```

### Create a Security Context for container sec1 to run programs as root. Hence files should be created as root too.

```bash

$ make get-pods
--- kubectl get pods -o wide
NAME       READY   STATUS    RESTARTS   AGE   IP            NODE                                            NOMINATED NODE   READINESS GATES
security   2/2     Running   0          11m   10.244.1.10   ip-10-43-0-30.ap-southeast-2.compute.internal   <none>           <none>
jso@ubunu2004:~/myob-work/work/aws-cf/git-repo/project-resources/project/anz-code-challenge-2$ make delete-pod-security-context
--- kubectl delete
pod "security" deleted
jso@ubunu2004:~/myob-work/work/aws-cf/git-repo/project-resources/project/anz-code-challenge-2$ make get-pods
--- kubectl get pods -o wide
No resources found in default namespace.
jso@ubunu2004:~/myob-work/work/aws-cf/git-repo/project-resources/project/anz-code-challenge-2$ make apply-container-security-context
--- SCP file into master node and kubectl apply
container-security-context.yaml                                                                                                     100%  566    20.6KB/s   00:00
pod/security created
jso@ubunu2004:~/myob-work/work/aws-cf/git-repo/project-resources/project/anz-code-challenge-2$ make get-pods
--- kubectl get pods -o wide
NAME       READY   STATUS              RESTARTS   AGE   IP       NODE                                            NOMINATED NODE   READINESS GATES
security   0/2     ContainerCreating   0          5s    <none>   ip-10-43-0-30.ap-southeast-2.compute.internal   <none>           <none>
```

#### Repeat step 1. Check file permissions and owner. Try do delete the file container sec1 created from container sec2. Does it work?

```diff
Does it work?
-Yes, it does
```

```bash
$ make sec1-container-shell
--- kubectl exec --stdin --tty security -c sec1 -- /bin/bash
root@security:/# id -a
uid=0(root) gid=0(root) groups=0(root)
root@security:/# ls -al /tmp/share
total 8
drwxrwxrwx 2 root root 4096 Nov 19 13:27 .
drwxrwxrwt 1 root root 4096 Nov 19 13:27 ..
root@security:/# echo "Creating from sec1" > /tmp/share/testfile.txt
root@security:/# ls -al /tmp/share/testfile.txt
-rw-r--r-- 1 root root 19 Nov 19 13:29 /tmp/share/testfile.txt
root@security:/# cat /tmp/share/testfile.txt
Creating from sec1
root@security:/# exit
exit
Connection to 13.211.134.126 closed.
jso@ubunu2004:~/myob-work/work/aws-cf/git-repo/project-resources/project/anz-code-challenge-2$ make sec2-container-shell
--- kubectl exec --stdin --tty security -c sec2 -- /bin/bash
I have no name!@security:/$ id
uid=1331 gid=0(root) groups=0(root)
I have no name!@security:/$ id -a
uid=1331 gid=0(root) groups=0(root)
I have no name!@security:/$ ls -al /tmp/share/testfile.txt
-rw-r--r-- 1 root root 19 Nov 19 13:29 /tmp/share/testfile.txt
I have no name!@security:/$ cat /tmp/share/testfile.txt
Creating from sec1
I have no name!@security:/$ rm -i /tmp/share/testfile.txt
rm: remove write-protected regular file '/tmp/share/testfile.txt'? y
I have no name!@security:/$ ls -al /tmp/share
total 8
drwxrwxrwx 2 root root 4096 Nov 19 13:30 .
drwxrwxrwt 1 root root 4096 Nov 19 13:27 ..
I have no name!@security:/$ exit
exit
Connection to 13.211.134.126 closed.

```

#### Clean up

```bash
$ make delete-container-security-context
--- kubectl delete
pod "security" deleted
jso@ubunu2004:~/myob-work/work/aws-cf/git-repo/project-resources/project/anz-code-challenge-2$ make get-pods
--- kubectl get pods -o wide
No resources found in default namespace.

```
