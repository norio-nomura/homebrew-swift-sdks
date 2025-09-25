cask "swiftwasm-sdk" do
  version "6.2"
  sha256 "fe4e8648309fce86ea522e9e0d1dc48e82df6ba6e5743dbf0c53db8429fb5224"

  release_name="swift-#{version}-RELEASE"
  artifactbundle_name="#{release_name}_wasm.artifactbundle"

  url "https://download.swift.org/#{release_name.downcase}/wasm/#{release_name}/#{artifactbundle_name}.tar.gz"
  name "Swift SDK for WebAssembly"
  desc "Swift SDK for WebAssembly"
  homepage "https://www.swift.org/"

  livecheck do
    url "https://github.com/swiftlang/swift-org-website/raw/refs/heads/main/_data/builds/swift_releases.yml"
    strategy :yaml do |yaml|
      yaml.reverse.find do |item|
        item["platforms"].any? { |platform| platform["platform"] == "wasm-sdk" }
      end["name"]
    end
  end

  artifact artifactbundle_name.to_s, target: "~/Library/org.swift.swiftpm/swift-sdks/#{artifactbundle_name}"
end
