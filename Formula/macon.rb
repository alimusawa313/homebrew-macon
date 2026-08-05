class Macon < Formula
  desc "Local CI runner — runs macon.yml pipelines on your Mac"
  homepage "https://github.com/alimusawa313/MaconKit"
  url "https://github.com/alimusawa313/MaconKit/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "15972144f9dc6f66dbd52735486b39ec16227e7a9575c649add6d3c67df01b06"
  version "1.0.1"
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
