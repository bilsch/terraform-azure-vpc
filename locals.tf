locals {
  # TODO: ipv6 subnets are missing
  len_public_subnets     = max(length(var.public_subnets), )
  len_private_subnets    = max(length(var.private_subnets), )
  len_database_subnets   = max(length(var.database_subnets), )
  len_kubernetes_subnets = max(length(var.kubernetes_subnets), )

  max_subnet_length = max(
    local.len_private_subnets,
    local.len_public_subnets,
    local.len_database_subnets,
    local.len_kubernetes_subnets,
  )
}
