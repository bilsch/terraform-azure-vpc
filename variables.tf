#
# variables
#

# name is used for all sorts of things.
variable "name" {
  type        = string
  description = "The name for this vpc will be creating within"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to all resources"
}

#
# VPC related variables
#
variable "cidr" {
  type        = string
  description = "cidr block for the vpc"
}

variable "dns_servers" {
  type        = list(string)
  description = "Name servers for the vpc"
}


#
# public_subnets variables
#
variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "create_public_subnets" {
  type        = bool
  description = "Whether to create public subnets or not"
  default     = true
}

variable "public_service_endpoints" {
  type        = list(string)
  description = "Endpoint services to enable for the public subnet"
  default = [
    "Microsoft.AzureActiveDirectory",
    "Microsoft.AzureCosmosDB",
    "Microsoft.ContainerRegistry",
    "Microsoft.EventHub",
    "Microsoft.KeyVault",
    "Microsoft.ServiceBus",
    "Microsoft.Sql",
    "Microsoft.Storage",
    "Microsoft.Storage.Global",
    "Microsoft.Web"
  ]
}

#
# private_subnets variables
#
variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "create_private_subnets" {
  type        = bool
  description = "Whether to create private subnets or not"
  default     = true
}

variable "private_service_endpoints" {
  type        = list(string)
  description = "Endpoint services to enable for the private subnet"
  default = [
    "Microsoft.AzureActiveDirectory",
    "Microsoft.AzureCosmosDB",
    "Microsoft.ContainerRegistry",
    "Microsoft.EventHub",
    "Microsoft.KeyVault",
    "Microsoft.ServiceBus",
    "Microsoft.Sql",
    "Microsoft.Storage",
    "Microsoft.Storage.Global",
    "Microsoft.Web"
  ]
}

#
# Database subnets
#
variable "database_subnets" {
  description = "A list of database subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "create_database_subnets" {
  type        = bool
  description = "Whether to create database subnets or not"
  default     = true
}

variable "database_service_endpoints" {
  type        = list(string)
  description = "Endpoint services to enable for the database subnet"
  default = [
    "Microsoft.AzureActiveDirectory",
    "Microsoft.AzureCosmosDB",
    "Microsoft.ContainerRegistry",
    "Microsoft.EventHub",
    "Microsoft.KeyVault",
    "Microsoft.ServiceBus",
    "Microsoft.Sql",
    "Microsoft.Storage",
    "Microsoft.Storage.Global",
    "Microsoft.Web"
  ]
}

#
# kubernetes subnets
#
variable "kubernetes_subnets" {
  description = "A list of kubernetes subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "create_kubernetes_subnets" {
  type        = bool
  description = "Whether to create kubernetes subnets or not"
  default     = true
}

variable "kubernetes_service_endpoints" {
  type        = list(string)
  description = "Endpoint services to enable for the kubernetes subnet"
  default = [
    "Microsoft.AzureActiveDirectory",
    "Microsoft.AzureCosmosDB",
    "Microsoft.ContainerRegistry",
    "Microsoft.EventHub",
    "Microsoft.KeyVault",
    "Microsoft.ServiceBus",
    "Microsoft.Sql",
    "Microsoft.Storage",
    "Microsoft.Storage.Global",
    "Microsoft.Web"
  ]
}
