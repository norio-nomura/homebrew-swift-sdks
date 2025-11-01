cask "static-linux-sdk@6.2-development-snapshot" do
  version "2025-10-28-a"
  sha256 "05bbe600f7302b8dfa108054f93e854f8ff3296995377147c05fce9e613d9225"

  release_name="swift-6.2-DEVELOPMENT-SNAPSHOT-#{version}"
  artifactbundle_name="#{release_name}_static-linux-0.0.1.artifactbundle"
  webroot="swift-6.2-branch"

  url "https://download.swift.org/#{webroot}/static-sdk/#{release_name}/#{artifactbundle_name}.tar.gz"
  name "Swift Static Linux SDK"
  desc "Swift Static Linux SDK for 6.2 Development Snapshot"
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
