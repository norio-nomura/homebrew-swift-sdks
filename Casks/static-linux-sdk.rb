cask "static-linux-sdk" do
  version "6.4.3"
  sha256 "529e6982974de78793c8348c1459105a772f54b464a51edf074e5b9c4bfe7c73"

  release_name="swift-#{version}-RELEASE"
  # TODO: Update the version number in the artifact bundle name when the version is updated.
  artifactbundle_name="#{release_name}_static-linux-0.1.0.artifactbundle"

  url "https://download.swift.org/#{release_name.downcase}/static-sdk/#{release_name}/#{artifactbundle_name}.tar.gz"
  name "Swift Static Linux SDK"
  desc "Swift Static Linux SDK"
  homepage "https://www.swift.org/"

  livecheck do
    url "https://github.com/swiftlang/swift-org-website/raw/refs/heads/main/_data/builds/swift_releases.yml"
    strategy :yaml do |yaml|
      yaml.rfind do |item|
        item["platforms"].any? { |platform| platform["platform"] == "static-sdk" }
      end["name"]
    end
  end

  artifact artifactbundle_name.to_s, target: "~/Library/org.swift.swiftpm/swift-sdks/#{artifactbundle_name}"
end
