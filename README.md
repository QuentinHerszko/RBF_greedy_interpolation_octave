# Interpolation en fonction de base radiale, méthode goutonne (en cours de réalisation)

Version un peu plus avancée de l'interpolation en fonction de base radiale, elle utilise la méthode goutonne.
__Principe__ : Sur chaque itération jusqu'à connvergence, on va chercher les points d'interpolation les moins bien approximés pour interpoler sur ces nouveaux points, tout en cherchant le paramètre de forme optimal de la fonction de base radiale afin d'obtenir la meilleur interpolation possible.

## Utilisation

* Cliquer sur le bouton `Code` puis sur le bouton `Download ZIP` pour télécharger les codes
* Déziper le fichier compressé
* Éxécuter le fichier `Valid1D.m` sous Octave pour réaliser une interpolation

## Modifier les données de base

### Modifier la fonction à interpoler

Retirer le commentaire `%` davant la fonction que vous voulez interpoler dans la section `% --- Target function` dans le script `Valid1D.m`.
Vous pouvez aussi proposer vos propres fonctions à condition que celles-ci soit réfinies en 1D et quelles soient continues.

### Modifier l'intervalle de l'interpolation

Dans la section `% --- Set interval`:
* Pour modifier la borne inférieure : modifier `mu_min`
* Pour modifier la borne supérieure : modifier `mu_max`
* Nombre de points d'interpolations : modifier `mu_n` (nombre entier)

## Fonctions

| Nom | Description |
| --- | --- |
| ppi() | Ajoute le dernier points d'interpoaltion le moins bien approximé |
| RadialKernel() | Créer la fonction de base radiale à partir d'un paramètre de forme |
| rbf_coef() | Retourne les poids de l'interpolation, les paramètres de formes relatif à chaque points d'interpolation et la liste des points qui on été interpolé |
| rbf_val() | Approximation de la fonction à interpoler |
| recherche_mup() | Voisins du dernier mu_tilde |
| recherche_poid() | Retourne les poids de l'interpolation |
| recherche_sig_opt() | Paramètres de forme les plus optimaux pour chaque points d'interpolation |
