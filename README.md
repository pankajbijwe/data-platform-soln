Building production-grade AWS architecture capable of handling gigabytes of data and sustaining 5000 transactions per second (TPS), 

Key focus areas
- Scalable compute and storage
- Security controls (IAM, encryption, VPC)
- Operational controls (logging, monitoring)
- Cost optimization (auto-scaling, spot instances, lifecycle policies


Architecture Overview
- Layer | AWS Services Used 
- Compute | Amazon ECS with Fargate or EKS (for containerized workloads), Lambda (for async) 
- Storage | Amazon S3 (raw data), DynamoDB or Aurora (high TPS), EFS (shared state) 
- Networking | VPC, Subnets, NAT Gateway, ALB, Security Groups 
- Security | IAM Roles/Policies, KMS, Secrets Manager, GuardDuty 
- Observability | CloudWatch, X-Ray, CloudTrail, AWS Config 
- Cost Optimization | Auto Scaling, Spot Instances, S3 Lifecycle, Savings Plans 


 Best Practices Embedded
-  Security: IAM least privilege, KMS encryption, Secrets Manager
-  Operational Controls: CloudTrail, CloudWatch, Config
-  Cost Optimization: Spot instances (ECS/EKS), S3 lifecycle, PAY_PER_REQUEST DynamoDB
-  Scalability: Fargate/EKS auto-scaling, ALB, multi-AZ subnets


