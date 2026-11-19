cask "maestro" do
  version "0.2.0"
  sha256 "0abbd89c863c6093098433fb3fe92c677232e6bee80262365a7351000dee0233"

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
    Maestro n'est pas signé par un compte Apple Developer : macOS bloque le premier
    lancement. Pour l'ouvrir : lancez Maestro une fois (il sera refusé), puis
    Réglages Système > Confidentialité et sécurité > Sécurité > « Ouvrir quand même »
    (le bouton reste disponible environ une heure), puis entrez votre mot de passe.
    Au premier lancement, macOS peut demander l'accès au trousseau
    (« Maestro Safe Storage ») : acceptez, sinon aucun terminal ne s'affiche.

    Maestro is not signed with an Apple Developer account. Launch it once (it will be
    blocked), then System Settings > Privacy & Security > Security > "Open Anyway".
  EOS
end
