# terraform-azure-vpc

This is a vpc module modeled very heavily from the AWS [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc) module.

Note that I'm implementing things in stages. The first stage is the basic vpc layout and support for the various subnets and security groups/rules for each subnet. As I progress additional functionality will be added.

PRs welcome. Consider this module very TBD ;)

## TODO

Looking at the Azure provided vpc module [terraform-azurerm-avm-res-network-virtualnetwork](https://github.com/Azure/terraform-azurerm-avm-res-network-virtualnetwork/tree/main) there are some things this module could stand to implement:

1. vpc peering
1. ddos protection
1. probably others

# Things known not supported

1. ipv6
