class Macon < Formula
  desc "Local CI runner — runs macon.yml pipelines on your Mac"
  homepage "https://github.com/alimusawa313/MacON"
  url "https://github.com/alimusawa313/MacON/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "b97b0104b0155ffd2bb343c8e6830df44d64acfdea38a374b1d3cdbee895f41b"
  version "0.3.0"
  license "MIT"

  depends_on xcode: ["15.0", :build]
  depends_on :macos

  def install
    inreplace "MaconKit/Sources/MaconKit/Version.swift",
              /maconVersion = "[^"]*"/, "maconVersion = \"#{version}\""
    system "swift", "build", "--disable-sandbox", "-c", "release", "--package-path", "MaconKit"
    bin.install "MaconKit/.build/release/macon"
  end

  test do
    assert_match "macon", shell_output("#{bin}/macon version")
  end
end
