provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "./modules/network"
  cidr_block = "10.0.0.0/16"
}

module "compute" {
  source = "./modules/compute"
  vpc_id = module.network.vpc_id
  subnet_ids = module.network.public_subnets
}

module "storage" {
  source = "./modules/storage"
}

module "security" {
  source = "./modules/security"
  vpc_id = module.network.vpc_id
}

module "observability" {
  source = "./modules/observability"
}