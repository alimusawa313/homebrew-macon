class Macon < Formula
  desc "Local CI runner — runs macon.yml pipelines on your Mac"
  homepage "https://github.com/alimusawa313/MaconKit"
  url "https://github.com/alimusawa313/MaconKit/archive/refs/tags/v1.11.0.tar.gz"
  sha256 "115a6655f4627a701c398116e4b30afd144a33efdf392ef9eb80f6527b7cf724"
  version "1.11.0"
  license "MIT"

  depends_on xcode: ["15.0", :build]
  depends_on :macos

  def install
    # Stamp the release version in, so `macon version` matches the tag.
    inreplace "Sources/MaconKit/Version.swift",
              /maconVersion = "[^"]*"/, "maconVersion = \"#{version}\""
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/macon"
  end

  test do
    assert_match "macon", shell_output("#{bin}/macon version")
  end
end
