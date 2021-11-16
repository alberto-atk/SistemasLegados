#!/bin/bash

libreria=$(ldconfig -p | grep libcob)

if [ -z "$libreria" ]
then
  echo "Falta la librería libcob4 para la ejecución del cajero."
  echo -e "Procediendo a instalar la librería libcob4.\n"
  
  sudo apt install libcob4 -y

  libreria=$(ldconfig -p | grep libcob)

  if [ -z "$libreria" ]
  then
    echo -e "Ha habido un error durante la instalación de la librería.\n"
    echo -e "Se intentará actualizar el repositorio de librerías.\n"
    sudo apt update -y
    sudo apt install libcob4 -y
    
    libreria_libcob=$(ldconfig -p | grep libcob)
    
    if [ -z "$libreria_libcob" ]
    then 
      echo -e "\nLibrería instalada. Se puede ejecutar el cajero.\n"
    else
      echo -e "\nError no contemplado durante la instalación de la librería.\n"
    fi
  else 
    echo -e "\nLibrería instalada. Se puede ejecutar el cajero.\n"
  fi
else
  echo -e "Todas las dependencias encontradas. Se puede ejecutar el cajero.\n"
fi
