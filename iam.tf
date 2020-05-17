resource "aws_iam_user" "deploy-user" {
  name = "deploy-user"
}

resource "aws_iam_policy" "deploy" {
  name        = "deploy"
  path        = "/"
  description = "deploy policy"
  policy      = file("policies/iam/ecr_policy.json")
}

resource "aws_iam_user_policy_attachment" "deploy_attach" {
  user       = aws_iam_user.deploy-user.name
  policy_arn = aws_iam_policy.deploy.arn
}

resource "aws_iam_role" "ecs_instance_role" {
  name               = "ecs_instance_role"
  path               = "/"
  assume_role_policy = file("policies/iam/ec2_assume_role_policy.json")
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecs-instance-profile"
  role = aws_iam_role.ecs_instance_role.name
}
