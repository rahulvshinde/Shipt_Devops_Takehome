resource "aws_launch_configuration" "instance-launchconfig" {
  name_prefix = "instance-launchconfig"
  image_id = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.mykeypair.key_name
  security_groups = [aws_security_group.autoscale-securitygroup.id]
}

resource "aws_autoscaling_group" "instance-autoscaling" {
  name = "instance-autoscaling"
  vpc_zone_identifier = [aws_subnet.main-private-1.id, aws_subnet.main-private-2.id]
  launch_configuration = aws_launch_configuration.instance-launchconfig.name
  min_size = 2
  max_size = 2
  health_check_grace_period = 300
  health_check_type = "ELB"
  load_balancers = [aws_elb.myelb.name]
  force_delete = true
  tag {
    key = "Name"
    value = "ec2 instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "instance-cpu-policy-scaleup" {
  name = "instance-cpu-policy-scaleup"
  autoscaling_group_name = aws_autoscaling_group.instance-autoscaling.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = "1"
  cooldown = "300"
  policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "instance-cpu-alarm-scaleup" {
    alarm_name = "instance-cpu-alarm-scaleup"
    alarm_description = "instance-cpu-alarm-scaleup"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPU-Unitilization"
    namespace = "AWS/EC2"
    period = "120"
    statistic = "Average"
    threshold = "30"
    dimensions = {
      "AutoScalingGroupName" = aws_autoscaling_group.instance-autoscaling.name
    }
    actions_enabled = true
    alarm_actions = [aws_autoscaling_policy.instance-cpu-policy-scaleup.arn]
}

resource "aws_autoscaling_policy" "instance-cpu-policy-scaledown" {
  name = "instance-cpu-policy-scaledown"
  autoscaling_group_name = aws_autoscaling_group.instance-autoscaling.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = "-1"
  cooldown = "300"
  policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "instance-cpu-alarm-scaledown" {
    alarm_name = "instance-cpu-alarm-scaledown"
    alarm_description = "instance-cpu-alarm-scaledown"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPU-Unitilization"
    namespace = "AWS/EC2"
    period = "120"
    statistic = "Average"
    threshold = "5"
    dimensions = {
      "AutoScalingGroupName" = aws_autoscaling_group.instance-autoscaling.name
    }
    actions_enabled = true
    alarm_actions = [aws_autoscaling_policy.instance-cpu-policy-scaledown.arn]
}
