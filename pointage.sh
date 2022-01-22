#!bin/bash
# pointage sur le site de la formation via curl
# analyses effectuées avec l 'outil burpsuite.


username="-------------------------------username---------------"   #mettre le mot de passe et le user entre les guillement
password="------------------------------password-------------------"


#1-------ouverture du site pour recuperer le cookie de session.
echo "lancement de la requet http"
curl -s -c .cookie.txt https://www.formation-occ.com/index.php > /dev/null

#2---------connection avec l'identifiant et recuperation du token

curl -s -b .cookie.txt -d "username=$username&password=$password" -c .cookie.txt  https://www.formation-occ.com/connexion.php > /dev/null

# cat cookie2.txt  

#3----------connection sur la platefrome pour voir si le nom s'affiche bien.
curl  --progress-bar -b .cookie.txt  https://www.formation-occ.com/index.php  > .checkname

name=$(grep "user_name" .checkname | cut -d'>' -f5 | cut -d'<' -f1 );
#echo $name
if [ -z "$name" ];then
   echo "login error"
else 
    
    echo "login succes as $name"
fi 
#grep "form_connexion form_required" ./.checkname 

#4--------------pointage et recherche du mot

curl  --progress-bar -b .cookie.txt https://www.formation-occ.com/index.php\?event_attendance\=\&status\=0 > .checkname
point=$(grep "pointage" .checkname | cut -d'>' -f2 | cut -d'<' -f1);
#echo $point
if [ -z "$point" ];then
   echo "erreur de pointage la page n'a pas ete ouverte"
else 
    
    echo "$point"
fi 
#grep "form_connexion form_required" ./.checkname2

-----nettoyage des cookies
rm -f .checkname
rm -f .cookie.txt
