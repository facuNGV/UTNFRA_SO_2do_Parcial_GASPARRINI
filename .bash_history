lsblk
ls
mkdir repogit
ls
cd repogit/
git clone https://github.com/upszot/UTN-FRA_SO_Examenes.git
cd ..
git clone https://github.com/facuNGV/UTNFRA_SO_2do_Parcial_GASPARRINI.git
ls
./UTN-FRA_SO_Examenes/202406/script_Precondicion.sh
cd repogit/
./UTN-FRA_SO_Examenes/202406/script_Precondicion.sh
source ~/.bashrc
history -a
sudo apt update
sudo apt install ansible
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources:
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 
sudo docker run hello-world
sudo usermod -a -G docker $(whoami)
exit
ls
cd RTA_Examen_20241118/
ls
ls -la
sudo chmod 775 Punto_A.sh Punto_B.sh Punto_C.sh Punto_D.sh
ls -la
vim Punto_A.sh
PATH_DISCO_PARTICIONAR1=$(lsblk | grep 1G | head -n 1 | awk '{print "/dev/"$1}')
echo "Particionando disco de 1GB"
sudo fdisk $PATH_DISCO_PARTICIONAR1
PATH_DISCO_PARTICIONAR2=$(lsblk | grep 2G | head -n 1 | awk '{print "/dev/"$1}')
sudo fdisk $PATH_DISCO_PARTICIONAR2
PATH_PARTICION_TEMP="${PATH_DISCO_PARTICIONAR1}1"
PATH_PARTICION_DATOS="${PATH_DISCO_PARTICIONAR2}1"
sudo wipefs -a $PATH_PARTICION_DATOS $PATH_PARTICION_TEMP
sudo pvcreate $PATH_PARTICION_DATOS $PATH_PARTICION_TEMP
sudo vgcreate vg_temp $PATH_PARTICION_TEMP
sudo vgcreate vg_datos $PATH_PARTICION_DATOS
sudo lvcreate -L 5M -n lv_docker vg_datos
sudo lvcreate -L 1.5G -n lv_workareas vg_datos
sudo lvcreate -L 512M -n lv_swap vg_temp
sudo fdisk -l | grep swap | awk '{print $2}' | cut -d':' -f1
PATH_LV_SWAP=$(sudo fdisk -l | grep swap | awk '{print $2}' | cut -d':' -f1)
sudo mkswap $PATH_LV_SWAP
sudo swapon $PATH_LV_SWAP
sudo mkdir /work/
PATH_LV_DOCKER=$(sudo fdisk -l | grep lv_docker | awk '{print $2}' | cut -d':' -f1)
PATH_LV_WORKAREAS=$(sudo fdisk -l | grep workareas | awk '{print $2}' | cut -d':' -f1)
sudo mkfs.ext4 $PATH_LV_DOCKER
sudo mkfs.ext4 $PATH_LV_WORKAREAS
sudo mount $PATH_LV_DOCKER /var/lib/docker/
sudo mount $PATH_LV_WORKAREAS /work/
sudo systemctl restart docker
ls
vim Punto_A.sh
lsblk
history -a
cd /usr/local/bin
ls
touch GasparriniAltaUser-Groups.sh
sudo touch GasparriniAltaUser-Groups.sh
ls
ls -la
sudo chmod 755 GasparriniAltaUser-Groups.sh
ls
vim GasparriniAltaUser-Groups.sh
sudo vim GasparriniAltaUser-Groups.sh
usuario_ref=$1 
passwd vagrant
sudo passwd vagrant
sudo grep "vagrant" /etc/shadow | awk -F ':' '{print $2}'
contra_de_usuarios=$(sudo grep "vagrant" /etc/shadow | awk -F ':' '{print $2}')
cd /usr/local/bin
contra_de_usuarios=$(sudo grep "vagrant" /etc/shadow | awk -F ':' '{print $2}')
primer_usuario=$(grep Prog1 /home/vagrant/repogit/UTN-FRA_SO_Examenes/202406/bash_script/Lista_Usuarios.txt | awk -F ',' '{print $1}')
segundo_usuario=$(grep Prog2 /home/vagrant/repogit/UTN-FRA_SO_Examenes/202406/bash_script/Lista_Usuarios.txt | awk -F ',' '{print $1}')
tercer_usuario=$(grep Test1 /home/vagrant/repogit/UTN-FRA_SO_Examenes/202406/bash_script/Lista_Usuarios.txt | awk -F ',' '{print $1}')
cuarto_usuario=$(grep Supervisor /home/vagrant/repogit/UTN-FRA_SO_Examenes/202406/bash_script/Lista_Usuarios.txt | awk -F ',' '{print $1}')
grupo_desarrolladores=$(grep Prog1 /home/vagrant/repogit/UTN-FRA_SO_Examenes/202406/bash_script/Lista_Usuarios.txt | awk -F ',' '{print $2}')
grupo_testers=$(grep Test1 /home/vagrant/repogit/UTN-FRA_SO_Examenes/202406/bash_script/Lista_Usuarios.txt| awk -F ',' '{print $2}')
grupo_supervisores=$(grep Supervisor /home/vagrant/repogit/UTN-FRA_SO_Examenes/202406/bash_script/Lista_Usuarios.txt | awk -F ',' '{print $2}')
path_lista_usuarios=/home/vagrant/repogit/UTN-FRA_SO_Examenes/202406/bash_script/Lista_Usuarios.txt
home_primer_usuario=$(grep Prog1 $path_lista_usuarios | awk -F ',' '{print $3}')
home_segundo_usuario=$(grep Prog2 $path_lista_usuarios | awk -F ',' '{print $3}')
home_tercer_usuario=$(grep Test1 $path_lista_usuarios | awk -F ',' '{print $3}')
home_cuarto_usuario=$(grep Supervisor $path_lista_usuarios | awk -F ',' '{print $3}')
sudo groupadd $grupo_desarrolladores
sudo groupadd $grupo_testers
sudo groupadd $grupo_supervisores
sudo useradd -m -d "$home_primer_usuario" -s /bin/bash -c "Usuario Prog1" -G $grupo_desarrolladores -p "$contra_de_usuarios" $primer_usuario
sudo useradd -m -d "$home_segundo_usuario" -s /bin/bash -c "Usuario Prog2" -G $grupo_desarrolladores -p "$contra_de_usuarios" $segundo_usuario
sudo useradd -m -d "$home_tercer_usuario" -s /bin/bash -c "Tester" -G $grupo_testers -p "$contra_de_usuarios" $tercer_usuario
sudo useradd -m -d "$home_cuarto_usuario" -s /bin/bash -c "Supervisor" -G $grupo_supervisores -p "$contra_de_usuarios" $cuarto_usuario
ls
cat GasparriniAltaUser-Groups.sh
cd ..
ls
cd home
cd vagrant/
ls
cd RTA_Examen_20241118/
ls
vim Punto_B.sh
STRING="2P_202406"
sudo grep "${STRING}" /etc/shadow
grep "${STRING}" /etc/passwd
cat /etc/group | grep "2P"
ls -l /work/
vim Punto_B.sh
cat Punto_A.sh 
cat Punto_B.sh
history -a
PATH_DE_TRABAJO_DOCKER="/home/vagrant/repogit/UTN-FRA_SO_Examenes/202406/docker"
cd $PATH_DE_TRABAJO_DOCKER
ls
cat <<EOF > dockerfile
FROM nginx:latest
COPY index.html /usr/share/nginx/html/index.html
EOF

