#!/bin/bash
CADENA='(("\w+( \w+)")|\w+)'
opcion='x'
codi_p='xx'
codi_e='xxx'
echo "Introduce una opción:"
while [ "$opcion" != 'q' ]; do
	read opcion
	case $opcion in
		q)
			echo "Saliendo de la aplicación"
			exit
			;;
		lp)
			cut -d',' -f7,8 cities.csv | column -s',' -t | uniq | head -3
			;;
	
 
