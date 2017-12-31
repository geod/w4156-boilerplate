# w4156-boiler-plate

https://github.com/cnadiminti/docker-dynamodb-local

https://github.com/awslabs/ecs-refarch-continuous-deployment

PREREQUISITES
python 3.6
Proto io
AWS CLI
Docker
PyCharm
    - an associated setup
Github account
    - create an access key and store it somewhere safe
    - clone the lecture code
    - one of you clone the boiler plate
Spotify
Waffle


1.
aws configure

2.
aws iam create-group --group-name Admins

aws iam create-user --user-name teammember1
aws iam create-user --user-name teammember2
aws iam create-user --user-name teammember3
aws iam create-user --user-name teammember4

aws iam attach-group-policy --group-name Admins --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

aws iam add-user-to-group --user-name teammember1 --group-name Admins
aws iam add-user-to-group --user-name teammember2 --group-name Admins
aws iam add-user-to-group --user-name teammember3 --group-name Admins
aws iam add-user-to-group --user-name teammember4 --group-name Admins

# CUSTOMIZE THE PASSWORD THEN IMMEDIATELY RESET
aws iam create-login-profile --user-name teammember1 --password <<a password>> --password-reset-required
aws iam create-login-profile --user-name teammember2 --password <<a password>> --password-reset-required
aws iam create-login-profile --user-name teammember3 --password <<a password>> --password-reset-required
aws iam create-login-profile --user-name teammember4 --password <<a password>> --password-reset-required

aws iam create-account-alias --account-alias w4156pride

https://<<<<WHATEVER YOUR ACCOUNT ALIAS WAS>>>>.signin.aws.amazon.com/console/


aws cloudformation validate-template --template-body file://s3.yaml

aws cloudformation create-stack --stack-name w4156-cd-pipeline --template-body file://templates/ecs-cicd-refarch.yaml --parameters ParameterKey=GitHubUser,ParameterValue=geod ParameterKey=GitHubRepo,ParameterValue=w4156-boilerplate ParameterKey=GitHubBranch,ParameterValue=master ParameterKey=GitHubToken,ParameterValue=<<Github token>> --capabilities CAPABILITY_IAM


###
aws s3api create-bucket --bucket w4156-cf-bucket --region us-east-1 --acl public-read
aws s3 cp templates/ s3://w4156-cf-bucket/ --recursive --include "*.yaml"


#######
TODO
1. Need to change the container

2. Pipeline itself should be a file (is this much different than CF?)
https://docs.aws.amazon.com/codepipeline/latest/userguide/pipelines-create.html

Or just pull out the buildspec
https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-cd-pipeline.html


