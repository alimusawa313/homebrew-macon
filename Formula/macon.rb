class Macon < Formula
  desc "Local CI runner — runs macon.yml pipelines on your Mac"
  homepage "https://github.com/alimusawa313/MacON"
  url "https://github.com/alimusawa313/MacON/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "61bd248ec714c0ea1a519c139ce343be2385bf8412d07e7ae17bdfdf93648155"
  version "0.8.0"
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
