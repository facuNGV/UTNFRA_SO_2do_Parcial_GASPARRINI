#!/bin/bash
# me muevo al directorio que pide la consigna
cd /usr/local/bin
# creo el script
sudo touch GasparriniAltaUser-Groups.sh
# lo hago ejecutable
sudo chmod 777 GasparriniAltaUser-Groups.sh
# le doy una contraseña a mi usuario
sudo passwd vagrant
pepe
pepe
# edito el script
# vim GasparriniAltaUser-Groups.sh


#---------------------------------------------------------------------------------------------------------------------------------#

# Dentro de vim coloco el siguiente BashScript que resuelve el punto: 


#!/bin/bash
# Parámetro 1: Usuario de referencia (del cual se obtiene la clave) 
usuario_ref=$1 
# Parámetro 2: Ruta al archivo Lista_Usuarios
# /home/vagrant/repogit/UTN-FRA_SO_Examenes/202406/bash_script/Lista_Usuarios.txt
path_lista_usuarios=$2 

# Obtengo la contraseña del usuario pasado por primer parámetro
contra_de_usuarios=$(sudo grep "$usuario_ref" /etc/shadow | awk -F ':' '{print $2}')

# Obtengo los Usuarios del archivo
primer_usuario=$(grep Prog1 $path_lista_usuarios | awk -F ',' '{print $1}')
segundo_usuario=$(grep Prog2 $path_lista_usuarios | awk -F ',' '{print $1}')
tercer_usuario=$(grep Test1 $path_lista_usuarios | awk -F ',' '{print $1}')
cuarto_usuario=$(grep Supervisor $path_lista_usuarios | awk -F ',' '{print $1}')

# Obtengo los grupos del archivo
grupo_desarrolladores=$(grep Prog1 $path_lista_usuarios | awk -F ',' '{print $2}')
grupo_testers=$(grep Test1 $path_lista_usuarios | awk -F ',' '{print $2}')
grupo_supervisores=$(grep Supervisor $path_lista_usuarios | awk -F ',' '{print $2}')

# Obtengo los directorios home del archivo
home_primer_usuario=$(grep Prog1 $path_lista_usuarios | awk -F ',' '{print $3}')
home_segundo_usuario=$(grep Prog2 $path_lista_usuarios | awk -F ',' '{print $3}')
home_tercer_usuario=$(grep Test1 $path_lista_usuarios | awk -F ',' '{print $3}')
home_cuarto_usuario=$(grep Supervisor $path_lista_usuarios | awk -F ',' '{print $3}')

# Creación de grupos
sudo groupadd $grupo_desarrolladores
sudo groupadd $grupo_testers
sudo groupadd $grupo_supervisores

# Creación de usuarios
sudo useradd -m -d "$home_primer_usuario" -s /bin/bash -c "Usuario Prog1" -G $grupo_desarrolladores -p "$contra_de_usuarios" $primer_usuario
sudo useradd -m -d "$home_segundo_usuario" -s /bin/bash -c "Usuario Prog2" -G $grupo_desarrolladores -p "$contra_de_usuarios" $segundo_usuario
sudo useradd -m -d "$home_tercer_usuario" -s /bin/bash -c "Tester" -G $grupo_testers -p "$contra_de_usuarios" $tercer_usuario
sudo useradd -m -d "$home_cuarto_usuario" -s /bin/bash -c "Supervisor" -G $grupo_supervisores -p "$contra_de_usuarios" $cuarto_usuario


#---------------------------------------------------------------------------------------------------------------------------------#


# Verifico las creaciones:
STRING="2P_202406"
reset
echo "Crea Grupos y Usuarios (con Hash del usuario pasado por parametro)"
echo
sudo grep "${STRING}" /etc/shadow
echo
grep "${STRING}" /etc/passwd
echo
cat /etc/group | grep "2P"
echo
ls -l /work/
echo
echo "Ver script: "
ls -l /usr/local/bin/
# ejecución del script parado sobre /usr/local/bin:
# ./GasparriniAltaUser-Groups.sh $(whoami) /home/vagrant/repogit/UTN-FRA_SO_Examenes/202406/bash_script/Lista_Usuarios.txt
