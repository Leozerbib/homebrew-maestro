cask "maestro" do
  version "0.3.0"
  sha256 "f245d7fe94f17c155f5b79123acfbdc75ef8faf6c9c20897076bced8f25d0282"

  url "https://github.com/Leozerbib/homebrew-maestro/releases/download/maestro-v#{version}/Maestro-#{version}-arm64.zip"
  name "Maestro"
  desc "Cockpit for coding agents (Claude Code, Codex, Gemini)"
  homepage "https://github.com/Leozerbib/homebrew-maestro"

  # Le tap porte aussi les releases `tactus-v…` : pas de :github_latest. Forme à confirmer par
  # `brew livecheck --cask` (lot B) ; sinon `url` + `regex` sur la page des releases.
  livecheck do
    url "https://github.com/Leozerbib/homebrew-maestro/releases"
    regex(/^maestro-v(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Maestro.app"

  # Seulement ce qui appartient à l'app Electron : jamais ~/.maestro (données du serveur).
  zap trash: [
    "~/Library/Application Support/Maestro",
    "~/Library/Caches/dev.maestro.app",
    "~/Library/Preferences/dev.maestro.app.plist",
    "~/Library/Saved Application State/dev.maestro.app.savedState",
  ]

  caveats <<~EOS
    Maestro n'est pas signé par un compte Apple Developer : macOS refuse de l'ouvrir.
    Si tu fais confiance à cette archive, lève la quarantaine de cette version, une fois :
      xattr -dr com.apple.quarantine "#{appdir}/Maestro.app"
    ou lance-le une fois, puis Réglages Système > Confidentialité et sécurité >
    « Ouvrir quand même ». Sur un Mac géré, si un outil de l'entreprise le bloque,
    passe par l'IT : ne contourne rien.
    Mac sans droits admin : installe dans ton dossier d'apps,
      brew install --cask --appdir=~/Applications leozerbib/maestro/maestro
    Au premier lancement, macOS peut demander l'accès au trousseau
    (« Maestro Safe Storage ») : accepte, sinon aucun terminal ne s'affiche.

    Maestro is not signed with an Apple Developer account, so macOS blocks it. If you
    trust this archive, clear the quarantine once:
      xattr -dr com.apple.quarantine "#{appdir}/Maestro.app"
    or use System Settings > Privacy & Security > "Open Anyway".
    Without admin rights, install with --appdir=~/Applications.
  EOS
end
