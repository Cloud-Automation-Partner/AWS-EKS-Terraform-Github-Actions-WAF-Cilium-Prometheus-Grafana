# Python, Next.js Applications deployment on AWS EKS using GitHub Actions, Terraform and Ansible for Cluster provisioning and Security Best Implementations.  

Deploying Python and Next.js applications on AWS EKS (Elastic Kubernetes Service) involves several steps and tools, each contributing to a robust, scalable, and secure infrastructure. This project leverages GitHub Actions for CI/CD, Terraform for infrastructure as code, AWS WAF and Cilium for security, and Prometheus/Grafana for monitoring. The complete infrastructure will be provisioned using the terraform and cilium will be installed using the Helm and Ansible. Trivy image scan is also implemennted in github actions for scaning the dockerised image fro any vulnerabilities and misconfiguration.


### Prerequisite
You should have basic Knowledge of AWS services, Docker, Kubernetes, and GitHub Actions, Terraform.

### Table of Content/Steps:
**1.** Create an AWS EC2 Instance and an IAM Role 

**2.** Add a Self Hosted Runner To AWS EC2
   
**3.** Docker Installation

**4.** GitHub Actions Setup

**5.** Installation of tools (Java JDK, Terraform, Trivy, Kubectl, Node.js, NPM, AWS CLI)

**6.** Provision AWS EKS With Terraform

**7.** Apply Prometheus/Grafa stack to the EKS cluster With Terraform

**8.** Dockerhub and Trivy Image Scan Setup

**9.** Deploy Application(images) to AWS EKS

**10.** Apply Cilium to the EKS Cluster using Ansible

**11.** Integrate Slack Notifications

**12.** Running Final/Complete Github actions Workflow

**13.** Applying the AWS WAF to the Application

**14.** Delete the infrastructure (To Avoid Extra Billing, if you are just using it for learning Purposes)


### Step 01:  Create an AWS EC2 Instance and an IAM Role 

#### Create IAM Role

You have to Navigate to **AWS Console**.

<img width="1200" alt="Screenshot 2024-01-10 at 1 46 32 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/80904fdf-5251-4514-a74a-c9c21483f2d4">


<br/>

Then Search/Enter **IAM**

<br/>

<img width="1200" alt="Screenshot 2024-01-10 at 1 48 17 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/dccddddb-180b-4079-9e23-004b629f99c9">

<br/>

Click **Roles**

<br/>

<img width="1200" alt="Screenshot 2024-01-10 at 1 50 14 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/fda78c7a-c360-46a8-a77a-24d1a68256cd">

<br/>
<br/> 

Then Click **Create role**

<br/>

<img width="1200" alt="Screenshot 2024-01-10 at 1 56 03 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/a11cd0fb-c526-4f77-9398-940f00e481e9">

<br/> 
<br/>

Now Click **AWS Service**, And Then Click **Choose a service or use case**

<br/>
<br/> 

<img width="1200" alt="Screenshot 2024-01-10 at 1 57 20 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/b4c4e964-f3a4-4053-9416-e776fa6bd50d">

<br/>

Now Click **EC2** and Click **NEXT**

<br/>

<img width="9120000" alt="Screenshot 2024-01-10 at 1 58 03 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/1c30b110-9c2b-49d8-9248-b85dd8b97995">

<br/> 
<br/>

Click the **Search** Fileds, Then Add permissions Policies

<br/>

<img width="1200" alt="Screenshot 2024-01-10 at 2 16 39 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/2b94cd9f-f0a6-406a-9c87-ee0d2a1d5931">

<br/> 
<br/>

Add These **Four Policies**:

1.  EC2 full access
2.  AmazonS3FullAccess
3.  AmazonEKSClusterPolicy
4.  AdministratorAccess

<img width="1200" alt="Screenshot 2024-01-11 at 6 55 41 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/c16ab079-983f-4639-b526-c861e14708f8">   

<br/> 
<br/> 


Click NEXT and Then click the **Role Name** Field.

Type **Kubernetes-Role**

Click **Create role**

<br/>   

<img width="1200" alt="Screenshot 2024-04-02 at 11 39 38 AM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/58f141c1-bacf-4f3d-834e-6e232d79fb52">


