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
		ecp)
			awk -F ',' -v pais="$pais" '$8 != pais {next} {print $2, $11}' cities.csv > $codi_p.csv
			;;
		lce)
			awk -F ',' -v pais="$pais" '$8 != pais {next} {print $2, $11}' cities.csv
			awk -F ',' '{print $2, $5, $11}' cities.csv > 1lce.csv
			cut -d' ' -f1,3 1lce.csv > lce.csv
			;;
		gwd)
			echo "Introduce el nombre de una población:"
			read poblacio
			nom_arxiu="$(awk -F ',' -v poblacio="$poblacio" '$2 != poblacio {next} {print $11}' cities.csv)"
			url="https://www.wikidata.org/wiki/SPECIAL:EntityData/$nom_arxiu.json"
			wget -0 "$nom_arxiu.json" "https://www.wikidata.org/wiki/SPECIAL:EntityData/$nom_arxiu.json"
			;;
		est)
			awk -F ',' '{
				countN += ( $9 > 0.0 )
				countS += ( $9 < 0.0 )
				countE += ( $10 > 0.0 )
				countO += ( $10 < 0.0 )
				countU += ( $9 == 0 ) && ( $10 == 0 )
				countW += ( $11 == "" )
			}
			END {
				printf "Nord %d Sud %d Est %d Oest %d No ubic %d No WDId %d\n", countN, countS, countE, countO, countU, countW
			}' cities.csv
			;;
		*)
			echo "Opción no reconocida"
			;;
	esac
	echo "Introduce una opción"
done
echo "Saliendo de la aplicación"
exit
						
	
 
