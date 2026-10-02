cask "vitrel" do
  version "0.3.0"
  sha256 "1669076490e898354666b67a1434d00999f626f0932634a8beccfd796540954a"

  url "https://vitrel.app/download/Vitrel-#{version}.dmg"
  name "Vitrel"
  desc "Minimal web browser built on WebKit"
  homepage "https://vitrel.app/"

  livecheck do
    url "https://api.vitrel.app/v1/update.json"
    strategy :json do |json|
      JSON.parse(json["payload"].unpack1("m"))["version"]
    end
  end

  auto_updates true
  depends_on macos: :sequoia

  app "Vitrel.app"

  zap trash: [
    "~/Library/Application Support/Vitrel",
    "~/Library/Caches/dev.teralis.Vitrel*",
    "~/Library/Caches/Vitrel",
    "~/Library/HTTPStorages/dev.teralis.Vitrel*",
    "~/Library/Preferences/dev.teralis.Vitrel*.plist",
    "~/Library/Saved Application State/dev.teralis.Vitrel.savedState",
    "~/Library/WebKit/dev.teralis.Vitrel*",
  ]

  caveats <<~EOS
    Vitrel isn't signed with a Developer ID yet, so macOS blocks its first launch.
    Open it once, then choose Open Anyway in
      System Settings > Privacy & Security
  EOS
end
