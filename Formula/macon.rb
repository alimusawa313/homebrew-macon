class Macon < Formula
  desc "Local CI runner — runs macon.yml pipelines on your Mac"
  homepage "https://github.com/alimusawa313/MaconKit"
  url "https://github.com/alimusawa313/MaconKit/archive/refs/tags/v1.9.0.tar.gz"
  sha256 "3c084d28212e383c3ea3f50627d451b0c828b92f7dbfb182376040b80ea372fd"
  version "1.9.0"
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
