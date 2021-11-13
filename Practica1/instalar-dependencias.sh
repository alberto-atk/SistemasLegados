#!/bin/bash

libreria=$(dpkg -l | grep libcob)

if [ "$libreria" == "" ]
then
  echo "Falta la librería libcob4 para la ejecución del cajero."
  echo -e "Procediendo a instalar la librería libcob4.\n"
  
  sudo apt install libcob4 -y
  echo -e "\nLibrería instalada. Se puede ejecutar el cajero.\n"
else
  echo -e "Todas las dependencias encontradas. Se puede ejecutar el cajero.\n"
fi
