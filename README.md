# homebrew-maestro

Dépôt de distribution de **Maestro** (poste de pilotage pour agents de code) et de **Tactus** (son compagnon macOS, l'Île).

Le code source de Maestro vit dans un dépôt privé. Ce dépôt public ne contient que les recettes d'installation et les binaires publiés dans ses *releases*.

## Installation (macOS)

```sh
brew tap leozerbib/maestro
brew install --cask maestro
brew install --cask tactus
```

Les applications ne sont pas signées par un compte Apple Developer : macOS affiche un avertissement au premier lancement. La marche à suivre est donnée à l'installation.

## Organisation

| Chemin | Contenu |
|---|---|
| `Casks/maestro.rb` | l'application Maestro (Electron) |
| `Casks/tactus.rb` | le compagnon Tactus (Swift) |
| *Releases* | les archives de chaque version, une release par application et par version (`maestro-vX.Y.Z`, `tactus-vX.Y.Z`) |

Windows (winget) viendra plus tard, depuis ce même dépôt de distribution.

---

*Distribution repository for Maestro and its macOS companion Tactus. Install with `brew tap leozerbib/maestro`.*
