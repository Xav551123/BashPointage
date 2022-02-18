#!bin/bash
# pointage sur le site de la formation via curl
# analyses effectuées avec l 'outil burpsuite.


username="-------------------------------username---------------"   #mettre le mot de passe et le user entre les guillement
password="------------------------------password-------------------"
jour=$(date '+%d/%m/%Y %H:%M:%S')

#1-------ouverture du site pour recuperer le cookie de session.
echo $jour': lancement de la requet http' >> log.txt
curl -s -c .cookie.txt https://www.formation-occ.com/index.php > /dev/null

#2---------connection avec l'identifiant et recuperation du token

curl -s -b .cookie.txt -d "username=$username&password=$password" -c .cookie.txt  https://www.formation-occ.com/connexion.php > /dev/null

# cat cookie2.txt  

#3----------connection sur la platefrome pour voir si le nom s'affiche bien.
curl  --progress-bar -b .cookie.txt  https://www.formation-occ.com/index.php  > .checkname

name=$(grep "user_name" .checkname | cut -d'>' -f5 | cut -d'<' -f1 );
#echo $name
if [ -z "$name" ];then
   echo "login error" >> log.txt
else 
    
    echo "login succes as $name" >> log.txt
fi 
#grep "form_connexion form_required" ./.checkname 

#4--------------pointage et recherche du mot

curl -L --progress-bar -b .cookie.txt "https://www.formation-occ.com/insert_attendance_event.php" > .checkname
point=$(grep "pointage" .checkname | cut -d'>' -f2 | cut -d'<' -f1);
#echo $point
if [ -z "$point" ];then
   echo "erreur de pointage la page n'a pas ete ouverte" >> log.txt
else 
    
    echo "$point" >> log.txt
fi 
#grep "form_connexion form_required" ./.checkname2
echo -e "\n" >> log.txt
#-----nettoyage des cookies
rm -f .checkname
rm -f .cookie.txt
