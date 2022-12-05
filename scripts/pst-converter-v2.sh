#!/bin/bash

# Script banner
echo -e "\e[0;32m*****************************\e[0m"
echo -e "\e[0;32m     Convert PST to MBOX     \e[0m"
echo -e "\e[0;32m*****************************\e[0m"


echo -e "Conversion en cours ....."

# Conversion des fichiers PST par libpst

readpst -u -o out in/*.pst

# Renommer tous les sous-dossiers avec .sbd pour être compatible avec Thunderbird
find out -type d |tac |grep -v '^out$' |xargs -d '\n' -I{} mv {} {}.sbd

# Renommer les fichiers mbox à son dossier parent et le déplacer à la racine du dossier parent
find out -name mbox -type f |xargs -d '\n' -I{} echo '"{}" "{}"' |sed -e 's/\.sbd\/mbox"$/"/' |xargs -L 1 mv

echo -e "\e[0;32m Conversion terminé...!!\e[0m"


