# homebrew-maestro

Dépôt de distribution de **Maestro**, le poste de pilotage pour agents de code (Claude Code, Codex, Gemini, OpenCode), et de **Tactus**, son compagnon macOS (l'Île).

Le code source de Maestro vit dans un dépôt privé. Ce dépôt public ne contient que les recettes d'installation (`Casks/`) et, dans ses *releases*, les archives publiées.

## Maestro

### Installer (Mac Apple Silicon, macOS 13 ou plus)

```sh
brew install --cask leozerbib/maestro/maestro
```

Utilise toujours le **nom complet** `leozerbib/maestro/maestro`. Depuis Homebrew 6, un tap tiers n'est pas approuvé d'office. Installer par le nom complet approuve ce cask en un seul geste. Si tu as déjà fait `brew tap leozerbib/maestro`, lance `brew trust --cask leozerbib/maestro/maestro`, puis `brew install --cask maestro`.

Les Mac Intel ne sont pas pris en charge pour l'instant.

### Premier lancement

Maestro n'est pas signé par un compte Apple Developer : l'app est signée *ad hoc* (`codesign -dv /Applications/Maestro.app` l'affiche). macOS bloque donc le premier lancement.

1. Ouvre Maestro une fois. macOS refuse de l'ouvrir.
2. Va dans **Réglages Système › Confidentialité et sécurité**. En bas, dans « Sécurité », clique sur **Ouvrir quand même**. Le bouton reste disponible environ une heure après la tentative.
3. Confirme avec ton mot de passe. Les lancements suivants sont normaux.
4. Au premier lancement, macOS peut demander l'accès au trousseau pour « Maestro Safe Storage » : accepte, sinon les terminaux ne s'affichent pas. La demande peut revenir après une mise à jour.

Autre voie, à n'utiliser que si tu fais confiance à l'archive : `xattr -dr com.apple.quarantine /Applications/Maestro.app` retire la quarantaine. Maestro ne le fait jamais à ta place.

### Vérifier une archive

Chaque release publie l'archive et sa somme SHA-256 :

```sh
shasum -a 256 -c Maestro-X.Y.Z-arm64.zip.sha256
```

Homebrew vérifie aussi la somme à l'installation.

### Mettre à jour

```sh
brew upgrade --cask leozerbib/maestro/maestro
```

À l'ouverture, au plus une fois par jour, Maestro demande à l'API publique de GitHub la dernière release de ce dépôt et affiche une notice si une version plus récente existe. La requête ne transmet que ton adresse IP et l'en-tête `User-Agent: maestro-desktop`, sans aucun jeton. Rien n'est téléchargé ni installé automatiquement. Pour couper l'avis : **Réglages › Général › Mises à jour**.

### Désinstaller

```sh
brew uninstall --cask maestro          # retire l'app
brew uninstall --cask --zap maestro    # retire aussi ses réglages
```

`--zap` supprime les dossiers de l'app dans `~/Library` (`Application Support/Maestro`, caches, préférences, état des fenêtres). Il **ne supprime jamais** `~/.maestro`, où le serveur garde tes données (conversations, mémoire), ni les dossiers de tes agents (`~/.claude`, `~/.codex`, `~/.gemini`). Ils restent à toi.

### Sans Homebrew

Télécharge `Maestro-X.Y.Z-arm64.zip` dans la [release `maestro-vX.Y.Z`](https://github.com/Leozerbib/homebrew-maestro/releases). Double-clique pour décompresser, glisse `Maestro.app` dans `/Applications`, puis suis les étapes du premier lancement.

## Tactus

Tactus est l'Île de Maestro : une bande en haut de l'écran, autour de l'encoche. Elle montre tes sessions d'agents, les décisions en attente, la musique, l'agenda, le presse-papiers et l'état du Mac. Elle marche seule ; reliée à Maestro sur le même Mac, elle prend son apparence et, une fois appairée, peut agir sur tes sessions.

### Installer (Mac Apple Silicon ou Intel, macOS 14 ou plus)

```sh
brew install --cask leozerbib/maestro/tactus
```

Comme pour Maestro, utilise le **nom complet** : il approuve ce cask en un seul geste. Pour se relier, Tactus demande **Maestro 0.2.0 ou plus**.

### Premier lancement

Tactus est signé *ad hoc*, comme Maestro : ouvre-le une fois, puis **Réglages Système › Confidentialité et sécurité › Ouvrir quand même**. Après une mise à jour, macOS peut redemander les autorisations déjà données (agenda, micro, accessibilité).

Tactus n'a pas d'icône dans le Dock : il vit dans l'Île et dans la barre des menus (Réglages…, Quitter).

### Relier Tactus à Maestro

1. Lance Maestro sur le même Mac. Tactus le trouve tout seul et suit son thème : il peut alors tout lire, rien changer.
2. Pour qu'il puisse agir (approuver, répondre, interrompre, compacter, écrire à une session), ouvre **Maestro › Réglages › Tactus**, crée un code, puis saisis-le dans **Tactus › Réglages › Maestro**.
3. Même appairée, Tactus n'approuve qu'une carte que tu as devant toi : la carte doit être ouverte et immobile un instant avant qu'Entrée ou un clic la valide. Aucun message d'agent ne vaut accord.

### Mettre à jour, désinstaller

```sh
brew upgrade --cask leozerbib/maestro/tactus
brew uninstall --cask tactus
brew uninstall --cask --zap tactus    # retire aussi ses réglages et journaux
```

`--zap` ne retire que `~/Library/Application Support/Tactus`, `~/Library/Logs/Tactus` et ses préférences. Le secret d'appairage reste au trousseau : oublie l'appairage dans les réglages de Tactus avant, ou révoque l'appareil dans Maestro.

## Organisation

| Chemin | Contenu |
|---|---|
| `Casks/maestro.rb` | l'application Maestro (Electron) |
| `Casks/tactus.rb` | le compagnon Tactus (Swift) |
| *Releases* | les archives, une release par application et par version (`maestro-vX.Y.Z`, `tactus-vX.Y.Z`) |

Windows (winget) viendra plus tard, depuis ce même dépôt.

---

## English

Distribution repository for **Maestro**, a cockpit for coding agents, and **Tactus**, its macOS companion. The source code is private; this public repository only holds the casks and the release archives.

- **Install** (Apple Silicon, macOS 13+): `brew install --cask leozerbib/maestro/maestro`. Use the fully qualified name: since Homebrew 6, it trusts the cask in one step.
- **First launch**: Maestro is ad hoc signed, not notarized. Open it once, then go to System Settings › Privacy & Security and click **Open Anyway**. The button stays available for about an hour. Allow the keychain prompt for "Maestro Safe Storage".
- **Update**: `brew upgrade --cask leozerbib/maestro/maestro`. At most once a day on launch, Maestro asks the public GitHub API for the latest release (no token, no data sent) and shows a notice. You can turn it off in Settings › General › Updates.
- **Uninstall**: `brew uninstall --cask --zap maestro`. This never removes `~/.maestro` (server data) or your agents' folders.
- **Tactus** (Apple Silicon or Intel, macOS 14+): `brew install --cask leozerbib/maestro/tactus`. The Island at the top of the screen; it works alone, and follows Maestro (0.2.0 or later) on the same Mac. To let it act on sessions, pair it with the code from Maestro › Settings › Tactus. Even paired, it only approves a card that is open in front of you. Ad hoc signed: use **Open Anyway** on first launch.
