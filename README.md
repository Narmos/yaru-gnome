# My adaptation of the Yaru icon pack from Ubuntu for "Vanilla" GNOME

This script adapts the **Yaru** icon pack (used by default in Ubuntu) for better integration into GNOME environments such as Debian, Fedora, or Arch Linux.

It removes certain Ubuntu-specific elements and adjusts the theme configuration for improved integration with Adwaita, the default GNOME theme.

The main goal is to achieve a more consistent, neutral theme compatible with a **"vanilla" GNOME** experience.

> ## French version:
> ### Mon adaptation du pack d'icônes Yaru d'Ubuntu pour GNOME "Vanilla"
> 
> Ce script adapte le pack d’icônes **Yaru** (utilisé par défaut dans Ubuntu) afin de mieux l'intégrer dans des environnements GNOME comme Debian, Fedora ou Arch Linux.
>
> Il supprime certains éléments spécifiques à Ubuntu et adapte la configuration du thème pour une meilleure intégration avec Adwaita, le thème par défaut de GNOME.
>
> L’objectif principal est d'obtenir un thème plus cohérent, neutre et compatible avec une expérience **GNOME "Vanilla"**.

---

## 🧪 Result

**Example on Debian with the original Yaru-blue-dark icon theme:**
[![screenshot without script](https://raw.githubusercontent.com/Narmos/yaru-gnome/refs/heads/master/.github/readme_img/Yaru-without-script.png)](https://raw.githubusercontent.com/Narmos/yaru-gnome/refs/heads/master/.github/readme_img/Yaru-without-script.png)

**Example on Debian with the adapted Yaru-blue-dark icon theme:**
[![screenshot with script](https://raw.githubusercontent.com/Narmos/yaru-gnome/refs/heads/master/.github/readme_img/Yaru-with-script.png)](https://raw.githubusercontent.com/Narmos/yaru-gnome/refs/heads/master/.github/readme_img/Yaru-with-script.png)

---

## 🔍 What the script does

* Copy the Yaru icon pack to the current user's icon directory `$HOME/.local/share/icons`
  * If the folder `$HOME/.local/share/icons/Yaru` already exists, the script stops.
  * The `icons` folder is automatically created if it doesn't exist.
* For each Yaru variant (Yaru, Yaru-blue, Yaru-blue-dark, etc.):
  * Delete the `scalable*` folders.
  * Delete the cache file `icon-theme.cache`.
  * Modify the theme file `index.theme`.
    * Replace the `Humanity` inheritance with `Adwaita`.
    * Clean up `scalable*/*` references.

---

## 📁 Structure

```bash
.
├── script.sh              # Script
├── 25.10.3/               # Included icon pack from Ubuntu 25.10 (v3) - old design
├── 26.04.3/               # Included icon pack from Ubuntu 26.04 (v3) - my favorite
├── 26.04.4/               # Included icon pack from Ubuntu 26.04 (v4) - new redesign
├── your_own_yaru/         # Your own Yaru icon pack retrieved from Ubuntu
└── icons/                 # Folder generated only in test mode
```

---

## 🚀 Usage

The script must not be run as administrator.

```bash
./script.sh 26.04.4
```
> [!IMPORTANT]
> The first parameter (required) must be the name of the folder containing the icon pack (located in the current directory).

### Test mode

```bash
./script.sh 26.04.4 --test
```
> [!NOTE]
> The second parameter (optional), `--test`, copies the icon pack to the current directory `./icons` for testing/analysis.

---

## 🙏 Credits

* [Yaru Project (Ubuntu)](https://github.com/ubuntu/yaru)
