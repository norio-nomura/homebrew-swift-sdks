cask "swiftwasm-sdk" do
  version "6.4.0"
  sha256 "f07b7be3c586d92d7a07051fc6d303b87ebea67eadc40640ba59d5a8b79aa86d"

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
