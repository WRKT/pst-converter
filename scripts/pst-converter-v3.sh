#!/bin/bash

# Script banner
echo -e "\e[0;32m*****************************\e[0m"
echo -e "\e[0;32m     Convert PST to MBOX     \e[0m"
echo -e "\e[0;32m*****************************\e[0m"


echo -e "Conversion en cours ....."
convert(){
	for pst in `ls -1 in/`
	do
		# Conversion du fichier pst
		readpst -u -o out in/$pst
	
		# Renommer le contenu pour correspondre au format demandé apr Thunderbird
		find out -type d |tac |grep -v '^out$' |xargs -d '\n' -I{} mv {} {}.sbd
	
		# Renommer fichier mbox pour correspondre à son dossier parent
		find out -name mbox -type f |xargs -d '\n' -I{} echo '"{}" "{}"' |sed -e 's/\.sbd\/mbox"$/"/' |xargs -L 1 mv
	done
}

rename(){
	for folder in `ls -1 out/`
	do
		for i in `ls -1 in`
		do
			newname=$(echo $i |sed 's/....$//')
			mv $folder $newname
		done
	done
}

convert
rename

		

echo -e "\e[0;32m Conversion terminé...!!\e[0m"


