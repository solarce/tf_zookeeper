tf_zookeeper
============

A Terraform "service" template for a zookeeper cluster.

You can also refer to my [example of running `plan` on this template](https://gist.github.com/solarce/b77110786e5dbd5dc2b9)

Template Input Variables
------------------------

- `mytag` - Used for environment specific naming

Module Input Variables
----------------------
(Inputs for the modules we're using)

*aws provider*
- `aws_access_key`
- `aws_secret_key`
- `aws_region`

*tf_aws_sg/sg_zookeeper*
- `security_group_name`
- `vpc_id`
- `source_cidr_block`

*tf_aws_asg*
- `lc_name`
- `ami_id`
- `instance_type`
- `iam_instance_profile`
- `key_name`
- `user_data`
- `asg_name`
- `asg_number_of_instances`
- `asg_minimum_number_of_instances`
- `subnet_az1`
- `subnet_az2`

Usage
-----

To use this template, you need to do the following:

1.) Setting values for the following variables, either through
`terraform.tfvars` or `-var` arguments on the CLI

- //aws provider variables
- `aws_access_key`
- `aws_secret_key`
- `aws_region`

- //tf_zookeeper module
- `mytag`

- //Subnets
- `subnet_az1`
- `subnet_az2`

- //SG module`
- `vpc_id`
- `security_group_name`
- `source_cidr_block`

- //ASG module
- `ami_id`
- `zk_number_of_instances`
- `minimum_number_of_instances`
- `instance_type`
- `health_check_type`
- `iam_instance_profile`
- `asg_name`
- `lc_name`
- `key_name`
- `user_data`

2.) Assuming you've created a `terraform.tfvars` file, then you'll use
`terraform get` to pull in your module dependences and run a `terraform
plan` execution to see if your input variables will result in the AWS
resources you wanted.

```
terraform get -update
terraform plan -var-file terraform.tfvars -no-color -module-depth=-1
```

3.) Assuming the output of the plan looks good to you, you apply with
with

```
terraform apply
```