<br/> 
<br/> 


**Note** We will attach this IAM Role during AWS EC2 instance Creation.

#### Create AWS EC2 Instance
To launch an AWS EC2 instance running Amazon Linux2 via the AWS Management Console, start by signing in to your AWS account and accessing the EC2 dashboard. Click on "Launch Instances" and proceed through the steps. In "Step 1," select "Amazon Linux2" as the AMI, and in "Step 2," opt for "t2.medium" as the instance type. Configure instance details, storage, tags, and security group settings according to your requirements. Additionally, attach the previously created IAM role in the advanced details. Review the settings, create or select a key pair for secure access, and then launch the instance. Once launched, utilize the associated key pair to connect via SSH for access, ensuring the security of your connection. (Look at image Below)

<br/> 
<br/> 

<img width="1200" alt="Screenshot 2024-04-01 at 12 22 06 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/076561d4-055c-4b40-b7d5-081f2782e72d">

<img width="1200" alt="Screenshot 2024-01-10 at 5 40 25 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/e6a01cce-9cb4-4427-ae3d-e37394fd47d2">



### Step 02: Add a Self Hosted Runner To AWS EC2
Now Go to GitHub Repository and  click on **Settings -> Actions -> Runners**

Click on New self-hosted runner

<img width="1200" alt="Screenshot 2024-01-10 at 1 35 16 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/7ec228ac-7ae7-4469-9896-be0d149caf3a">



<br/>

<img width="1200" alt="Screenshot 2024-04-02 at 11 55 46 AM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/c13c2a42-2508-4c12-ba29-ffeb557eb806">

<br/> 

Now select Linux and Architecture X64

<img width="1200" alt="Screenshot 2024-04-02 at 12 01 03 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/a36d9efe-e3d6-4cc6-8ef1-2a1d1ecd0151">


Use the below commands to add a self-hosted runner

**Note:** In below picture Commads are related to my account, Use your commands, that appeared on your GitHub  self-hosted runner Page. 

<img width="1200" alt="Screenshot 2024-04-02 at 12 02 24 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/93cf36aa-2940-4b8e-9c1b-9d83b018f24d">


Now SSH into your AWS instance And Run below commands.

  ```bash
  mkdir actions-runner && cd actions-runner
  ```
<img width="1200" alt="Screenshot 2024-01-10 at 6 02 16 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/e8eb37b2-8235-4f11-8367-31659346496c">


Command "mkdir actions-runner && cd actions-runner" serves to generate a fresh directory named "actions-runner" within the present working directory. Subsequently, it swiftly switches the current working directory to this newly created "actions-runner" directory. This approach streamlines file organization and facilitates executing successive actions within the newly formed directory without the need for separate navigation.

Download the latest runner package

```bash
curl -o actions-runner-linux-x64-2.311.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz
```

<img width="1200" alt="Screenshot 2024-01-10 at 6 07 25 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/f28cbfd1-bdf3-4978-8897-737d2a2d2b91">


Validate the hash.

```bash
echo "29fc8cf2dab4c195bb147384e7e2c94cfd4d4022c793b346a6175435265aa278  actions-runner-linux-x64-2.311.0.tar.gz" | shasum -a 256 -c
```

<img width="1200" alt="Screenshot 2024-01-10 at 6 10 55 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/347f2150-2adc-4b72-b775-b2628689fa92">


Now Extract the installer

```bash
tar xzf ./actions-runner-linux-x64-2.311.0.tar.gz
```

Create the runner and start the configuration experience

```bash
./config.sh --url https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions --token XXXXXXXXXXXXXXXXXXXXXX
```

<img width="1200" alt="Screenshot 2024-04-02 at 12 10 44 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/e728e5a9-b945-434e-9ba3-106bd6d1ed57">


If you have provided multiple labels use commands for each label.

The last step, run it!

```bash
./run.sh
```
<img width="1200" alt="Screenshot 2024-01-10 at 6 17 33 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/8188a391-b3fe-4a26-860e-91632745b91c">


Let's close Runner for now.

```bash
ctrl + c  # To close Run this Command.
```




