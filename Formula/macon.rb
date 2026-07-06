class Macon < Formula
  desc "Local CI runner — runs macon.yml pipelines on your Mac"
  homepage "https://github.com/alimusawa313/MacON"
  url "https://github.com/alimusawa313/MacON/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "e0e6d84e489ebf88cb51872bc4e16036ad8ba9ed6bc2b1b158daf3a8a6af5ff7"
  version "0.1.0"
  license "MIT"

  depends_on xcode: ["15.0", :build]
  depends_on :macos

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release", "--package-path", "MaconKit"
    bin.install "MaconKit/.build/release/macon"
  end

  test do
    assert_match "macon", shell_output("#{bin}/macon version")
  end
end
