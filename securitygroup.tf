# resource "aws_security_group" "allow-ssh" {
#   vpc_id = aws_vpc.main.id
#   name = "allow-ssh"
#   description = "security group that allows ssh and all egress traffic"
#   tags = {
#     Name = "allow-ssh"
#   }
# }
# resource "aws_security_group_rule" "incoming" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.allow-ssh.id
# }
#
# resource "aws_security_group_rule" "outgoing" {
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.allow-ssh.id
# }

#Autoscaling
resource "aws_security_group" "autoscale-securitygroup" {
  vpc_id = aws_vpc.main.id
  name = "autoscale-securitygroup"
  description = "security group that allows ssh and all egress traffic"
  tags = {
    Name = "autoscale-securitygroup"
  }
}
resource "aws_security_group_rule" "autoscale-ingress-rule-1" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
    cidr_blocks = ["10.0.1.0/24"]
  security_group_id = aws_security_group.autoscale-securitygroup.id
}
resource "aws_security_group_rule" "autoscale-ingress-rule-2" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["10.0.2.0/24"]
  security_group_id = aws_security_group.autoscale-securitygroup.id
}

resource "aws_security_group_rule" "autoscale-egress-rule-1" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["10.0.1.0/24"]
  security_group_id = aws_security_group.autoscale-securitygroup.id

}
resource "aws_security_group_rule" "autoscale-egress-rule-2" {
  type = "egress"
  from_port = 6379
  to_port = 6379
  protocol = "-1"
  cidr_blocks = ["10.0.2.0/24"]
  security_group_id = aws_security_group.autoscale-securitygroup.id
}

#Elastic Load Balancer
resource "aws_security_group" "elb-securitygroup" {
  vpc_id = aws_vpc.main.id
  name = "elb"
  description = "security group for load balancer"
  tags = {
    Name = "elb"
  }
}
resource "aws_security_group_rule" "elb-egress-rule" {
  type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["10.0.1.0/24"]
    security_group_id = aws_security_group.elb-securitygroup.id

  }
  resource "aws_security_group_rule" "elb-ingress-rule" {
    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["10.0.1.0/24"]
    security_group_id = aws_security_group.elb-securitygroup.id
  }


#Redis
resource "aws_security_group" "redis-securitygroup" {
  vpc_id = aws_vpc.main.id
  name = "redis-cluster"
  description = "Secuirty group for Redis"
  tags = {
    Name = "redis-cluster"
  }
}
resource "aws_security_group_rule" "redis-egress-rule" {
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks = ["10.0.1.0/24"]
    security_group_id = aws_security_group.redis-securitygroup.id
  }
  resource "aws_security_group_rule" "redis-ingress-rule" {
    type = "ingress"
    from_port = 6379
    to_port = 6379
    protocol = "-1"
    cidr_blocks = ["10.0.1.0/24"]
    security_group_id = aws_security_group.redis-securitygroup.id
  }
