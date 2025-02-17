cask "static-linux-sdk" do
  version "6.0.3"
  sha256 "67f765e0030e661a7450f7e4877cfe008db4f57f177d5a08a6e26fd661cdd0bd"

  release_name="swift-#{version}-RELEASE"
  artifactbundle_name="#{release_name}_static-linux-0.0.1.artifactbundle"

  url "https://download.swift.org/#{release_name.downcase}/static-sdk/#{release_name}/#{artifactbundle_name}.tar.gz"
  name "Swift Static Linux SDK"
  desc "Swift Static Linux SDK"
  homepage "https://www.swift.org/"

  livecheck do
    url "https://github.com/swiftlang/swift-org-website/raw/refs/heads/main/_data/builds/swift_releases.yml"
    strategy :yaml do |yaml|
      yaml.reverse.find do |item|
        item["platforms"].any? { |platform| platform["platform"] == "static-sdk" }
      end["name"]
    end
  end

  artifact artifactbundle_name.to_s, target: "~/Library/org.swift.swiftpm/swift-sdks/#{artifactbundle_name}"
end
