# Cask de Tactus pour le tap github.com/Leozerbib/homebrew-maestro (fichier Casks/tactus.rb).
cask "tactus" do
  version "0.1.4"
  sha256 "206fdf17b6d5f12a2c313325bf5267cf47a70a2b35dbb98ebf326d837a21d2b3"

  url "https://github.com/Leozerbib/homebrew-maestro/releases/download/tactus-v#{version}/Tactus-#{version}.zip"
  name "Tactus"
  desc "Island at the top of the screen, companion of the Maestro agent cockpit"
  homepage "https://github.com/Leozerbib/homebrew-maestro"

  livecheck do
    url :url
    regex(/^tactus[._-]v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  conflicts_with cask: ["tactus@beta", "tactus@dev"]
  depends_on macos: :sonoma

  app "Tactus.app"

  uninstall quit: "dev.maestro.tactus"

  zap trash: [
    "~/Library/Application Support/Tactus",
    "~/Library/Logs/Tactus",
    "~/Library/Preferences/dev.maestro.tactus.plist",
  ]

  caveats <<~EOS
    Tactus n'est pas signé par un compte Apple Developer : macOS refuse de l'ouvrir.
    Si tu fais confiance à cette archive, lève la quarantaine de cette version, une fois :
      xattr -dr com.apple.quarantine "#{appdir}/Tactus.app"
    ou lance-le une fois, puis Réglages Système > Confidentialité et sécurité >
    « Ouvrir quand même ». Sur un Mac géré, si un outil de l'entreprise le bloque,
    passe par l'IT : ne contourne rien.
    Mac sans droits admin : installe dans ton dossier d'apps,
      brew install --cask --appdir=~/Applications leozerbib/maestro/tactus
    Après une mise à jour, macOS peut redemander les autorisations données
    (agenda, micro, accessibilité).

    Tactus is not signed with an Apple Developer account, so macOS blocks it. If you
    trust this archive, clear the quarantine once:
      xattr -dr com.apple.quarantine "#{appdir}/Tactus.app"
    or use System Settings > Privacy & Security > "Open Anyway".
    Without admin rights, install with --appdir=~/Applications.
  EOS
end
