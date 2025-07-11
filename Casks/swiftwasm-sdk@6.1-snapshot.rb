cask "swiftwasm-sdk@6.1-snapshot" do
  version "2025-05-28-a"
  sha256 "3892f8eb59e8465d947f618b99953c09552b7bf5dd3fa6c7f93a4989b308b6ec"

  release_name="swift-wasm-6.1-SNAPSHOT-#{version}"
  artifactbundle_name="#{release_name}-wasm32-unknown-wasi.artifactbundle"

  url "https://github.com/swiftwasm/swift/releases/download/#{release_name}/#{artifactbundle_name}.zip",
      verified: "github.com/swiftwasm/swift/"
  name "Swift SDK for WebAssembly 6.1-SNAPSHOT"
  desc "Swift SDK for WebAssembly 6.1-SNAPSHOT"
  homepage "https://swiftwasm.org/"

  livecheck do
    skip "No livecheck available for this version"
  end

  artifact artifactbundle_name.to_s, target: "~/Library/org.swift.swiftpm/swift-sdks/#{artifactbundle_name}"
end
