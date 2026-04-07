docker version
docker compose version
shutdown now
apt install -y curl
curl -fsSL https://deb.nodesource.com/setup_24.x | sudo -E bash -
sudo apt install -y nodejs
node -v
npm -v
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
apt-get update
apt-get install -y ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
docker run hello-world
usermod -aG docker $USER
newgrp docker
mkdir -p /etc/apt/keyrings
curl -fsSL https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg |   sudo gpg --dearmor --yes -o /etc/apt/keyrings/antigravity-repo-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" | \
sudo tee /etc/apt/sources.list.d/antigravity.list > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" |   sudo tee /etc/apt/sources.list.d/antigravity.list > /dev/null
apt update
apt install antigravity
exit
cd /home
ls -al
cd myeon
ls -al
cd Desktop
ls -al
cat assignment.py
shutdown now
git init
git add .
git commit -m "first commit"
git config --global user.email "gusrud00825@khu.ac.kr"
git config --global user.name "MyeonGyeong111"
git commit -m "first commit"
git remote add origin https://github.com/MyeonGyeong111/HW2.git
git push -u origin master
cd /HOme
cd /Home
cd /Desktop
ls -al
cd ~/Desktop
cd /home
ls -ak
ls -al
cd myeon
ls -al
cd Desktop
ls -al
cd age_prediction_api
rm -rf .git
git init
git remote add origin https://github.com/MyeonGyeong111/HW2.git
git add .
git config --global --add safe.directory /home/myeon/Desktop/age_prediction_api
git add .
git commit -m "first commit"
git remote add origin https://github.com/MyeonGyeong111/HW2.git
git push -u origin master
git push origin master --force
