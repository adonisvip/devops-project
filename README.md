# **THIS PROJECT USED TO DECRIBE THE BASIC DEVOPS PROCESS** 


## **CLONE PROJECT BY LINK**

[**https://github.com/tuananh281/my_first_project**]

## PROVISION VM ON MS AZURE
![example](image_readme/so_do1.png)

***The first, you can genarate ssh publickey and privatekey, move to cloned folder and copy private_key to ansible folder and copy file private_key to folder ansible***

1. Set permision for 2 key ssh
>On Linux and Mac: **chmod 400 key_name** 

>On Windows: **right-click key -> Properties -> Security -> Advanced -> Disable inher.... -> OK -> Edit -> Add -> username my device -> OK** 
1. Edit information on file terraform.tfvars
   You need to edit your information
   ![example](image_readme/edit_tfvars.png)
2. Run terraform
>terraform init

Apply code  to provisioning VM in Azure

>terraform apply --auto approve

or 

>terraform plan -out tfplan

>terraform apply tfplan 

3. Get public IP of VM after apply
   
![example](image_readme/output.png)

4. Connect to VM
>Access the directory without ssh key:</p>
>ssh -i private_key_name username@public_ip

1. Set up connect ansible
   
Run command
>ssh-agent bash

>ssh-add /home/k8s/ansible/private_key.pem

>ssh-copy-id <ip_private_worker1,2>

![example](image_readme/setup_connect_ssh.png)

Edit inventory file on Ansible folder, get ip_private of VM and run command
>sed -i "s+cp ansible_host=control_plane_ip+cp ansible_host=**ip**+g" ./ansible/inventory

>sed -i "s+worker1 ansible_host=worker_1_ip+worker1 ansible_host=**ip**+g" ./ansible/inventory

>sed -i "s+worker2 ansible_host=worker_2_ip+worker2 ansible_host=**ip**+g" ./ansible/inventory

Check inventory file

![example](image_readme/check_inventory.png)

6. Create cluster k8s

- Check connect trong ansible:
>ansible -i ./ansible/inventory -m ping all

- Install dependencies, access to folder anible you run command
>ansible-playbook -i inventory install_kube_dependenci.yml

- Create cluster on control-plane
>ansible-playbook -i inventory create_cluster.yml

- Join cluster from worker
>ansible-playbook -i inventory join_cluster.yml

- Check cluster is ready
>watch kubectl get node

![example](image_readme/check_node.png)

## SETUP GITOPS WITH ARGOCD ON K8S

![example](image_readme/so_do2.png)

1. Install Jenkins on cluster

**You can setup jenkins outside k8s**

reference link: **https://www.jenkins.io/doc/book/installing/** and **https://www.youtube.com/watch?v=d2-HXYKjfbc&ab_channel=KSPM-K%E1%BB%B9S%C6%B0Ph%E1%BA%A7nM%E1%BB%81m**

2. Install argocd
>kubectl create namespace argocd

>kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

Edit service argocd-server of argocd 

>kubectl edit svc argocd-server -n argocd

>>type ClusterIP  >> NodePort

Get port of service argocd-server

>kubectl get svc -n argocd

![example](image_readme/argocd_install.png)

2. Install argocd-cli

>sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64

>sudo chmod +x /usr/local/bin/argocd

Check version of argocd cli

>argocd version

3. Login ArgoCD

user: admin

Get password of ArgoCD

>kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

login web
>http://public_ip_control_plan:port

![example](image_readme/argocd_gui.png)

login cli
>argocd login public_ip_control_plane:port

4. Setup on Jenkins

5. Setup ArgoCD






