cask "swiftwasm-sdk@6.0" do
  version "6.0.3"
  sha256 "31d3585b06dd92de390bacc18527801480163188cd7473f492956b5e213a8618"

  release_name="swift-wasm-#{version}-RELEASE"
  artifactbundle_name="#{release_name}-wasm32-unknown-wasi.artifactbundle"

  url "https://github.com/swiftwasm/swift/releases/download/#{release_name}/#{artifactbundle_name}.zip",
      verified: "github.com/swiftwasm/swift/"
  name "Swift SDK for WebAssembly 6.0"
  desc "Swift SDK for WebAssembly 6.0"
  homepage "https://swiftwasm.org/"

  livecheck do
    skip "No livecheck available for this version"
  end

  artifact artifactbundle_name.to_s, target: "~/Library/org.swift.swiftpm/swift-sdks/#{artifactbundle_name}"
end
