# w4156-boiler-plate

## Overview
Boiler-plate starting project for W4156. Teams can optionally use this project to get started and add to it in parallel
to lectures. 

Project contains:
1. Python flask server
2. Docker support to run locally
3. Support to run dynamodb locally (in a docker)
4. Integration with AWS to run a docker continuous deployment pipeline

## Acknowledgements

The AWS continuous delivery pipeline is based on the [reference architecture](https://github.com/awslabs/ecs-refarch-continuous-deployment)

## Local Installation Dependencies

1. [Git CLI](https://git-scm.com/downloads)
2. [python 3.6](https://www.python.org/downloads/release/python-364/)
3. [AWS CLI](https://aws.amazon.com/cli/) (pip install awscli)
4. [Docker](https://docs.docker.com/engine/installation/)
5. [PyCharm](https://www.jetbrains.com/shop/eform/students) NOTE - make sure to get the professional using edu email
6. Proto.io (TODO instructions given on piazza)
7. [Slack](https://slack.com/) Set up a chat for the team to communicate
8. [VirtualEnv](https://virtualenv.pypa.io/en/stable/installation/)
9. [Postman](https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop?hl=en) Optional - is a tool to help test
10. [Spotify](https://www.spotify.com/us/) Optional!

## Github Instructions

1. If you do not have it already each member of the team needs to create a github account
2. If your team chooses to use the boilerplate python, flask, docker as a starting point then one member of the team should fork the [boilerplate (this project)](https://github.com/geod/w4156-boilerplate)
3. Add your team members [add collaborators](https://help.github.com/articles/inviting-collaborators-to-a-personal-repository/) to the project

# IDE Setup

TODO

# Local Deployment Instructions

You can of course develop directly out of the IDE. Once you are starting to prepare to deploy you should run in containers locally. 

A set of convenience scripts have been provided to start and stop

1. Pull the local docker dynamo image (this downloads dynamodb to be able to run locally)
```
./bin/docker_dynamo.sh pull
```

2. Start the dynamo instance
```
./bin/docker_dynamo.sh start
```

It should say something like below. Dynamo database is now running locally
```
Checking if container for dynamo is running .....
   Container was not running
Removing previous container for dynamo
ec8d64dd4897
Starting Container ....
810141dbec4fa37d4697aa4f8faaef6244d5e192267058949b90ab93822b65db
```

# AWS Deployment Instructions

Follow the below to configure deploying on AWS

## Inital Setup

0. Get an AWS education account (instructions on piazza)

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

7. Log into Github and create a github [access token](https://github.com/settings/tokens/new)
- Enable the 'repo' scope and the 4 settings within

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
