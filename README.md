# Mon adaptation du pack d'icône Yaru d'Ubuntu pour GNOME "Vanilla"

## Description

Ce script permet d'adapter le pack d’icônes **Yaru** (utilisé par défaut dans Ubuntu) afin de mieux l'intégrer dans des environnements **GNOME** comme Debian, Fedora ou Arch Linux.

Il supprime certains éléments spécifiques à Ubuntu et adapte la configuration du thème pour une meilleure intégration avec Adwaita, le thème par défaut de GNOME.

L’objectif principal est d'obtenir un thème plus cohérent, neutre et compatible avec une expérience GNOME "Vanilla".

---

## Détails du traitement

* Copie du pack d’icônes Yaru vers le répertoire d'icônes de l'utilisateur courant `$HOME/.local/share/icons`
  * Si le dossier `$HOME/.local/share/icons/Yaru` existe déjà, le script s'arrête
  * Le dossier `icons` est automatiquement créé s'il n'existe pas
* Pour chaque variant Yaru (Yaru, Yaru-blue, Yaru-blue-dark, etc.)
  * Suppression des dossiers `scalable*`
  * Suppression du fichier de cache (`icon-theme.cache`)
  * Modification du fichier de thème (`index.theme`)
    * Remplacement de l'héritage `Humanity` par `Adwaita`
    * Nettoyage des références `scalable*/*`

---

## Structure

```bash
.
├── script.sh              # Script
├── 25.10.3/               # Pack d'icônes d'Ubuntu 25.10 (v3)
├── 26.04.3/               # Pack d'icônes d'Ubuntu 26.04 (v3)
├── 26.04.4/               # Pack d'icônes d'Ubuntu 26.04 (v4)
└── icons/                 # Dossier généré uniquement en mode --test
```

---

## Utilisation

```bash
./script.sh 26.04.4
./script.sh 26.04.4 --test
```

> Le 1er paramètre (obligatoire) doit être le nom du dossier contenant le pack d'icônes (présent dans le dossier courant). Avec le 2ème paramètre (facultatif) `--test` la copie du pack d'icônes se fait dans le dossier courant `./icons` pour test/analyse.

---

## Crédits

* [Projet Yaru (Ubuntu)](https://github.com/ubuntu/yaru)
