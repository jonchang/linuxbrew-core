class PowerlineGo < Formula
  desc "Beautiful and useful low-latency prompt for your shell"
  homepage "https://github.com/justjanne/powerline-go"
  url "https://github.com/justjanne/powerline-go/archive/v1.20.0.tar.gz"
  sha256 "5491e43ef089c89e8aa4b8631235ebf911c57f733e7bcd50cabe6a5da7a18a1b"
  license "GPL-3.0-or-later"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "1ce93f01e223a07fcf8cc9e8ed23629efc244856c46cc4b7472d61e86d4ba7d6"
    sha256 cellar: :any_skip_relocation, big_sur:       "f95b5cee326807aceed58d3957c5e1b44203adff14b42aa01cce944a181a02a0"
    sha256 cellar: :any_skip_relocation, catalina:      "d75b53a1817e65a73e29501a671a10490830a0ddc49cb7b6fe0d1d062ec78a41"
    sha256 cellar: :any_skip_relocation, mojave:        "b48588c2ebd4b3f0705ec649ad54ebb7f48137b82e76136847cc03615345623f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6484f711bbbd35c99357802a32c3869610e687f710c2457af01d5817bc128af4"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-s -w", *std_go_args
  end

  test do
    system "#{bin}/#{name}"
  end
end
