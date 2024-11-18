# Correr el contenedor
echo "----------------------------------------------------------------------------------------------------------------"
echo "Levantando contenedor "
docker run -d -p 80:80 facungv/web1-gasparrini:latest
echo "Contenedor levantado"
echo
curl localhost:80
echo
echo "------------------------------------------------------------------------------------------------------------------"