### Step 03:  Docker Installation
Connect with your Instance using SSH or Putty.(The Method you are using). If already connected, ignore.

Run these commands

```bash
sudo yum update
```
```bash
sudo yum install docker.io -y
```
```bash
sudo usermod -aG docker ec2-user
```
```bash
newgrp docker
```
```bash
sudo chmod 777 /var/run/docker.sock
```

### Step 04:  Github Actions setup

Go to GitHub and click on Add file and then create a new file

<img width="1200" alt="Screenshot 2024-04-01 at 12 26 23 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/5fd536c2-d82e-4219-908c-9c1de7f780bd">


Enter the file name and add content

<img width="1200" alt="Screenshot 2024-04-02 at 4 12 22 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions-WAF-Cilium-Prometheus-Grafana/assets/147611434/d602b43b-73d1-4b51-8f15-303ead7720a1">


Here is the file name

```bash
.github/workflows/build.yml
```


Copy content and add it to the file

```yml
nname: Build Workflow

on:
    push:
      branches: 
        - main
        
jobs:
  build:
    name: Build
    runs-on: self-hosted
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Python Docker build
        run: |
          docker build -t python-backend .

      - name: Next.js Docker build
        run: |
          cd chatbot-ui
          docker build -t next-frontend .
```

Click on commit changes

<img width="1200" alt="Screenshot 2024-03-29 at 2 45 57 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/63a98724-1679-4aa3-aadb-b272b2b028f7">


Now workflow is created.

Start again GitHub actions runner from the Ec2 instance
Run These Commands

```bash
cd actions-runner
```
```bash
./run.sh
```

Click on Actions now


Now the workflow is automatically started
<img width="1200" alt="Screenshot 2024-03-29 at 2 52 53 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/de249cfc-0ae1-46ed-a0ce-da38535853fa">


Let's click on Build and see what are the steps involved

<img width="1200" alt="Screenshot 2024-03-29 at 2 54 22 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/cfc7c8fa-4dbb-4259-8036-9d2550109a21">

Build complete.


### Step 05: Installation of tools (Java JDK, Terraform, Kubectl, Node.js, NPM, AWS CLI)

Use this script to automate the installation of these tools.

Create script on Your aws ec2.

```bash
vim  run.sh
```

Copy the Below given content

```bash
#!/bin/bash
sudo apt update -y
sudo touch /etc/apt/keyrings/adoptium.asc
sudo wget -O /etc/apt/keyrings/adoptium.asc https://packages.adoptium.net/artifactory/api/gpg/key/public
echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo apt update -y
sudo apt install temurin-17-jdk -y
/usr/bin/java --version

# Install Trivy
sudo apt-get install wget apt-transport-https gnupg lsb-release -y
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy -y

# Install Terraform
sudo apt install wget -y
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# Install AWS CLI 
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt-get install unzip -y
unzip awscliv2.zip
sudo ./aws/install

# Install kubectl
sudo apt update
sudo apt install curl -y
curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client


# Install Node.js 16 and npm
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/nodesource-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/nodesource-archive-keyring.gpg] https://deb.nodesource.com/node_16.x focal main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt update
sudo apt install -y nodejs

```

Now Run this script:

```bash
chmod +x run.sh

./run.sh
```


Now Check if these tools are installed or not By checking their versions using commands below.

```bash
kubectl version
```
```bash
aws --version
```
```bash
java --version
```
```bash
trivy --version
```
```bash
terraform --version
```
```bash
node -v
```

### Part 06: Provision AWS EKS With Terraform

Note: Before starting this part 06, Make sure Terraform and AWS CLI are installed and an aws account is configured on your system.

For configuring the AWS credentials run the command below and enter you AWS details accordingly

```bash
aws configure
```

Once AWS credentials are setup the clone repo:

```bash
https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions
```
```bash
cd AWS-EKS-Terraform-Github-Actions
```
```bash
cd terraform-eks
```

This will change your directory to terraform-eks files.

Now you have to add your s3 bucket details in the backend.tf file. (You can create S3 Bucket on AWS S3)

Now initialize the terraform.

```bash
terraform init
```
<img width="1200" alt="Screenshot 2024-03-29 at 3 29 17 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/dfa45a66-d434-443a-a6bd-2ed81f24758f">

