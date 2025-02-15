cask "swiftwasm-sdk" do
  version "6.0.3"
  sha256 "31d3585b06dd92de390bacc18527801480163188cd7473f492956b5e213a8618"

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
