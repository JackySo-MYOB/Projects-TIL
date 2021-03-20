# Automate diagrams-as-code with AWS CodePipeline

Inspiring by [Pushbutton AWS Diagrams](https://stelligent.com/2020/06/15/continuous-diagrams-as-code-for-aws/) and IaC in [github repo](https://github.com/PaulDuvall/diagrams-as-code)

### Operation menu

```bash
$ make

 Choose a command run:

blog-howto                               Howto - Pushbutton AWS Diagrams
readme                                   Readme - $(github-repo)
0-put-secret                             Add github token into Secret Manager
0-put-ssm-parameter                      Add github token into SSM parameter
0-update-ssm-parameter                   Update github token into SSM parameter when it exists
utl-view-ssm-parameter                   View github token in SSM parameter
utl-list-bucket                          List bucket - $(S3BUCKET)
0-remove-bucket                          Remove bucket and recreate again - $(S3BUCKET)
1-fetch-diagram-code                     Fetch github repo to deploy CFN stack - $(diagram-github-repo)
1-create-bucket                          Create bucket - $(S3BUCKET)
2-delete-cfn                             Delete bucket - $(S3BUCKET) and then delete CFN stack - $(CFNSTACK)
3-create-cfn                             Create CFN stack - $(CFNSTACK)
utl-view-stack-output                    View CodePipeline CFN stack outputs
utl-view-pipeline-status                 View CodePipeline status
utl-view-pipeline-execution              View CodePipeline execution

clean                                    Clean up temporary stuff
```

### Workflow - Create AWS resources and Codepipeline to publish python diagram-as-code diagram

#### Setup resources for CodePipeline CFN stack

```bash

$ make 0-put-ssm-parameter
{
    "Version": 1,
    "Tier": "Standard"
}

$ make view-ssm-parameter
<token code>

$ make 1-fetch-diagram-code
Cloning into 'tmp-gitrepo'...
remote: Enumerating objects: 38, done.
remote: Counting objects: 100% (38/38), done.
remote: Compressing objects: 100% (30/30), done.
remote: Total 38 (delta 14), reused 31 (delta 7), pack-reused 0
Receiving objects: 100% (38/38), 14.27 KiB | 1.58 MiB/s, done.
Resolving deltas: 100% (14/14), done.

$ make 1-create-bucket
make_bucket: diagrams-jso-037675027950

$ make list-bucket
diagrams-jso-037675027950

```

#### Create for CodePipeline CFN stack

```bash
$ make 3-create-cfn
{
    "StackId": "arn:aws:cloudformation:ap-southeast-2:037675027950:stack/diagrams-jso/ead8b420-7d9d-11eb-b8f5-0a5d7a4da53a"
}


```

#### Check results

```bash

$ make list-bucket
diagrams-jso-037675027950
diagrams-jso-pipelinebucket-7hv8hbkytwb2
diagrams-jso-sitebucket-lnmad8ihfkzt

$ make view-stack-output
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|                                                                            DescribeStacks                                                                             |
+------------------------------------+--------------+-------------------------------------------------------------------------------------------------------------------+
|             Description            |  OutputKey   |                                                    OutputValue                                                    |
+------------------------------------+--------------+-------------------------------------------------------------------------------------------------------------------+
|  Diagram for clustered web services|  ClusterUrl  |  https://diagrams-jso-sitebucket-lnmad8ihfkzt.s3.amazonaws.com/clustered_web_services.png                         |
|  CodePipeline URL                  |  PipelineUrl |  https://console.aws.amazon.com/codepipeline/home?region=ap-southeast-2#/view/diagrams-jso-Pipeline-UR4B3F5GWEF   |
|  Diagram for Serverless Web Apps   |  LambdaUrl   |  https://diagrams-jso-sitebucket-lnmad8ihfkzt.s3.amazonaws.com/serverless_web_apps.png                            |
+------------------------------------+--------------+-------------------------------------------------------------------------------------------------------------------+

```

### Modify IaC and update your Codepipeline

#### Fetch code from github repo

```bash

$ make 1-fetch-diagram-code
Cloning into 'tmp-gitrepo'...
remote: Enumerating objects: 38, done.
remote: Counting objects: 100% (38/38), done.
remote: Compressing objects: 100% (30/30), done.
remote: Total 38 (delta 14), reused 31 (delta 7), pack-reused 0
Receiving objects: 100% (38/38), 14.27 KiB | 1.58 MiB/s, done.
Resolving deltas: 100% (14/14), done.
```

#### Modify IaC and push into github master branch

```diff

$ tree tmp-gitrepo/
tmp-gitrepo/
+├── buildspec.yml
 ├── examples
+│   ├── cluster.py
+│   └── lambda.py
 ├── LICENSE
+├── pipeline.yml
 └── README.md

```

File | IaC
------------- | --------------
buildspec.yml | CodeBuild sequences
pipeline.yml | CodePipeline CFN template
examples/.py | Diagram-as-code python scripts

```bash

cd tmp-gitrepo
git add .
git commit -m '<Comment>'
git push -u origin master
```

#### View CodePipeline results

```bash

$ make utl-view-pipeline-status
------------------------------------------------------------
|                  DescribeStackResources                  |
+--------------------------------------+-------------------+
|  diagrams-jso-Pipeline-1C76XP2IJNVBO |  CREATE_COMPLETE  |
+--------------------------------------+-------------------+
pipeline:
  name: diagrams-jso-Pipeline-1C76XP2IJNVBO
  roleArn: arn:aws:iam::037675027950:role/diagrams-jso-CodePipelineRole-170MZW117VM64
  artifactStore:
    type: S3
    location: diagrams-jso-pipelinebucket-dzj9bvd54ls9
  stages:
    - name: Source
      actions:
        - name: Source
          actionTypeId:
            category: Source
            owner: ThirdParty
            provider: GitHub
            version: "1"
          runOrder: 1
          configuration:
            Branch: master
            OAuthToken: '****'
            Owner: JackySo-MYOB
            Repo: diagrams-as-code
          outputArtifacts:
            - name: SourceArtifacts
          inputArtifacts: []
    - name: Build
      actions:
        - name: GenerateDiagrams
          actionTypeId:
            category: Test
            owner: AWS
            provider: CodeBuild
            version: "1"
          runOrder: 1
          configuration:
            ProjectName: diagrams-jso
          outputArtifacts: []
          inputArtifacts:
            - name: SourceArtifacts
  version: 1
metadata:
  pipelineArn: arn:aws:codepipeline:ap-southeast-2:037675027950:diagrams-jso-Pipeline-1C76XP2IJNVBO
  created: 1614943577.479
  updated: 1614943577.479
pipelineName: diagrams-jso-Pipeline-1C76XP2IJNVBO
pipelineVersion: 1
stageStates:
  - stageName: Source
    inboundTransitionState:
      enabled: true
    actionStates:
      - actionName: Source
        currentRevision:
          revisionId: 636869025940cb685063094e9a923a647fc9a9d0
        latestExecution:
          status: Succeeded
          summary: example diagram python script
          lastStatusChange: 1614943588.965
          externalExecutionId: 636869025940cb685063094e9a923a647fc9a9d0
        entityUrl: https://github.com/JackySo-MYOB/diagrams-as-code/tree/master
        revisionUrl: https://github.com/JackySo-MYOB/diagrams-as-code/commit/636869025940cb685063094e9a923a647fc9a9d0
    latestExecution:
      pipelineExecutionId: afacf0fc-487f-468c-bc3b-6a47833b19f0
      status: Succeeded
  - stageName: Build
    inboundTransitionState:
      enabled: true
    actionStates:
      - actionName: GenerateDiagrams
        latestExecution:
          status: Succeeded
          lastStatusChange: 1614943867.915
          externalExecutionId: diagrams-jso:76594f9e-7017-478d-a7c7-c896edb3892b
          externalExecutionUrl: https://console.aws.amazon.com/codebuild/home?region=ap-southeast-2#/builds/diagrams-jso:76594f9e-7017-478d-a7c7-c896edb3892b/view/new
        entityUrl: https://console.aws.amazon.com/codebuild/home?region=ap-southeast-2#/projects/diagrams-jso/view
    latestExecution:
      pipelineExecutionId: afacf0fc-487f-468c-bc3b-6a47833b19f0
      status: Succeeded
created: 1614943577.479
updated: 1614943577.479

$ make utl-view-pipeline-execution
actionExecutionDetails:
  - pipelineExecutionId: afacf0fc-487f-468c-bc3b-6a47833b19f0
    actionExecutionId: 240daf24-b7f8-4bbc-9b95-2d8032f64505
    pipelineVersion: 1
    stageName: Build
    actionName: GenerateDiagrams
    startTime: 1614943589.499
    lastUpdateTime: 1614943867.969
    status: Succeeded
    input:
      actionTypeId:
        category: Test
        owner: AWS
        provider: CodeBuild
        version: "1"
      configuration:
        ProjectName: diagrams-jso
      resolvedConfiguration:
        ProjectName: diagrams-jso
      region: ap-southeast-2
      inputArtifacts:
        - name: SourceArtifacts
          s3location:
            bucket: diagrams-jso-pipelinebucket-dzj9bvd54ls9
            key: diagrams-jso-Pipelin/SourceArti/Mzdayu9.zip
    output:
      outputArtifacts: []
      executionResult:
        externalExecutionId: diagrams-jso:76594f9e-7017-478d-a7c7-c896edb3892b
        externalExecutionUrl: https://console.aws.amazon.com/codebuild/home?region=ap-southeast-2#/builds/diagrams-jso:76594f9e-7017-478d-a7c7-c896edb3892b/view/new
      outputVariables: {}
  - pipelineExecutionId: afacf0fc-487f-468c-bc3b-6a47833b19f0
    actionExecutionId: c8b31a83-04f6-490f-9f6c-dabc6a2ff7ca
    pipelineVersion: 1
    stageName: Source
    actionName: Source
    startTime: 1614943583.957
    lastUpdateTime: 1614943589.022
    status: Succeeded
    input:
      actionTypeId:
        category: Source
        owner: ThirdParty
        provider: GitHub
        version: "1"
      configuration:
        Branch: master
        OAuthToken: '****'
        Owner: JackySo-MYOB
        Repo: diagrams-as-code
      resolvedConfiguration:
        Branch: master
        OAuthToken: '****'
        Owner: JackySo-MYOB
        Repo: diagrams-as-code
      region: ap-southeast-2
      inputArtifacts: []
    output:
      outputArtifacts:
        - name: SourceArtifacts
          s3location:
            bucket: diagrams-jso-pipelinebucket-dzj9bvd54ls9
            key: diagrams-jso-Pipelin/SourceArti/Mzdayu9.zip
      executionResult:
        externalExecutionId: 636869025940cb685063094e9a923a647fc9a9d0
        externalExecutionSummary: example diagram python script
        externalExecutionUrl: https://github.com/JackySo-MYOB/diagrams-as-code/commit/636869025940cb685063094e9a923a647fc9a9d0
      outputVariables:
        AuthorDate: "2021-03-05T10:18:08Z"
        BranchName: master
        CommitId: 636869025940cb685063094e9a923a647fc9a9d0
        CommitMessage: example diagram python script
        CommitUrl: https://api.github.com/repos/JackySo-MYOB/diagrams-as-code/git/commits/636869025940cb685063094e9a923a647fc9a9d0
        CommitterDate: "2021-03-05T10:18:08Z"
        RepositoryName: diagrams-as-code
pipelineExecutionSummaries:
  - pipelineExecutionId: afacf0fc-487f-468c-bc3b-6a47833b19f0
    status: Succeeded
    startTime: 1614943583.536
    lastUpdateTime: 1614943868.186
    sourceRevisions:
      - actionName: Source
        revisionId: 636869025940cb685063094e9a923a647fc9a9d0
        revisionSummary: example diagram python script
        revisionUrl: https://github.com/JackySo-MYOB/diagrams-as-code/commit/636869025940cb685063094e9a923a647fc9a9d0
    trigger:
      triggerType: PollForSourceChanges
      triggerDetail: Source

```


### Clean up sequences

#### Remove S3 buckets and CFN stack

```bash

$ make 2-delete-cfn
Deleting... S3 bucket diagrams-jso
remove_bucket: diagrams-jso-037675027950
delete: s3://diagrams-jso-pipelinebucket-7hv8hbkytwb2/diagrams-jso-Pipelin/SourceArti/PqDm7aD.zip
remove_bucket: diagrams-jso-pipelinebucket-7hv8hbkytwb2
delete: s3://diagrams-jso-sitebucket-lnmad8ihfkzt/serverless_web_apps.png
delete: s3://diagrams-jso-sitebucket-lnmad8ihfkzt/clustered_web_services.png
remove_bucket: diagrams-jso-sitebucket-lnmad8ihfkzt
Deleting... CFN stack diagrams-jso
CFN stack diagrams-jso are successfully deleted
```

#### Remove temporary folder of fetched repo

```bash
$ make clean

```


Here are some other resources:
* https://diagrams.mingrammer.com/docs/getting-started/installation
* https://diagrams.mingrammer.com/docs/nodes/aws
* https://graphviz.org/doc/info/attrs.html


