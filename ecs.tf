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

  container_definitions = <<EOF
[
  {
    "name": "app",
    "image": "${aws_ecr_repository.app.repository_url}:latest",
    "cpu": 300,
    "memoryReservation": 300,
    "essential": true,
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": 9000,
        "hostPort": 9000
      }
    ],
    "environment": [
      {
        "name": "APP_ENV",
        "value": "production"
      },
      {
        "name": "APP_DEBUG",
        "value": "true"
      },
      {
        "name": "APP_NAME",
        "value": "${var.project}"
      },
      {
        "name": "APP_URL",
        "value": "https://laravel-tweet-ddd.work"
      },
      {
        "name": "ASSET_URL",
        "value": "https://cdn.laravel-tweet-ddd.work"
      },
      {
        "name": "DB_CONNECTION",
        "value": "mysql"
      },
      {
        "name": "DB_HOST",
        "value": "${aws_db_instance.db.address}"
      },
      {
        "name": "DB_PORT",
        "value": "3306"
      },
      {
        "name": "DB_USERNAME",
        "value": "${replace(var.project, "-", "_")}"
      },
      {
        "name": "DB_DATABASE",
        "value": "${replace(var.project, "-", "_")}"
      },
      {
        "name": "REDIS_HOST",
        "value": "${aws_elasticache_cluster.main.cache_nodes.0.address}"
      },
      {
        "name": "REDIS_PASSWORD",
        "value": "null"
      },
      {
        "name": "REDIS_PORT",
        "value": "6379"
      },
      {
        "name": "QUEUE_CONNECTION",
        "value": "redis"
      },
      {
        "name": "CACHE_DRIVER",
        "value": "redis"
      },
      {
        "name": "TELESCOPE_ENABLED",
        "value": "false"
      }
    ],
    "secrets": [
      {
        "name": "APP_KEY",
        "valueFrom": "/app/key"
      },
      {
        "name": "DB_PASSWORD",
        "valueFrom": "/db/password"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${var.project}-app",
        "awslogs-region": "ap-northeast-1",
        "awslogs-stream-prefix": "service"
      }
    }
  },
  {
    "name": "nginx",
    "image": "${aws_ecr_repository.nginx.repository_url}:latest",
    "cpu": 50,
    "memoryReservation": 100,
    "essential": true,
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${var.project}-nginx",
        "awslogs-region": "ap-northeast-1",
        "awslogs-stream-prefix": "service"
      }
    }
  }
]
EOF
}
