cask "swiftwasm-sdk@6.4.x-development-snapshot" do
  version "2026-07-16-a"
  sha256 "7866ef3db6d162b5b67cafb5de4ca7d43109f76948b9b79f33d9331ca927712a"

  release_name="swift-6.4.x-DEVELOPMENT-SNAPSHOT-#{version}"
  artifactbundle_name="#{release_name}_wasm.artifactbundle"
  webroot="swift-6.4.x-branch"

  url "https://download.swift.org/#{webroot}/wasm-sdk/#{release_name}/#{artifactbundle_name}.tar.gz"
  name "Swift Wasm SDK 6.4.x Development Snapshot"
  desc "Swift Wasm SDK 6.4.x Development Snapshot"
  homepage "https://www.swift.org/"

  livecheck do
    url "https://github.com/swiftlang/swift-org-website/raw/refs/heads/main/_data/builds/#{webroot.tr(".", "_")}/wasm-sdk.yml"
    regex(/swift-(\d+\.\d+\.x-)?DEVELOPMENT-SNAPSHOT-(\d+-\d+-\d+-a)/)
    strategy :yaml do |yaml, regex|
      yaml.select { |item| item["dir"]&.match?(regex) }
          .map { |item| item["dir"][regex, 2] }
    end
  end

  artifact artifactbundle_name.to_s, target: "~/Library/org.swift.swiftpm/swift-sdks/#{artifactbundle_name}"
end
