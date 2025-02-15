cask "swiftwasm-sdk" do
  version "6.0.2"
  sha256 "6ffedb055cb9956395d9f435d03d53ebe9f6a8d45106b979d1b7f53358e1dcb4"

  release_name="swift-wasm-#{version}-RELEASE"
  artifactbundle_name="#{release_name}-wasm32-unknown-wasi.artifactbundle"

  url "https://github.com/swiftwasm/swift/releases/download/#{release_name}/#{artifactbundle_name}.zip",
      verified: "github.com/swiftwasm/swift/"
  name "Swift SDK for WebAssembly"
  desc "Swift SDK for WebAssembly"
  homepage "https://swiftwasm.org/"

  livecheck do
    url :url
    regex(/^swift-wasm-(\d+\.\d+(\.\d+)?)-RELEASE$/)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"] || release["prerelease"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        match[1]
      end
    end
  end

  artifact artifactbundle_name.to_s, target: "~/Library/org.swift.swiftpm/swift-sdks/#{artifactbundle_name}"
end