Now validate the configurations and syntax of all files.

```bash
terraform validate
```
<img width="1200" alt="Screenshot 2024-03-29 at 3 48 48 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/d26ed3a1-5341-42d6-81bf-922e6ec99966">

Now Plan and apply your infrastructure.

```bash
terraform plan
```
```bash
terraform apply -auto-approve
```
<img width="1200" alt="Screenshot 2024-03-29 at 4 12 50 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/c6da6cd3-d750-41d6-8287-6915845fb6ce">



It can take up to 10 Minutes to provision your AWS EKS cluster.
<img width="1200" alt="Screenshot 2024-03-29 at 4 11 33 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/e555751c-e4b4-4a63-866b-ff45af380b9b">


You can check by going to aws EKS service.

<img width="1200" alt="Screenshot 2024-03-29 at 4 15 23 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/3beb96e8-dd87-468b-a1b8-90515aea5a81">

Also, check your Node Grpup EC2 Instance, by going to EC2 Dashboard.

<img width="1200" alt="Screenshot 2024-03-29 at 4 18 00 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/a45976bc-f8a0-4c73-b441-1b39dcf12f60">


### Step 07:  Apply Prometheus/Grafa stack to the EKS cluster using Terraform

Now switch your directory to apply the Prometheus/Grafa to our EKS cluster  

```
cd prometheus/
```
And run below terraform commands to apply the prometheus using Helm and terraform  

```bash
terraform init
```
```bash
terraform validate
```
```bash
terraform apply
```
<img width="1200" alt="Screenshot 2024-03-29 at 4 21 27 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/a120ef14-c8b0-42b6-bfdd-60d54c638fda">

Verify the prometheus Installation  

```bash
kubectl get svc -n prometheus
```
<img width="1200" alt="Screenshot 2024-03-29 at 4 25 51 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/a78d5eb9-59e6-45b3-b7b2-63ab0faeac9c">

***Once you get the output like above image then for Accessing Grafana & Prometheus on the Web follow the below instructions:***

Run this command to edit the Prometheus-grafana service to ELB  

```bash
kubectl edit svc prometheus-grafana -n prometheus
```
You should see a new screen pop up like shown below  

<img width="511" alt="Screenshot 2024-04-02 at 4 33 09 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions-WAF-Cilium-Prometheus-Grafana/assets/147611434/12f71212-952f-4228-8c7c-8b41f7e86389">  

Scroll down to the point where you see this ‘type: ClusterIP’ and change it to these exact words  

```bash
LoadBalancer
```

Now run the command below to get the Prometheus ELB port and ELB public address

```bash
kubectl get svc -n prometheus
```
<img width="1200" alt="Screenshot 2024-03-29 at 4 25 51 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/a78d5eb9-59e6-45b3-b7b2-63ab0faeac9c">

Now copy the nodeport given with the ELB and allow that port in the respective security group of the ELB, Once done then copy the ELB address and paste it in your browser it will load the Grafana/Prometheus like below  

<img width="575" alt="Screenshot 2024-04-02 at 4 40 18 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions-WAF-Cilium-Prometheus-Grafana/assets/147611434/1ff045f4-f0e3-4ea1-9770-814c2d8587a7">

Use below credentials for login into the Grafa  

```
username: admin
password: prom-operator.
```

After loging in, this is how the interface will look like  

<img width="607" alt="Screenshot 2024-04-02 at 4 44 19 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions-WAF-Cilium-Prometheus-Grafana/assets/147611434/6c4b5601-5c28-4b93-bd78-464e322818c1">  

Now run the below command to get the prometheus UI  

```bash
kubectl edit svc prometheus-kube-prometheus-prometheus -n prometheus
```
And follow the same instructions like the Grafana to get the Prometheus UI


### Part 08: Dockerhub and Trivy Image Scan Setup

Now you have to create a Personal Access token for your Dockerhub account.

Go to docker hub and click on your profile --> My Account --> security --> New access token
<img width="1200" alt="Screenshot 2024-03-29 at 4 32 19 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/ba783b90-898b-4ce7-941f-f651208be4c9">

