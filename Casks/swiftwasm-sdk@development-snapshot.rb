cask "swiftwasm-sdk@development-snapshot" do
  version "2025-06-03-a"
  sha256 "e01b9946d1372089dc57146e4b2e2329e5d374c36b57743950518c8bddc8d224"

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
