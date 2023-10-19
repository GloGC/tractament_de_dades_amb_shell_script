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
		se)
			echo "Introduce el nombre de un estado:"
			read estado
			if grep -q "$estado" cities.csv; then
				cut -d',' -f4,5 cities.csv > estados.csv
				codi_e="$(grep "$estado" estados.csv | cut -d',' -f1 | uniq)"
				echo "$codi_e"
			elif [ -z "$estado" ]; then
				echo "$codi_p"
			else
				codi_e='XX'
				echo "$codi_e"
			fi
			;;
		le)
			cut -d',' -f4,5,8 cities.csv > paises.csv
			grep "$pais" paises.csv | cut -d',' -f1,2 | uniq
			;;
		lcp)
			awk -F ',' -v pais="$pais" '$8 != pais {next} {print $2, $11}' cities.csv
			;;
	
 
