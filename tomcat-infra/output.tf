output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  value = module.subnets.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.subnets.private_subnet_ids
}

output "public_route_table_id" {
  value = module.route_tables.public_route_table_id
}

output "private_route_table_id" {
  value = module.route_tables.private_route_table_id
}

output "security_group_id" {
  value = module.security_group.security_group_id
}

output "public_instance_id" {
  value = module.instance.public_instance_id
}

output "auto_scaling_group_id" {
  value = module.auto_scaling.auto_scaling_group_id
}

output "load_balancer_id" {
  value = module.alb.load_balancer_id
}

output "target_group_arn" {
  value = module.alb.target_group_arn
}

output "listener_arn" {
  value = module.alb.listener_arn
}

output "bucket_id" {
  value = module.s3.bucket_id
}

output "bucket_versioning_status" {
  value = module.s3.bucket_versioning_status
}
