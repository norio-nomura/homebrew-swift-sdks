cask "swiftwasm-sdk" do
  version "6.2.2"
  sha256 "128fa003e0cad624897c2b1d5f07cedf400e3c8bd851d304e57440b591cbe606"

  release_name="swift-#{version}-RELEASE"
  artifactbundle_name="#{release_name}_wasm.artifactbundle"

  url "https://download.swift.org/#{release_name.downcase}/wasm-sdk/#{release_name}/#{artifactbundle_name}.tar.gz"
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