Add your details and click generate
<img width="1200" alt="Screenshot 2024-03-29 at 4 33 06 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/97c2bca5-dd9c-4b93-a693-5241ece2b06f">

Add this Token to your Github actions Secret.

<img width="1200" alt="Screenshot 2024-03-29 at 5 30 15 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/83206541-6833-427f-9ae6-2ae112c26caf">

Also, add another secret of your dockerhub username.

<img width="1200" alt="Screenshot 2024-03-29 at 5 30 56 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/98dfa788-deb1-4388-9d7d-904381b311b2">


Now modify your build.yml according to below to add Dockerhub details in the workflow file created previously

```yml
nname: Build Workflow

on:
    push:
      branches: 
        - main
        
jobs:
  build:
    name: Build
    runs-on: self-hosted
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Python Docker build and push
        run: |
          docker build -t python-backend .
          docker tag python-backend DOCKERHUB_USERNAME/python-backend:latest
          docker login -u ${{ secrets.DOCKERHUB_USERNAME }} -p ${{ secrets.DOCKERHUB_TOKEN }}
          docker push DOCKERHUB_USERNAME/python-backend:latest

      - name: Next.js Docker build and push
        run: |
          cd chatbot-ui
          docker build -t next-frontend .
          docker tag next-frontend DOCKERHUB_USERNAME/next-frontend:latest
          docker login -u ${{ secrets.DOCKERHUB_USERNAME }} -p ${{ secrets.DOCKERHUB_TOKEN }}
          docker push DOCKERHUB_USERNAME/next-frontend:latest
```
It will trigger the workflow to run

<img width="1200" alt="Screenshot 2024-01-11 at 3 34 04 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/9c8a280e-07a6-42a0-bfd3-8a1d6d610d94">

Now you can check images are pushed to your Dockerhub Account.

<img width="1200" alt="Screenshot 2024-04-01 at 11 59 35 AM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/025f0972-643b-4f40-ae66-b805d002bdb9">
<img width="1200" alt="Screenshot 2024-04-01 at 11 59 56 AM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/5341f811-217e-4e4d-9e11-5be60e7c8c66">


Now add another Workflow for the docker image scan, using the name 'trivy.yml'. Use the content below, but make sure to replace the image with your one.


```yml
name: Trivy Image Scan Workflow

on:
    workflow_run:
      workflows: 
        - Build Workflow
      types:
        - completed
  
jobs:
    build:
      name: Docker Image Scan
      runs-on: self-hosted
      steps:
        - name: Checkout Repository
          uses: actions/checkout@v2

        - name: Pull the Python Docker image
          run: docker pull DOCKERHUB_USERNAME/python-backend:latest

  
        - name: Trivy image scan Python
          run: trivy image DOCKERHUB_USERNAME/python-backend:latest

        - name: Pull the Next Docker image
          run: docker pull DOCKERHUB_USERNAME/next-frontend:latest

  
        - name: Trivy image scan next
          run: trivy image DOCKERHUB_USERNAME/next-frontend:latest

```

Here is the output of the build.

<img width="897" alt="Screenshot 2024-04-02 at 12 21 08 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/a61b5dd1-50ad-48a6-aea6-684d163e20d9">

```yml

# Now add these lines into build.yml steps, so we can test image on our aws ec2 instance.

      - name: Stop and remove existing container
        run: |
            docker stop python-backend || true
            docker rm python-backend || true
            docker stop next-frontend || true
            docker rm next-fronntend || true
  
      - name: Run the python container on AWS EC2 for testing
        run: docker run -d --name python-backend -p 3000:3000 DOCKERHUB_USERNAME/python-backend:latest

      - name: Run the Next.js container on AWS EC2 for testing
        run: docker run -d --name next-frontend -p 80:80 DOCKERHUB_USERNAME/next-frontend:latest
  

```

When Build is completed , visit the websiet in your browser.

Note: Make sure port 3000 and 80 are added on your Ec2 security group.


```bash
"Your_EC2_IP:80"
```


If it's not working, Try to pull the images on your system and check for errors. Fix them then build the GitHub actions again.

### Part 09: Deploy Application(images) to AWS EKS

