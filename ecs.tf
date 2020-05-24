resource "aws_ecs_cluster" "main" {
  name = "${var.project}-cluster"
}

resource "aws_ecs_service" "app_service" {
  name            = "${var.project}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "EC2"

  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100

  network_configuration {
    security_groups = [aws_security_group.web.id]
    subnets         = [aws_subnet.public_subnet_1a.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.web.arn
    container_name   = "nginx"
    container_port   = 80
  }
}

resource "aws_ecs_task_definition" "app" {
  family             = "${var.project}-app"
  task_role_arn      = aws_iam_role.ecs_task_role.arn
  execution_role_arn = aws_iam_role.ecs_task_role.arn
  network_mode       = "awsvpc"

  container_definitions = data.template_file.ecs_app_task_definition.rendered
}

data "template_file" "ecs_app_task_definition" {
  template = file("./templates/ecsTaskDefinition/app_task_definition.json")

  vars = {
    app_repo_url              = aws_ecr_repository.app.repository_url
    network_mode              = "awsvpc",
    command                   = "",
    db_host                   = aws_db_instance.db.address
    db_user_database          = replace(var.project, "-", "_")
    app-awslogs-stream-prefix = "app"
    project                   = var.project
    redis_host                = aws_elasticache_cluster.main.cache_nodes.0.address
    nginx_repo_url            = aws_ecr_repository.nginx.repository_url
  }
}

resource "aws_ecs_task_definition" "migrate" {
  family             = "${var.project}-migrate"
  task_role_arn      = aws_iam_role.ecs_task_role.arn
  execution_role_arn = aws_iam_role.ecs_task_role.arn

  container_definitions = data.template_file.ecs_migrate_task_definition.rendered
}

data "template_file" "ecs_migrate_task_definition" {
  template = file("./templates/ecsTaskDefinition/app_task_definition.json")

  vars = {
    app_repo_url              = aws_ecr_repository.app.repository_url
    network_mode              = "bridge",
    command                   = "migrate"
    db_host                   = aws_db_instance.db.address
    db_user_database          = replace(var.project, "-", "_")
    app-awslogs-stream-prefix = "migration"
    project                   = var.project
    redis_host                = aws_elasticache_cluster.main.cache_nodes.0.address
    nginx_repo_url            = ""
  }
}
