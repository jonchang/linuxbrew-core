class Libstatgrab < Formula
  desc "Provides cross-platform access to statistics about the system"
  homepage "https://www.i-scream.org/libstatgrab/"
  url "https://ftp.i-scream.org/pub/i-scream/libstatgrab/libstatgrab-0.92.tar.gz"
  mirror "https://www.mirrorservice.org/pub/i-scream/libstatgrab/libstatgrab-0.92.tar.gz"
  sha256 "5bf1906aff9ffc3eeacf32567270f4d819055d8386d98b9c8c05519012d5a196"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "8aaf22584aedf2494b757faa7aa85b3a449b7b0a1f1e1bca3ac099e880e49248"
    sha256 cellar: :any, big_sur:       "116a88f47d3d5125d68fdd30918f70abfba59ab7e31b2df71698bbaa0673616a"
    sha256 cellar: :any, catalina:      "d3a41dfe112e21467ce51134b576e14678f982f1c838b6b624d96ad46edc7c88"
    sha256 cellar: :any, mojave:        "bb1778c08b1b91cff873016e3a6f314d3a97a55db378e0870354bb64337ea50b"
    sha256 cellar: :any, high_sierra:   "d7d932298fe68980389bf5b2c8f1d6ef41a6037630b4951996139c2277fbf6f4"
    sha256 cellar: :any, sierra:        "17efc663227f42859add13c81e0b5fac1f3f3a0418c3d15b83363ea90c0b4a91"
    sha256 cellar: :any, x86_64_linux:  "28562aed435bb94ea567771537d6ecebc5d7e0a29435c124e341a4946386cdce"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/statgrab"
  end
end