Now create our final deploy.yml file to deploy on aws eks.

And Paste this content there. (Do not commit yet, commit it after part  09)

**Note**. Make sure to repalce cluster name and region name According to your project.

```yml

 name: Deploy To EKS

on:
    workflow_run:
      workflows: 
        - Build Workflow
      types:
        - completed
  
jobs:
    build:
      name: Docker Image Scan
      runs-on: self-hosted
      steps:
        - name: Checkout Repository
          uses: actions/checkout@v2

        - name: Pull the Fronntend Docker image
          run: docker pull DOCKERHUB_USERNAME/next-frontend:latest1:latest

        - name: Pull the Backend Docker image
          run: docker pull DOCKERHUB_USERNAME/python-backend:latest
  
        - name: Update kubeconfig
          run: aws eks --region us-west-2 update-kubeconfig --name EKS_cluster_capautomation
        
        - name: Create ersistant Volume for Postgress
          run: kubectl apply -f pvc.yml

        - name: Deploy Postgress
          run: kubectl apply -f postgres-deployment.yaml
        
        - name: Deploy python Backend
          run: kubectl apply -f python-deployment-service.yml
  
        - name: Deploy Nexxt.js Frontend
          run: kubectl apply -f deployment-service.yml 
  
        - name: Verify The Services
          run: kubectl get all  
```
This will updates the kubeconfig to configure kubectl to work with an Amazon EKS cluster in the region with the name of your cluster, Also deploy Kubernetes resources defined in the deployment manifest files to the Amazon EKS cluster using kubectl apply.

### Step 10:  Apply Cilium to the EKS Cluster using Ansible

Now get back to the root of our project and apply the ansible playbook to our cluster for installing the cilium tool for network security in our cluster

```bash
cd ../../
ansible-playbook install_cilium.yml
```

Verify the Cilium Installation

```bash
kubectl get pods -n kube-system -l k8s-app=cilium
```

For verifying the cilium working we need to install the cilium client in our EC2

```bash
curl -L --remote-name-all https://github.com/cilium/cilium-cli/releases/latest/download/cilium-linux-amd64.tar.gz
```
```bash
tar xzvf cilium-linux-amd64.tar.gz
```
```bash
sudo mv cilium /usr/local/bin
```

Check client Installation 
```bash
cilium version
```
Once installed, you can check the status with:

```bash
cilium status
```

For a simple connectivity test, you can use:

```bash
cilium connectivity test
```

Inspect the Cilium-managed endpoints to ensure they are all in a healthy state:
```bash
cilium endpoint list
```
Checking the logs of the Cilium pods can also provide insights for any issues or errors:

```bash
kubectl logs -n kube-system -l k8s-app=cilium
```   

### Part 11: Integrate Slack Notifications

No Go to Your Slack and create a new channel for notifications.

Now Click on your slack account name --> settings & Administration --> Manage Apps

<img width="1200" alt="Screenshot 2024-04-01 at 12 52 45 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/a48409e3-ffdc-46cd-a0ae-1806fac9fbf0">


It will open a new tab, select build now

<img width="1200" alt="Screenshot 2024-01-11 at 5 48 09 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/df704fd9-c12e-42b1-ad4e-0e0b33b15a64">


Now Click on Create an app

<img width="1200" alt="Screenshot 2024-01-11 at 5 48 35 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/01b68280-1561-49c0-8cb9-d8b99592c6ca">

Select from scratch

<img width="1200" alt="Screenshot 2024-01-11 at 5 49 04 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/b8567ea6-6693-47e4-8633-84738f35cd0d">

Provide a name for the app and select workspace and create

<img width="1200" alt="Screenshot 2024-04-01 at 12 58 53 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/5ffa78e9-4f84-4a46-9b16-944da4bc3558">

Select Incoming webhooks

<img width="1200" alt="Screenshot 2024-01-11 at 5 50 30 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/69bbfc62-36f8-45f1-bebb-b8ec5edb7089">

Now Set incoming webhooks to "on"

<img width="1200" alt="Screenshot 2024-01-11 at 5 51 03 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/5cdda915-416b-40dc-b846-1d722fd926f1">

Click on Add New webhook to workspace

