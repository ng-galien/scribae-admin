# TODO LIST

## Première release

>Modifications pour le déploiement de la première release

### Git 

* Mettre à jour le preloader pour les fonction Git
* Plus de validation de statut

### Prototype

* Utilisation de rysnc pour le contenu static des prototypes

> rsync -av prototypes/default/ preview/test
> rsync -av prototypes/librairies/js  preview/test/assets/
> rsync -av prototypes/librairies/sass/  preview/test/_sass/
> rsync -av prototypes/librairies/css  preview/test/css/
> rsync -av prototypes/librairies/fonts/  preview/test/fonts/

* Scinder l'arborescence des prototype avec les librairies / modèées html
* Revoir entièrement le prototype par défaut avec
  1. Debug des objets liquid
  2. CSS
  3. Articles avec images



## Version ultérieure

* Passer les textes en objet de la DB avec plus de propriétés
* Implémenter les propriétés de présentation des images
* Implémenter le module carte
* Intégrer les prototypes
