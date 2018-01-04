# w4156-boiler-plate

## Overview
Boiler-plate starting project for W4156. Teams can optionally use this project to get started and add to it in parallel
to lectures. The project contains

1. Python flask server
2. Docker support to run locally
3. Support to run dynamodb locally (in a docker)

## Acknowledgements

The AWS continuous delivery pipeline is based on the [reference architecture](https://github.com/awslabs/ecs-refarch-continuous-deployment)

## Local Installation Dependencies

1. [Git CLI](https://git-scm.com/downloads)
2. [python 3.6](https://www.python.org/downloads/release/python-364/)
3. [AWS CLI](https://aws.amazon.com/cli/) (pip install awscli)
4. [Docker](https://docs.docker.com/engine/installation/)
5. [PyCharm](https://www.jetbrains.com/shop/eform/students) NOTE - make sure to get the professional using edu email
6. Proto.io (instructions given on piazza)
7. [Spotify](https://www.spotify.com/us/) Optional!

# Local Deployment Instructions

A set of convenience scripts have been provided to start and stop

1. Pull the local docker dynamo image
```
./bin/docker_dynamo.sh pull
```

# AWS Deployment Instructions

Follow the below to configure deploying on AWS

## Inital Setup

1. Configure your aws CLI
```
aws configure
```

2. Create an access
```
aws iam create-group --group-name Admins
aws iam create-user --user-name teammember1
aws iam create-user --user-name teammember2
aws iam create-user --user-name teammember3
aws iam create-user --user-name teammember4
```

3. Create a policy called Admin and grant it administrator rights
```
aws iam attach-group-policy --group-name Admins --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
```

4. Give admin priviledges to each of your team members
```
aws iam add-user-to-group --user-name teammember1 --group-name Admins
aws iam add-user-to-group --user-name teammember2 --group-name Admins
aws iam add-user-to-group --user-name teammember3 --group-name Admins
aws iam add-user-to-group --user-name teammember4 --group-name Admins
```

4. Create a new password initial password for each team member
```
aws iam create-login-profile --user-name teammember1 --password <<a password>> --password-reset-required
aws iam create-login-profile --user-name teammember2 --password <<a password>> --password-reset-required
aws iam create-login-profile --user-name teammember3 --password <<a password>> --password-reset-required
aws iam create-login-profile --user-name teammember4 --password <<a password>> --password-reset-required
```

5. Create an alias for your account (this allows a logical/vanity name on various URLS)
```
aws iam create-account-alias --account-alias <<TEAM NAME>>
```

6. Each team member must now log in and change their password
```
https://<<TEAM NAME>>>.signin.aws.amazon.com/console/
```

7. Log into Github and create a github access key https://github.com/settings/tokens

8. One member of the team must now execute
```
aws cloudformation create-stack --stack-name w4156-cd-pipeline --template-body file://templates/ecs-cicd-refarch.yaml --parameters ParameterKey=GitHubUser,ParameterValue=<<GITHUB USERNAME>> ParameterKey=GitHubRepo,ParameterValue=<<YOUR GITHUB PROJECT>> ParameterKey=GitHubBranch,ParameterValue=master ParameterKey=GitHubToken,ParameterValue=<<GITHUB ACCESS KEY>> --capabilities CAPABILITY_IAM
```

### Customizing Cloud Formation
If there is a need to customize the cloud formation documents then you will need to create your own AWS S3 bucket
```
aws s3api create-bucket --bucket w4156-cf-bucket --region us-east-1 --acl public-read
aws s3 cp templates/ s3://w4156-cf-bucket/ --recursive --include "*.yaml"
```

# Commit

Following the AWS setup instructions any commit to github will trigger the CD pipeline
