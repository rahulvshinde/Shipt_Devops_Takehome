# Shipt Devops Assignment
##Part1
1. Provider.tf: AWS provider is used to interact with required resources.
2. vars.tf: It has all the necessary variables declared.
3. keypairs.tf: aws_key_pair resource is used to push public key to the aws so that later we will be able to access the instances created. 
4. vpc.tf: A basic 10.0.0.0/16 vpc has been created and two private sunbets declared in it. (For testing purpose as it was not asked to do in the assignment)
5. securitygroup.tf: We have created individual security groups for ELB, Autoscaling, Redis as per the requirement of the assignment. No outside access has been provided.
6. Autoscaling.tf: We are using t2.micro instances to be spin up in the auto scaling group. It has minimum of 2 instances. In order to scale up or scale down we have implemented two policies. If the CPU usage is above 30% for 120 seconds for two consecutive checks, it will auto spin up another instance. Whereas, if the CPU usage goes down below 5%, it will destroy one instance.
7. Redis.tf: Lastly, we have created Redis replication group which will be available in two availability zones. Redis will be running on port 6379.

##Part2
Please refer attached AWS Netword diagram.
