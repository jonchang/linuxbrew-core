class Hexyl < Formula
  desc "Command-line hex viewer"
  homepage "https://github.com/sharkdp/hexyl"
  url "https://github.com/sharkdp/hexyl/archive/v0.8.0.tar.gz"
  sha256 "b2e69b4ca694afd580c7ce22ab83a207174d2bbc9dabbad020fee4a98a1205be"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "80188fd9d00fe87481bce6ba29cfd3e844f742d4978f4ebd11c61932c0adc245"
    sha256 cellar: :any_skip_relocation, big_sur:       "bba889ef6dae61053f47c70868cf511515e93e6157c3f232b60e879a293ead92"
    sha256 cellar: :any_skip_relocation, catalina:      "2443b91247ef98143863f23724ab1ffe3b192aa65471d2198ab02ffa72936ce9"
    sha256 cellar: :any_skip_relocation, mojave:        "465474b8dd2b6344efda4d611341a0d40c46965fabce4e3446bb3bc0a45c2392"
    sha256 cellar: :any_skip_relocation, high_sierra:   "8805fb02b8cc13ffe9ca11663140f502dfbcbe5a4cbdf1262bd88758bc88167f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e05d4c3583ba9f0b2baf281051dd5f3b051502d49075f903b704b30f3602efac"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    pdf = test_fixtures("test.pdf")
    output = shell_output("#{bin}/hexyl -n 100 #{pdf}")
    assert_match "00000000", output
  end
end
