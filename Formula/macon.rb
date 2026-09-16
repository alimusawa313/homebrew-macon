class Macon < Formula
  desc "Local CI runner — runs macon.yml pipelines on your Mac"
  homepage "https://github.com/alimusawa313/MaconKit"
  url "https://github.com/alimusawa313/MaconKit/archive/refs/tags/v1.9.3.tar.gz"
  sha256 "26f82c8706fff4901c63877351efc6bf98145dc08faaa4ed2256f4d30079d08f"
  version "1.9.3"
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
