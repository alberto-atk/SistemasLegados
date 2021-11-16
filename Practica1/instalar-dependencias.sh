#!/bin/bash

libreria=$(ldconfig -p | grep libcob.so.4)

if [ -z "$libreria" ]
then
  echo "Falta la librería libcob4 para la ejecución del cajero."
  echo -e "Procediendo a instalar la librería libcob4.\n"
  
  sudo apt install libcob4 -y

  libreria=$(ldconfig -p | grep libcob.so.4)

  if [ -z "$libreria" ]
  then
    echo -e "Ha habido un error durante la instalación de la librería.\n"
    echo -e "Se intentará actualizar el repositorio de librerías.\n"
    sudo apt update -y
    sudo apt install libcob4 -y
    
    libreria=$(ldconfig -p | grep libcob.so.4)
    
    if [ -z "$libreria" ]
    then
      echo -e "\nError debido a una versión desactualizada del sistema operativo.\n"
      wget http://archive.ubuntu.com/ubuntu/pool/main/n/ncurses/libtinfo6_6.2-0ubuntu2_amd64.deb
      sudo dpkg -i libtinfo6_6.2-0ubuntu2_amd64.deb
      
      wget http://archive.ubuntu.com/ubuntu/pool/main/n/ncurses/libncursesw6_6.2-0ubuntu2_amd64.deb
      sudo dpkg -i libncursesw6_6.2-0ubuntu2_amd64.deb
      
      wget http://archive.ubuntu.com/ubuntu/pool/universe/g/gnucobol/libcob4_2.2-5_amd64.deb
      sudo dpkg -i libcob4_2.2-5_amd64.deb
      
      libreria=$(ldconfig -p | libcob.so.4)
      
      if [ -z "$libreria" ]
      then
        echo -e "\nLibrerías instaladas. Se puede ejecutar el cajero con \"./cajero\"\n"
      else
        echo -e "\nError no contemplado durante la instalación de las librerías.\n"
      fi
    fi
  else 
    echo -e "\nLibrerías instaladas. Se puede ejecutar el cajero con \"./cajero\"\n"
  fi
else
  echo -e "Todas las dependencias encontradas. Se puede ejecutar el cajero.\n"
fi
