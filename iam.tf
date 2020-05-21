# ECR deployer Role
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

# EC2 instance Role
resource "aws_iam_role" "ecs_instance_role" {
  name               = "ecs_instance_role"
  path               = "/"
  assume_role_policy = file("policies/iam/ec2_assume_role_policy.json")
}

resource "aws_iam_instance_profile" "ecs_profile" {
  name = "ecs-profile"
  role = aws_iam_role.ecs_instance_role.name
}

resource "aws_iam_policy" "ecs_instance_policy" {
  name        = "ecs-instance-policy"
  path        = "/"
  description = ""
  policy      = file("policies/iam/ecs_instance_policy.json")
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_attach" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = aws_iam_policy.ecs_instance_policy.arn
}

# ECS task Role
resource "aws_iam_role" "ecs_task_role" {
  name               = "ecs-task-role"
  path               = "/"
  assume_role_policy = file("policies/iam/ecs_task_assume_role_policy.json")
}

resource "aws_iam_policy" "ecs_task_policy" {
  name        = "ecs-task-policy"
  path        = "/"
  description = ""
  policy      = file("policies/iam/ecs_task_policy.json")
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_attach" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecs_task_policy.arn
}