ls
cat dockerfile
docker build -t facungv/web1-gasparrini:latest .
docker login -u facungv
docker build -t facungv/web1-gasparrini:latest .
df -h
docker container prune -f
docker image prune -a -f
docker volume prune -f
docker network prune -f
df -h
docker system df
docker image ls
vgdisplay vg_datos
sudo vgdisplay vg_datos
sudo lvextend -l +10 /dev/mapper/vg_datos-lv_docker
sudo lvextend -l +5 /dev/mapper/vg_datos-lv_docker
sudo resize2fs /dev/mapper/vg_datos-lv_docker
df -h /var/lib/docker
docker build -t facungv/web1-gasparrini:latest .
ls
touch run.sh
ls -la
sudo chmod 777 run.sh
ls -la
vim run.sh
cd ..
cd .
cd ..
ls
cd ..
ls
cd RTA_Examen_20241118/
ls
vim Punto_C.sh
cd ..
ls
cd UTNFRA_SO_2do_Parcial_GASPARRINI/
ls
cp -r RTA_Examen_20241118 ./UTNFRA_SO_2do_Parcial_GASPARRINI/
cp -r /home/vagrant/RTA_Examen_20241118 ./UTNFRA_SO_2do_Parcial_GASPARRINI/
ls
cd ..
ls
cd UTNFRA_SO_2do_Parcial_GASPARRINI/
ls
rm -r UTNFRA_SO_2do_Parcial_GASPARRINI/
ls
cp -r /home/vagrant/RTA_Examen_20241118 .
ls
cp -r /home/vagrant/repogit/UTN-FRA_SO_Examenes/202406 .
ls
history -a
git add .
git commit "puntos a,b,c"
git commit -m "puntos a,b,c"
git config --global user.email "facu_nicogas@outlook.com"
git config --global user.name "facungv"
git config --global user.name "facuNGV"
git commit -m "puntos a,b,c"
git push origin main
cd ..
ls
rm -r UTNFRA_SO_2do_Parcial_GASPARRINI/
ls
sudo rm -r UTNFRA_SO_2do_Parcial_GASPARRINI/
ls
exit
primer_usuario=$(grep Prog1 $path_lista_usuarios | awk -F ',' '{print $1}')
segundo_usuario=$(grep Prog2 $path_lista_usuarios | awk -F ',' '{print $1}')
tercer_usuario=$(grep Test1 $path_lista_usuarios | awk -F ',' '{print $1}')
cuarto_usuario=$(grep Supervisor $path_lista_usuarios | awk -F ',' '{print $1}')
ls
cd repogit/
ls
cd UTN-FRA_SO_Examenes/
ls
cd 202406
ls
cd ansible/
ls
ssh-keygen -t ed25519
cat $HOME/.ssh/id_ed25519.pub >> $HOME/.ssh/authorized_keys
cat $HOME/.ssh/id_ed25519.pub
ssh -T git@github.com
ls
cd inventory/
ls
cat host
cat hosts
ls
cd host_vars/
ls
cat 127.0.0.1.yml 
cat localhost.yml 
ls
cd ..
ls
cd group_vars/
ls
cat produccion.yml 
cat testing.yml 
ls
cd ..
ls
cd role
cd roles/
ls
nombre_rol="2do_parcial"
echo "$nombre_rol"
cd ..
ls
vim playbook.yml 
cd roles/
echo "$nombre_rol"
ls -la
cd ..
ls -la
sudo chmod 666 playbook.yml 
ls -la
vim playbook.yml 
ls
cd roles/
ls
cd 2do_parcial/
ls
cd t
cd tasks
ls
ls -la
sudo chmod 666 main.yml 
ls -la
vim main.yml 
ls -la
cd ..
ls
mkdir templates
ls
cd tasks/
ls
vim main.yml 
ls
cd ..
ls
cd templates/
ls
touch datos_alumno.j2
touch datos_equipo.j2
ls -la
sudo chmod 666 datos_alumno.j2 datos_equipo.j2 
ls -la
vim datos_alumno.j2 
vim datos_equipo.j2 
vim datos_alumno.j2 
cd ..
ls
cd tasks/
ls
vim main.yml 
cd ..
ls
cd templates/
ls
vim datos_alumno.j2 
cd ..
ls
history -a
cd ..
ls
cd ..
ls
cd RTA_Examen_20241118/
ls
cat Punto_C.sh 
cat Punto_D.sh 
ls
vim Punto_D.sh 
ls
vim Punto_D.sh 
cd ..
ls
cd repogit/
ls
cd UTN-FRA_SO_Examenes/
ls
cd 202406
pwd
ls
cd ansible/
ls
cd roles/
ls
cd 2do_parcial/
ls
cd templates/
ls
cat datos_alumno.j2 
cat datos_equipo.j2 
cd ..
cd.. 
cd ..
ls
git clone git@github.com:facuNGV/UTNFRA_SO_2do_Parcial_GASPARRINI.git
ls
cd UTNFRA_SO_2do_Parcial_GASPARRINI/
ls
history -a $HOME/.bash_history
cp -r /home/vagrant/repogit/UTN-FRA_SO_Examenes/202406/ /home/vagrant/UTNFRA_SO_2do_Parcial_GASPARRINI/
ls
cp -r /home/vagrant/RTA_Examen_20241118/ /home/vagrant/UTNFRA_SO_2do_Parcial_GASPARRINI/
ls
