resource "aws_ecs_cluster" "main" {
  name = "${var.project}-cluster"
}

resource "aws_ecs_service" "app_service" {
  name            = "${var.project}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "EC2"
}

resource "aws_ecs_task_definition" "app" {
  family                = "${var.project}-app"
  task_role_arn         = aws_iam_role.ecs_task_role.arn
  network_mode          = "bridge"

  container_definitions = <<EOF
[
  {
    "name": "app",
    "image": "${aws_ecr_repository.app.repository_url}:latest",
    "cpu": 333,
    "memoryReservation": 600,
    "essential": true,
    "networkMode": "bridge",
    "portMappings": [
      {
        "containerPort": 9000,
        "hostPort": 9000
      }
    ]
  }
]
EOF
}
