# AWS-Terraform-Infrastructure-
provisions a network infrastructure in AWS, including VPC, subnets, routing, security groups, and various resources for hosting web applications and databases.

# ![aws-terraform](https://github.com/Mazen-Alabasiry/AWS-Terraform-Infrastructure/blob/main/aws-terraform.png)
------------------------------------------------------------------------------------------------------------------------------
# What does the project do?

The project is organized into modules for readability and reusability and accomplishes the following tasks:

1. Configures the AWS provider for Terraform, specifying the AWS region (eu-west-1).

2. Configures backend.tf to store the state file remotely (you can ignore this step if you prefer to store the state file locally).

3. Creates an AWS VPC.

4. Establishes public and private subnets within the VPC, associating them with different availability zones to ensure high availability and fault tolerance. Routing is also set up.

5. Creates an Internet Gateway and associates it with the VPC for public internet access.

6. Configures route tables for both public and private subnets, ensuring that public subnets have a route to the Internet Gateway.

7. Sets up Elastic IPs and NAT Gateways for the private subnets to enable outbound internet access.

8. Defines security groups for EC2 instances and RDS (Relational Database Service) to control inbound and outbound traffic.

9. Launches EC2 instances in private subnets, ensuring they are not directly accessible from the internet.

10. Creates RDS instances (primary and standby) in different availability zones.

11. Sets up Application Load Balancers (ALBs) in each availability zone and configures listeners and target groups for routing traffic to EC2 instances.

12. Establishes an Auto Scaling Group for the private subnets with EC2 instances using a specified launch template.

# Prerequisites
 - configure AWS credentials using aws-cli.

Any additional tools or resources that need to be set up.
# Steps to reproduce

To apply the code, follow these steps:
1. configure your aws credentials using aws-cli
   ```
   $ aws configure
    AWS Access Key ID [None]: accesskey
    AWS Secret Access Key [None]: secretkey
    Default region name [None]: us-west-2
    Default output format [None]:
   ```
2. Configure backend.tf file to host statefile remotly (Optional)
3. Create your workspace for your environment (Optional)
   ```
    terraform workspace new WorkspaceName
   ```

4. Adjust the variables files (variables.tf , variables.tfvars , dev_vars.tfvars , production_vars.tfvars, ...)   
5. Run the following commands:

```
terraform init
terraform plan -var-file ./variables.tfvars
terraform apply -var-file ./variables.tfvars
```

------------------------------------------------------------------------------------------------------------------------------
# Tree structrue for the code :

- Netowrk
  - VPC
  - Public Subnets
  - Private Subnets
  - Internet Gateway (IGW)
  - Public Route Table (public_RT)
  - Route Table Association (PublicRTassociation)
  - Elastic IPs
  - NAT Gateways
  - Private Route Table (private_RT)
  - Route Table Association (PrivateRTassociation)
- Security Groups
  - EC2 Security Group (ec2_sg)
  - RDS Security Group (rds_sg)
- Launch Template (asg_template)
- EC2 Instances (ec2)
- RDS Database (Primary and Standby)
- Application Load Balancers (ALBs)
  - Target Groups
  - Listeners
- Auto Scaling Group (asg)