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
    Tactus is not signed with an Apple Developer ID. On first launch, macOS blocks it:
    open System Settings > Privacy & Security, then click "Open Anyway" next to Tactus.
    After an update, macOS may ask again for the permissions you gave (calendar, microphone,
    accessibility).

    Tactus n'est pas signé par un compte Apple Developer. Au premier lancement, macOS le bloque :
    ouvrez Réglages Système > Confidentialité et sécurité, puis « Ouvrir quand même » face à Tactus.
    Après une mise à jour, macOS peut redemander les autorisations données (agenda, micro,
    accessibilité).
  EOS
end
