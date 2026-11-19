# Cask de Tactus pour le tap github.com/Leozerbib/homebrew-maestro (fichier Casks/tactus.rb).
cask "tactus" do
  version "0.1.0"
  sha256 "e9bb38a746852ce5cb700550a05ac65b6641dab8d982c260b6bb0011a972044f"

  url "https://github.com/Leozerbib/homebrew-maestro/releases/download/tactus-v#{version}/Tactus-#{version}.zip"
  name "Tactus"
  desc "Island at the top of the screen, companion of the Maestro agent cockpit"
  homepage "https://github.com/Leozerbib/homebrew-maestro"

  livecheck do
    url :url
    regex(/^tactus[._-]v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

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
