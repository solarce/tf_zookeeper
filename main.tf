//
// Template: tf_zookeeper
//

// This Terraform moule can be used to build a zookeeper cluster

// Modules we pull in for resources

// The security group containing rules for our web servers
// Uses the following inputs from terraform.tfvars
// - aws_*
// - vpc_id
// - source_cidr_block
module "sg_zookeeper" {
  source = "github.com/terraform-community-modules/tf_aws_sg//sg_zookeeper?ref=stable"
  security_group_name = "${var.security_group_name}-${var.mytag}"
  aws_access_key = "${var.aws_access_key}"
  aws_secret_key = "${var.aws_secret_key}"
  aws_region = "${var.aws_region}"
  vpc_id = "${var.vpc_id}"
  source_cidr_block = "${var.source_cidr_block}"
}


// The Auto-Scaling Group and Launch Config for
// the zookeeper hosts.
// Uses the following inputs from terraform.tfvars
// - aws_*
// - lc_name
// - ami_id
// - instance_type
// - iam_instance_profile
// - key_name (SSH key in EC2)
// - user_data (path to cloud config file)
// - asg_name
// - asg_number_of_instances
// - subnet_az1
// - subnet_az2
module "zookeeper_autoscaling_group" {
  source = "github.com/terraform-community-modules/tf_aws_asg?ref=stable"
  lc_name = "${var.lc_name}-${var.mytag}-lc"
  ami_id = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  iam_instance_profile = "${var.iam_instance_profile}"
  key_name = "${var.key_name}"
  security_group = "${module.sg_zookeeper.security_group_id}"
  user_data = "${var.user_data}"
  asg_name = "${var.asg_name}-${var.mytag}-asg"
  asg_number_of_instances = "${var.zk_number_of_instances}"
  asg_minimum_number_of_instances = "${var.minimum_number_of_instances}"
  subnet_az1 = "${var.subnet_az1}"
  subnet_az2 = "${var.subnet_az2}"
  aws_access_key = "${var.aws_access_key}"
  aws_secret_key = "${var.aws_secret_key}"
  aws_region = "${var.aws_region}"
}
