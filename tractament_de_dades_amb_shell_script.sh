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
		sc)
			echo "Introduce el nombre de un país:"
			read pais
			if grep -q "$pais" cities.csv; then
				cut -d',' -f7,8 cities.csv > pais.csv
				codi_p="$(grep "$pais" pais.csv | cut -d',' -f1 | uniq)"
				echo "$codi_p"
			elif [ -z "$pais" ]; then
				echo "Opción no válida"
			else
				codi_p='XX'
				echo "$codi_p"
			fi
			;;
	
 
