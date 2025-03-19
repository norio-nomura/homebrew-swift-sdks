cask "swiftwasm-sdk@development-snapshot" do
  version "2025-03-17-a"
  sha256 "2a8a1faed05b7d5b4e8b5b489261d950bb06e5e0f6ce1713733acd6d71701c6b"

  release_name="swift-wasm-DEVELOPMENT-SNAPSHOT-#{version}"
  artifactbundle_name="#{release_name}-wasm32-unknown-wasi.artifactbundle"

  url "https://github.com/swiftwasm/swift/releases/download/#{release_name}/#{artifactbundle_name}.zip",
      verified: "github.com/swiftwasm/swift/"
  name "Swift SDK for WebAssembly DEVELOPMENT-SNAPSHOT"
  desc "Swift SDK for WebAssembly"
  homepage "https://swiftwasm.org/"

  livecheck do
    url :url
    regex(/^swift-wasm-DEVELOPMENT-SNAPSHOT-(\d+-\d+-\d+-a)$/)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        match[1]
      end
    end
  end

  artifact artifactbundle_name.to_s, target: "~/Library/org.swift.swiftpm/swift-sdks/#{artifactbundle_name}"
end
