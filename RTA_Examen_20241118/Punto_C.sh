#!/bin/bash
PATH_DE_TRABAJO_DOCKER="/$HOME/UTNFRA_SO_2do_Parcial_GASPARRINI/202406/docker"
echo "-----------------------------------------------------------------------------------------------------------"
cd $PATH_DE_TRABAJO_DOCKER
# creo dockerfile
cat <<EOF > dockerfile
FROM nginx:latest
COPY index.html /usr/share/nginx/html/index.html
EOF
# me logueo
echo "Creando imagen de Docker… "
# Creo la imagen web1-gasparrini basada en nginx
docker build -t facungv/web1-gasparrini:latest .
# Pushear imagen 
docker push facungv/web1-gasparrini:latest
echo "Imagen creada…"
docker images
# creo el run.sh
# touch run.sh
sudo chmod 777 run.sh
./run.sh
echo "-------------------------------------------------------------------------------------------------------------"
# Indico donde correr el contenedor
echo " script que corre el contenedor disponible en el path: "
echo "$PATH_DE_TRABAJO_DOCKER"
echo
echo "-------------------------------------------------------------------------------------------------------------"
