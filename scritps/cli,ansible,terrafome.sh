curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

sudo apt install unzip

 unzip awscliv2.zip

sudo ./aws/install
 aws --version

 sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl

 wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.release
s.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt-get install terraform

terraform -version

python3 --version

sudo apt update

sudo apt install ansible

sudo apt install ansible-core

ansible --version

ansible-galaxy collection install amazon.aws --force

sudo apt install python3-pip

pip install boto3 --break-system-packages
