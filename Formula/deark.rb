class Deark < Formula
  desc "File conversion utility for older formats"
  homepage "https://entropymine.com/deark/"
  url "https://entropymine.com/deark/releases/deark-1.5.7.tar.gz"
  sha256 "b50ff49d13cfa3621721bac8c9af05e3ccb091852ddee0bc2e06a05e43d2ee9c"
  license "MIT"

  livecheck do
    url "https://entropymine.com/deark/releases/"
    regex(/href=.*?deark[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "1f35652e63074f3e95a766508b3ce264b3e7e5208196124224f9a77768ec059a"
    sha256 cellar: :any_skip_relocation, big_sur:       "58be36b00198b12edb3ee670a9dd664ce7383fa3e3c439d94905a8b55a24d650"
    sha256 cellar: :any_skip_relocation, catalina:      "191a4f3431f5c0f937e100249cb6ca24e95813562d45d292afcbd5b824ce6503"
    sha256 cellar: :any_skip_relocation, mojave:        "dc7c1e91110744973866610fb65368d2b7039562c889e449a5035c28691f1a6b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fb64c7dbe1c3cb3144dd981fb5739b5fe73ed824c6043fb3b84cab0c9917b249"
  end

  def install
    system "make"
    bin.install "deark"
  end

  test do
    require "base64"

    (testpath/"test.gz").write ::Base64.decode64 <<~EOS
      H4sICKU51VoAA3Rlc3QudHh0APNIzcnJ11HwyM9NTSpKLVfkAgBuKJNJEQAAAA==
    EOS
    system "#{bin}/deark", "test.gz"
    file = (testpath/"output.000.test.txt").readlines.first
    assert_match "Hello, Homebrew!", file
  end
end
