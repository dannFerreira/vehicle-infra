# Vehicle Infrastructure

Infrastructure as Code for the Vehicle API using Terraform and AWS.

This repository is responsible for defining and validating the AWS infrastructure used to host the Vehicle API.

## Technologies

- Terraform
- AWS EC2
- AWS Security Groups
- GitHub Actions

## Architecture

The infrastructure is intentionally simple and focused on the requirements of the project.

```text
Internet
   |
   v
AWS Security Group
   |
   v
AWS EC2
   |
   +--> Vehicle API
   |
   +--> PostgreSQL
```

The application and PostgreSQL run in Docker containers inside the EC2 instance.

Authentication is handled separately by Amazon Cognito in the `vehicle-auth` repository.

## Resources

This repository manages:

- EC2 instance
- Security Group
- Network access rules
- Infrastructure outputs

## AWS Region

```text
us-east-2
```

## EC2

The EC2 instance hosts the application environment.

Configuration:

```text
Instance type: t3.small
Operating system: Amazon Linux
Application port: 8080
SSH port: 22
```

## Security Group

The Security Group controls inbound access to the EC2 instance.

Current rules include:

```text
22   - SSH
80   - HTTP
8080 - Vehicle API
8081 - Legacy Keycloak port
```

Port `8081` is no longer required by the final architecture because authentication was migrated to Amazon Cognito. It remains represented in Terraform because the existing infrastructure was imported before cleanup.

## Terraform

### Prerequisites

- Terraform installed
- AWS credentials configured
- Access to the AWS account

### Initialize

```bash
terraform init
```

### Format

```bash
terraform fmt
```

### Validate

```bash
terraform validate
```

### Plan

```bash
terraform plan
```

### Apply

```bash
terraform apply
```

> Do not run `terraform apply` without reviewing the execution plan first.

## Existing Infrastructure Import

The EC2 instance and Security Group were initially created manually and later imported into Terraform state.

This allowed the infrastructure to be managed as code without recreating or interrupting the running environment.

Example:

```bash
terraform import aws_security_group.vehicle_api <SECURITY_GROUP_ID>

terraform import aws_instance.vehicle_api <INSTANCE_ID>
```

After the import, Terraform was validated with:

```bash
terraform plan
```

Expected result:

```text
No changes. Your infrastructure matches the configuration.
```

## CI

Infrastructure changes are validated automatically with GitHub Actions.

The CI pipeline runs:

```text
terraform init -backend=false
terraform fmt -check
terraform validate
```

The workflow is executed for feature branches and Pull Requests targeting `main`.

This ensures infrastructure changes are validated before merge.

## Repository Flow

```text
Feature Branch
      |
      v
Pull Request
      |
      v
Terraform CI
      |
      v
Merge to main
```

## Security

Terraform state files are not committed to the repository.

The following files are ignored:

```text
.terraform/
*.tfstate
*.tfstate.*
*.tfvars
crash.log
```

AWS credentials must never be committed to the repository.

## Related Repositories

### vehicle-api

Contains:

- Spring Boot API
- business rules
- Flyway migrations
- automated tests
- Docker configuration
- application CI/CD

### vehicle-auth

Contains:

- Amazon Cognito infrastructure
- Terraform configuration
- authentication and authorization resources

## Project

This repository is part of the Tech Challenge - PósTech SOAT - Fase 3.