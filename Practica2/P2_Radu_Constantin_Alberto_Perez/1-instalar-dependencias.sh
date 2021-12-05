#!/bin/bash

libreria=$(sudo dpkg -l | grep libc6-i386)

if [ -z "$libreria" ]
then
  echo "Falta la librería libc6-i386 para la ejecución del programa."
  echo -e "Procediendo a instalar la librería libc6-i386.\n"
  
  sudo apt install libc6-i386 -y

  libreria_instaladas=$(sudo dpkg -l | grep libc6-i386)

  if [ -z "$libreria_instaladas" ]
  then
    echo -e "Ha habido un error durante la instalación de la librería.\n"
    echo -e "Se intentará actualizar el repositorio de librerías.\n"

    sudo apt update -y
    sudo apt install libc6-i386 -y
    
    libreria_libcob=$(sudo dpkg -l | grep libc6-i386)
    
    if [ -z "$libreria_libc6" ]
    then
      echo -e "\nError debido a una versión desactualizada del sistema operativo.\n"

      wget http://archive.ubuntu.com/ubuntu/pool/main/g/glibc/libc6-i386_2.34-0ubuntu3_amd64.deb
      sudo dpkg -i libc6-i386_2.34-0ubuntu3_amd64.deb
      
      librerias=$(sudo dpkg -l | grep libc6-i386)
      
      if [ -z "$librerias" ]
      then
        echo -e "\nLibrerías instaladas. Se puede ejecutar el programa legado1.\n"
      else
        echo -e "\nError no contemplado durante la instalación de las librerías.\n"
      fi
    fi
  else 
    echo -e "\nLibrerías instaladas. Se puede ejecutar el programa legado1.\n"
  fi
else
  echo -e "Todas las dependencias encontradas.Se puede ejecutar el programa legado1.\n"
fi
