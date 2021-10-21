# Calculatri'ECE-VHDL

### Bonjour et bienvenue dans mon projet Calculatri'ECE, il s'agit d'un projet proposé par l'ECE Paris aux étudiants de 2ème année du cycle préparatoire ingénieur de l'année scolaire 2021 - 2022.

*** 

Nous avons donc constitué une équipe de trois avec moi-même comme chef de projet. Notre mission consistait à développer une calculatrice sur le FPGA DE10-Lite de chez 
Terasic capable de recevoir des nombres saisit par une télécommande infrarouge et ensuite effectuer des calculs internes (FPGA) et externes (Additionneur 4-bit) pour 
enfin afficher nos deux opérandes et le résultat.
Vous retrouverez dans le dossier compressé notre compte rendu en format pdf "Calculatri'ECE" qui vous aidera à saisir toutes les fonctionnalités que nous avons mis en
place ainsi que les schémas de nos circuits électroniques.

---

Pour lancer le projet sur Quartus, double-cliquer sur "Calculatrice.qpf" et tout le projet se lancera.
Pour simplement voir les codes de chacun des fichiers .vhd vous retrouverez un dossier "VHD Files" :

  * _Calculatrice_Entity_ : Fichier principal gérant l'appel des différents sous-programmes de manière récursive
  *  -Nec_receiver- : Permet de recevoir le signal infrarouge 
  * _Conversion_signal_ : Pemert de convertir le signal infrarouge recu en une combinaison binaire
  * _Calcul_entity_ : C'est ici que seront implémenter les fonction de calculs de la calculatrice
  * _Affichage_entity_ : Affiche les deux opérandes ainsi que le résultat
  * _Buzzer_entity_ : Contrôle un buzzer pour emettre un signal sonore correspondant au résultat




En espérant que ce projet vous plaira ! 
