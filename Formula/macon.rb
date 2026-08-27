class Macon < Formula
  desc "Local CI runner — runs macon.yml pipelines on your Mac"
  homepage "https://github.com/alimusawa313/MaconKit"
  url "https://github.com/alimusawa313/MaconKit/archive/refs/tags/v1.4.1.tar.gz"
  sha256 "c0f044a90c6ae1b329151f66e1169e133af205ab328c4611ebbf2b68174c7f15"
  version "1.4.1"
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
