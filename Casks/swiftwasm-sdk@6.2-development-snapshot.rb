cask "swiftwasm-sdk@6.2-development-snapshot" do
  version "2025-07-09-a"
  sha256 "a26426852195f876f94e56d7819d94090de12fcfe158c8d53d5453f9467f7190"

  release_name="swift-6.2-DEVELOPMENT-SNAPSHOT-#{version}"
  artifactbundle_name="#{release_name}_wasm.artifactbundle"
  webroot="swift-6.2-branch"

  url "https://download.swift.org/#{webroot}/wasm-sdk/#{release_name}/#{artifactbundle_name}.tar.gz"
  name "Swift Wasm SDK 6.2 Development Snapshot"
  desc "Swift Wasm SDK 6.2 Development Snapshot"
  homepage "https://www.swift.org/"

  livecheck do
    url "https://github.com/swiftlang/swift-org-website/raw/refs/heads/main/_data/builds/#{webroot.tr(".", "_")}/wasm-sdk.yml"
    regex(/swift-(\d+\.\d+-)?DEVELOPMENT-SNAPSHOT-(\d+-\d+-\d+-a)/)
    strategy :yaml do |yaml, regex|
      yaml.select { |item| item["dir"]&.match?(regex) }
          .map { |item| item["dir"][regex, 2] }
    end
  end

  artifact artifactbundle_name.to_s, target: "~/Library/org.swift.swiftpm/swift-sdks/#{artifactbundle_name}"
end
