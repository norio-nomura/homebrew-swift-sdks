cask "swiftwasm-sdk@development-snapshot" do
  version "2026-01-31-a"
  sha256 "f6424fc0c1421fc7fddb5fddd2dfacd0e7fbb2485bee3789c2b4372a9ba0cf7f"

  release_name="swift-DEVELOPMENT-SNAPSHOT-#{version}"
  artifactbundle_name="#{release_name}_wasm.artifactbundle"
  webroot="development"

  url "https://download.swift.org/#{webroot}/wasm-sdk/#{release_name}/#{artifactbundle_name}.tar.gz"
  name "Swift Wasm SDK Development Snapshot"
  desc "Swift Wasm SDK Development Snapshot"
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
