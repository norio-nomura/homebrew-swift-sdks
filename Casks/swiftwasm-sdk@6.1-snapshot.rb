cask "swiftwasm-sdk@6.1-snapshot" do
  version "2025-05-16-a"
  sha256 "6c9fb5bb66f8b4296fbb143a76dcc45483d8f063d03c70b6887d5a220578c636"

  release_name="swift-wasm-6.1-SNAPSHOT-#{version}"
  artifactbundle_name="#{release_name}-wasm32-unknown-wasi.artifactbundle"

  url "https://github.com/swiftwasm/swift/releases/download/#{release_name}/#{artifactbundle_name}.zip",
      verified: "github.com/swiftwasm/swift/"
  name "Swift SDK for WebAssembly 6.1-SNAPSHOT"
  desc "Swift SDK for WebAssembly"
  homepage "https://swiftwasm.org/"

  livecheck do
    url :url
    regex(/^swift-wasm-6.1-SNAPSHOT-(\d+-\d+-\d+-a)$/)
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
