cask "static-linux-sdk" do
  version "6.3.2"
  sha256 "3fd798bef6f4408f1ea5a6f94ce4d4052830c4326ab85ebc04f983f01b3da407"

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
