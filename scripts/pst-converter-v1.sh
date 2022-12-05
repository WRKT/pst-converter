#!/bin/bash

# Script banner
echo -e "\e[0;32m*****************************\e[0m"
echo -e "\e[0;32m     Convert PST to MBOX     \e[0m"
echo -e "\e[0;32m*****************************\e[0m"

# Création du dossier de destination pour la conversion
read -p "Entrez le nom du dossier de destination pour la conversion: " folder

mkdir $folder

echo -e "Conversion en cours ....."

# Conversion des fichiers PST par libpst
read -p "Entrez le nom de l'archive PST à convertir (sans l'extension .pst): " archive

readpst -u $archive -o $folder

# Renommer tous les sous-dossiers avec .sbd pour être compatible avec Thunderbird
find $folder -type d |tac |grep -v '^$folder$' |xargs -d '\n' -I{} mv {} {}.sbd

# Renommer les fichiers mbox à son dossier parent et le déplacer à la racine du dossier parent
find $folder.sbd -name mbox -type f |xargs -d '\n' -I{} echo '"{}" "{}"' |sed -e 's/\.sbd\/mbox"$/"/' |xargs -L 1 mv

# Remettre le nom du dossier de destination comme spécifié à la création
mv $folder.sbd $folder


echo -e "\e[0;32m Conversion terminé...!!\e[0m"