<img width="1496" alt="Screenshot 2024-01-11 at 5 51 38 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/bf582428-dc96-488a-929b-47a41b57f2b8">

Select Your channel that created for notifications and allow

<img width="1200" alt="Screenshot 2024-04-01 at 1 00 28 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/296426cf-fd93-48d5-8b66-15bf22e37e1a">


It will generate a webhook URL copy it

<img width="1200" alt="Screenshot 2024-01-11 at 5 53 14 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/49dd14a0-c0d1-4326-a8e9-e94fff4ddebd">


Now come back to GitHub and click on settings

Go to secrets --> actions --> new repository secret and add

<img width="1200" alt="Screenshot 2024-04-01 at 12 45 12 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/db006846-e81e-411c-b17f-6f9aa5e6277d">

### Step 12: Running Final/Complete Github actions Workflow

Add the below code to the deploy.yml workflow and commit and the workflow will start.

```yml

      - name: Send a Slack Notification
        if: always()
        uses: act10ns/slack@v1
        with:
          status: ${{ job.status }}
          steps: ${{ toJson(steps) }}
          channel: '#git'
        env:
          SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK_URL }}

```

This step sends a Slack notification. It uses the act10ns/slack action and is configured to run "always," which means it runs regardless of the job status. It sends the notification to the specified Slack channel using the webhook URL stored in secrets.


If you get this error, Try to configure aws cli on the ec2 instance to resolve this matter.

<img width="1200" alt="Screenshot 2024-01-11 at 8 57 56 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/0e8ebd67-5d53-463c-9ba0-abf4d7c445c8">

Now our build is completed.

<img width="1200" alt="Screenshot 2024-01-11 at 9 17 57 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/79029970-c701-4b6b-96b7-bfb163c5fedc">


And here is the Slack notification.

<img width="1200" alt="Screenshot 2024-01-11 at 9 14 47 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/82d4eafb-adde-4a4f-b646-8143ecc9e558">


Let’s go to the Ec2 ssh connection

Run this command.

```bash
kubectl get all
```

Open the port in the security group for the Node group instance.

After that copy the external IP and paste it into the browser

<img width="1200" alt="Screenshot 2024-01-11 at 9 23 10 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/faeb8e1b-6953-4f42-8d00-31946f2abaaa">

Here is the Output: The website is Live.

<img width="1200" alt="Screenshot 2024-04-01 at 12 43 07 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/80f0826c-220b-4601-8b09-ffac7fa211e7">

### Step 13: Applying the AWS WAF to the Application

Now once our complete application is deployed to the EKS now we will apply the AWS WAF to the application load balancers that are used to expose our frontend and backend

```bash
cd terraform-eks/eks-waf-setup
```
And run the terraform to apply the WAF with Core Rule Set in default 
Note: Please copy your ELB resource ARN from AWS and add that in main.tf below section

<img width="1200" alt="Screenshot 2024-04-01 at 5 33 44 PM" src="https://github.com/Cloud-Automation-Partner/AWS-EKS-Terraform-Github-Actions/assets/147611434/bf91bd4f-1a22-4ff2-9375-3fc18e775f85">

After adding the ARN run below commands

```bash
terraform init
terraform validate
terraform apply -auto-approve
```
This will provision an AWS WAF and attach the application ELB to it.

Note: In my case I am using only one WAF for my main fronted deployemnt.


### Step 14: Delete the infrastructure (To Avoid Extra Billing, if you are just using it for learning Purposes)

To destroy, Follow these Steps:

1. comment this line run: kubectl apply -f deployment-service.yml in deploy.yaml, adn add this line run: kubectl delete -f deployment-service.yml . You can say it replacement between lines. It will delete the container and delete the Kubernetes deployment.

2. Stop the self-hosted runner.

3. To delete the Eks cluster
   
```bash
cd /home/ubuntu
cd Project_root_folder
cd terraform-eks
terraform destroy --auto-approve
```

Then Delete this dockerhub token. Once cluster is destroyed, delete the ec2 instance and iam role.


## Acknowledgements
Special thanks to Cloud Automation Partners for creating this incredible Devops Project and simplifying the CI/CD process.




