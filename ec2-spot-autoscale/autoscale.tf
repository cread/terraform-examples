resource "aws_autoscaling_policy" "scale-up" {
  name                   = "ec2-spot-autoscale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.scale.name
}

resource "aws_autoscaling_policy" "scale-down" {
  name                   = "ec2-spot-autoscale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.scale.name
}

resource "aws_autoscaling_group" "scale" {
  name                = "ec2-spot-autoscale"
  vpc_zone_identifier = data.aws_subnet_ids.default.ids

  max_size         = 5
  min_size         = 0
  default_cooldown = 60 # In real life you'll probably want this higher

  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = 0 # No On-Demand please
      on_demand_percentage_above_base_capacity = 0 # No On-Demand please
      spot_allocation_strategy                 = "lowest-price"
      spot_instance_pools                      = 2
      spot_max_price                           = "" # On-Demand price as our max
    }

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.scale.id
        version            = "$Latest"
      }

      override {
        instance_type = "t3.micro"
      }

      override {
        instance_type = "t3a.micro"
      }
    }
  }

  enabled_metrics = [
    "GroupDesiredCapacity",
    "GroupInServiceCapacity",
    "GroupPendingCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupStandbyCapacity",
    "GroupTerminatingCapacity",
    "GroupTerminatingInstances",
    "GroupTotalCapacity",
    "GroupTotalInstances",
  ]

  tags = [
    {
      key                 = "Name"
      value               = "ec2-spot-autoscale"
      propagate_at_launch = true
    }
  ]
}
