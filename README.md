### Contents

* Terraform - Deploy&Config VPC Network, Firewall,  VMs, NAT Gateway, Multi-Region
* Ansible - Config management for VMs, install docker on ubuntu, Get Secrets from GCP Secret Manager, Prepare config via git commands
* GCP
* gcloud CLI
* Linux commands  

---  


### gcloud cli  

```bash

#gcloud cli install
####
# Ubuntu 22.04 (WSL)
####
sudo apt-get update

sudo apt-get install apt-transport-https ca-certificates gnupg curl sudo

echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.gpg

sudo apt-get update && sudo apt-get install google-cloud-cli

sudo apt-get install google-cloud-sdk-config-connector

####
# MacOS
####

brew install --cask google-cloud-sdk
brew install google-cloud-sdk-config-connector
####

gcloud auth login
gcloud auth application-default login
gcloud config list account --format "value(core.account)"

#Enable Asset APIs
gcloud services enable cloudasset.googleapis.com

gcloud compute instances list

# External IP
gcloud compute instances list --format='get(networkInterfaces[0].accessConfigs[0].natIP)'

gcloud compute ssh instance --tunnel-through-iap
gcloud compute ssh abigail-instance --tunnel-through-iap --command="docker ps"
gcloud compute scp ./.infrastructure/scripts/deploy.sh instance:/opt/folder --tunnel-through-iap

## Check Zonal DNS at GCP VM
curl "http://metadata.google.internal/computeMetadata/v1/instance/hostname" \ -H "Metadata-Flavor: Google"

#Export GCP Infra to a terraform file
gcloud beta resource-config bulk-export \
 --path=./project-meawmeawx \
 --project=meawmeawx \
 --resource-format=terraform
```
---
### Python

```bash
pip install -r requirements.txt

# or 
pip install google-auth
pip install ansible
pip install pywinrm
pip install requests
```
---

### Bash (Linux commands)

```bash
git clone https://github.com/JohnK35/knowledge-share-1.git
chmod 755 gcp*.sh

cat /tmp/app/ssh_config >> ~/.ssh/config
###################
# Add by ansible
Host github.com
    HostName github.com
    IdentityFile /tmp/app/secrets/knowledge-share-1-private
###################

#add known_hosts for github
ssh-keyscan github.com >> ~/.ssh/known_hosts

git clone --depth 1 git@github.com:JohnK35/knowledge-share-1-private.git /tmp/app/checkout/
git -C /tmp/app/checkout/ pull

cat /etc/resolv.conf
```  
---  

### Ansible  

```bash
#ansible install

####
# Ubuntu 22.04 (WSL)
####

sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible

####
# MacOS
####
brew install ansible

####
ansible --version
ansible-config view
ansible-galaxy collection install google.cloud
ansible-inventory -i misc/inventory.gcp.yml --graph
ansible group1 -m ping
ansible label_labx_ -m ping
ansible-playbook -v -i misc/inventory.gcp.yml test.playbook.yml
ansible-playbook -vvvv -i misc/inventory.gcp.yml init.docker.playbook.yml -l 10.20.0.3
ansible-playbook -v -i misc/inventory.gcp.yml prepare.configure.playbook.yml -l labx
ansible-playbook -vvvv localhost.playbook.yml

# thank 
# https://www.heaton.dev/2022/09/ansible-via-google-cloud-iap-tunnel/
# https://www.bionconsulting.com/blog/gcp-iap-tunnelling-on-ansible-with-dynamic-inventory
# https://www.shellhacks.com/ansible-sudo-a-password-is-required/
```
---

### terraform

```bash
#Export GCP Infra to a terraform file
gcloud beta resource-config bulk-export \
 --path=./project-meawmeawx \
 --project=meawmeawx \
 --resource-format=terraform

####
# Ubuntu 22.04 (WSL)
####
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt-get install terraform

####
# MacOS
####
brew install terraform

####

terraform -help

terraform init
terraform fmt
terraform validate
terraform apply
terraform state list
terraform show

###Thank
# https://medium.com/slalom-technology/a-complete-gcp-environment-with-terraform-c087190366f0
# https://github.com/orlandothoeny/terraform-gcp-gke-infrastructure
# https://medium.com/google-cloud/gcp-how-to-deploy-cloud-nat-with-terraform-44745a4daaa8
# https://github.com/Eimert/terraform-google-compute-engine-instance/tree/master
# https://medium.com/slalom-technology/a-complete-gcp-environment-with-terraform-c087190366f0
# https://github.com/GoogleCloudPlatform/terraform-example-deploy-java-gke/tree/main
```  
