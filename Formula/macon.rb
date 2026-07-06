class Macon < Formula
  desc "Local CI runner — runs macon.yml pipelines on your Mac"
  homepage "https://github.com/alimusawa313/MacON"
  url "https://github.com/alimusawa313/MacON/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "7a0f3552fad268def2c2ffe8f169f2abb020c29427c17e05a7f99aa7963823a5"
  version "0.2.0"
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
