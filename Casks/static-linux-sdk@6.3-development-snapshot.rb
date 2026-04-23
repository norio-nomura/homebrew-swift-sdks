cask "static-linux-sdk@6.3-development-snapshot" do
  version "2026-04-21-a"
  sha256 "d6dd7fb3fdca00220cb810beddffa0b1c02bbdd0c4aaf97843ffb5885d14a9ba"

  release_name="swift-6.3-DEVELOPMENT-SNAPSHOT-#{version}"
  artifactbundle_name="#{release_name}_static-linux-0.1.0.artifactbundle"
  webroot="swift-6.3-branch"

  url "https://download.swift.org/#{webroot}/static-sdk/#{release_name}/#{artifactbundle_name}.tar.gz"
  name "Swift Static Linux SDK"
  desc "Swift Static Linux SDK for 6.3 Development Snapshot"
  homepage "https://www.swift.org/"

  livecheck do
    url "https://github.com/swiftlang/swift-org-website/raw/refs/heads/main/_data/builds/#{webroot.tr(".", "_")}/static-sdk.yml"
    regex(/swift-(\d+\.\d+-)?DEVELOPMENT-SNAPSHOT-(\d+-\d+-\d+-a)/)
    strategy :yaml do |yaml, regex|
      yaml.select { |item| item["dir"]&.match?(regex) }
          .map { |item| item["dir"][regex, 2] }
    end
  end

  artifact artifactbundle_name.to_s, target: "~/Library/org.swift.swiftpm/swift-sdks/#{artifactbundle_name}"
end
