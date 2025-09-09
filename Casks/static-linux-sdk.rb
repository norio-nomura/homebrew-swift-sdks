cask "static-linux-sdk" do
  version "6.1.3"
  sha256 "7a741da46ce64cdbd6dd504a2617b211b88e7f66a9ada7ea4e55bcc9c06ff2b2"

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
