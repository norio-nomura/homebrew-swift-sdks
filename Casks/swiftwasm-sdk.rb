cask "swiftwasm-sdk" do
  version "6.3.3"
  sha256 "cabfa08b73bb8ac783927ecd15fa386e99d0c139c5f232445067bcf58379cae7"

  release_name="swift-#{version}-RELEASE"
  artifactbundle_name="#{release_name}_wasm.artifactbundle"

  url "https://download.swift.org/#{release_name.downcase}/wasm-sdk/#{release_name}/#{artifactbundle_name}.tar.gz"
  name "Swift SDK for WebAssembly"
  desc "Swift SDK for WebAssembly"
  homepage "https://www.swift.org/"

  livecheck do
    url "https://github.com/swiftlang/swift-org-website/raw/refs/heads/main/_data/builds/swift_releases.yml"
    strategy :yaml do |yaml|
      yaml.rfind do |item|
        item["platforms"].any? { |platform| platform["platform"] == "wasm-sdk" }
      end["name"]
    end
  end

  artifact artifactbundle_name.to_s, target: "~/Library/org.swift.swiftpm/swift-sdks/#{artifactbundle_name}"
end
