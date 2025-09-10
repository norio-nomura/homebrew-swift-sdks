cask "static-linux-sdk@development-snapshot" do
  version "2025-09-07-a"
  sha256 "81a71e1357c444b845a37ad34f63a6585a9036ad184ae0c940e40b7286e8aa5b"

  release_name="swift-DEVELOPMENT-SNAPSHOT-#{version}"
  artifactbundle_name="#{release_name}_static-linux-0.0.1.artifactbundle"
  webroot="development"

  url "https://download.swift.org/#{webroot}/static-sdk/#{release_name}/#{artifactbundle_name}.tar.gz"
  name "Swift Static Linux SDK"
  desc "Swift Static Linux SDK for Development Snapshot"
  homepage "https://www.swift.org/"

  livecheck do
    url "https://github.com/swiftlang/swift-org-website/raw/refs/heads/main/_data/builds/#{webroot.tr(".", "_")}/static_sdk.yml"
    regex(/swift-(\d+\.\d+-)?DEVELOPMENT-SNAPSHOT-(\d+-\d+-\d+-a)/)
    strategy :yaml do |yaml, regex|
      yaml.select { |item| item["dir"]&.match?(regex) }
          .map { |item| item["dir"][regex, 2] }
    end
  end

  artifact artifactbundle_name.to_s, target: "~/Library/org.swift.swiftpm/swift-sdks/#{artifactbundle_name}"
end
