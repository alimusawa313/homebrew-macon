class Macon < Formula
  desc "Local CI runner — runs macon.yml pipelines on your Mac"
  homepage "https://github.com/alimusawa313/MacON"
  url "https://github.com/alimusawa313/MacON/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "b0fe0d6ffe67fb7c2eaa11336b9c92d52d362666803fb2b17f7b2edfc99f8cc9"
  version "0.6.0"
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
