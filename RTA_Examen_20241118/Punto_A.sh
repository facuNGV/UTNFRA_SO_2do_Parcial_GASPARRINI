#!/bin/bash
PATH_DISCO_PARTICIONAR1=$(lsblk | grep 1G | head -n 1 | awk '{print "/dev/"$1}')
echo "Particionando disco de 1GB"
sudo fdisk $PATH_DISCO_PARTICIONAR1 << EOF
n
p
1
2048
+700M
w
EOF
echo "Partición realizada con éxito"
echo "--------------------------------------------------------------------------------------------------------------------"
PATH_DISCO_PARTICIONAR2=$(lsblk | grep 2G | head -n 1 | awk '{print "/dev/"$1}')
echo "Particionando disco de 2GB"
sudo fdisk $PATH_DISCO_PARTICIONAR2 << EOF
n
p
1
2048
+1.530G
t
1
8E
w
EOF
echo "Partición realizada con éxito"
echo "--------------------------------------------------------------------------------------------------------------------"
# Configurar LVM:
# Obtengo el PATH de las dos particiones
# Partición de 700MB
PATH_PARTICION_TEMP="${PATH_DISCO_PARTICIONAR1}1"
# Partición de 1.5GB
PATH_PARTICION_DATOS="${PATH_DISCO_PARTICIONAR2}1"
# Limpio de basura las particiones
sudo wipefs -a $PATH_PARTICION_DATOS $PATH_PARTICION_TEMP
# Crear Physical Volumes (PVs):
sudo pvcreate $PATH_PARTICION_DATOS $PATH_PARTICION_TEMP
# Crear Volume Groups (VGs):
sudo vgcreate vg_temp $PATH_PARTICION_TEMP
sudo vgcreate vg_datos $PATH_PARTICION_DATOS
# Crear Logical Volumes (LVs):
# No me deja asignarle 5M, le asigna 8M automaticamente
sudo lvcreate -L 5M -n lv_docker vg_datos
sudo lvcreate -L 1.5G -n lv_workareas vg_datos
sudo lvcreate -L 512M -n lv_swap vg_temp

# Configurar Swap:
echo "----------------------------------------------------------------------------------------------------------------"
echo "Habilitando memoria Swap…”
PATH_LV_SWAP=$(sudo fdisk -l | grep swap | awk '{print $2}' | cut -d':' -f1)
sudo mkswap $PATH_LV_SWAP
sudo swapon $PATH_LV_SWAP
echo "Memoria Swap habilitada…”
free -h
echo "----------------------------------------------------------------------------------------------------------------"
# Carpeta para montaje de lv_workareas
sudo mkdir /work/
# Obtengo ubicaciones de los LVs
PATH_LV_DOCKER=$(sudo fdisk -l | grep lv_docker | awk '{print $2}' | cut -d':' -f1)
PATH_LV_WORKAREAS=$(sudo fdisk -l | grep workareas | awk '{print $2}' | cut -d':' -f1)
# Formatear los LVs de vg_datos
sudo mkfs.ext4 $PATH_LV_DOCKER
sudo mkfs.ext4 $PATH_LV_WORKAREAS
# Montar los LVs
sudo mount $PATH_LV_DOCKER /var/lib/docker/
sudo mount $PATH_LV_WORKAREAS /work/
# Restartear Docker luego del montaje
sudo systemctl restart docker
