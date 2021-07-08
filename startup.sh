cd ~/Downloads
sudo apt-get update && sudo apt-get upgrade -y

echo 'installing snap'
sudo apt install snapd -y

echo 'installing curl' 
sudo apt install curl -y

echo 'installing git' 
sudo apt install git -y

echo "What name do you want to use in GIT user.name?"
read git_config_user_name
git config --global user.name "$git_config_user_name"
clear

echo "What email do you want to use in GIT user.email?"
read git_config_user_email
git config --global user.email $git_config_user_email
clear

echo 'installing vim'
sudo apt install vim -y
clear

echo "Can I set VIM as your default GIT editor for you? (y/n)"
read git_core_editor_to_vim
if echo "$git_core_editor_to_vim" | grep -iq "^y" ;then
	git config --global core.editor vim
else
	echo "Okay, no problem. :) Let's move on!"
fi

sudo apt install apt-transport-https ca-certificates gnupg-agent software-properties-common -y
#printf "\nca_directtee -a /etc/wgetrc" | sudo t

echo 'installing tool to handle clipboard via CLI'
sudo apt-get install xclip -y

echo 'installing zsh'
sudo apt-get install zsh -y
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh --no-check-certificate -O -)"
chsh -s /bin/zsh

echo 'installing autosuggestions' 
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
source ~/.zshrc

export alias pbcopy='xclip -selection clipboard'
export alias pbpaste='xclip -selection clipboard -o'
source ~/.zshrc

echo "Generating a SSH Key"
ssh-keygen -t rsa -b 4096 -C $git_config_user_email
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub | xclip -selection clipboard

echo 'installing code'
curl -vs https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get update
sudo apt-get install code -y # or code-insiders

echo 'installing chrome' 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

echo 'installing docker' 
sudo apt-get remove docker docker-engine docker.io
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
docker --version

sudo chmod 777 /var/run/docker.sock

echo 'installing docker-compose' 
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

echo 'installing Golang'
sudo snap install --classic go

echo 'installing Make'
sudo apt install make -y

echo 'installing dbeaver'
wget -c https://dbeaver.io/files/6.0.0/dbeaver-ce_6.0.0_amd64.deb
sudo dpkg -i dbeaver-ce_6.0.0_amd64.deb
sudo apt-get install -f

sudo apt install net-tools -y
sudo apt-get install build-essential gcc make perl dkms -y

echo 'installing Spotify'
snap install spotify

echo 'installing Skype'
sudo snap install skype --classic
