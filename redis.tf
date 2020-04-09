resource "aws_elasticache_parameter_group" "redis-cluster" {
  name   = "redis-cluster"
  family = "redis5.0"
}

resource "aws_elasticache_replication_group" "redis-replicas" {
  automatic_failover_enabled = true
  availability_zones = ["us-west-1a", "us-west-1c"]
  replication_group_id = "redis-replica-group"
  replication_group_description = "Redis Replica Group"
  node_type = "cache.t2.micro"
  number_cache_clusters = 2
  parameter_group_name = aws_elasticache_parameter_group.redis-cluster.name
  port = 6379
  subnet_group_name = "aws_subnet.main-private-2.name"
  # vpc_security_group_ids = [aws_security_group.redis-securitygroup.name]
  # aws_elasticache_parameter_group = aws_elasticache_parameter_group.default.name
}
