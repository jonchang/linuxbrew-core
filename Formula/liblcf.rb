class Liblcf < Formula
  desc "Library for RPG Maker 2000/2003 games data"
  homepage "https://easyrpg.org/"
  url "https://easyrpg.org/downloads/player/0.6.2/liblcf-0.6.2.tar.xz"
  sha256 "c48b4f29ee0c115339a6886fc435b54f17799c97ae134432201e994b1d3e0d34"
  license "MIT"
  revision 1
  head "https://github.com/EasyRPG/liblcf.git"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "d1154e1054f90550f15a79b47db13a8d72d3482212ae4c71cce89d0a37c692a0"
    sha256 cellar: :any, big_sur:       "c9188f359be4dda83cd9fd6759cfbc2398a48e1c50a6b46e1678cba4056d6011"
    sha256 cellar: :any, catalina:      "1765ea5fd438e35c255104fcf3670f4fb20b44b0d88dfc5579deeb95fd0567a1"
    sha256 cellar: :any, mojave:        "626aeacfaba89b8d5bb57945c4f82c33758e7a78de2b2d87261e6e83e874a7bc"
    sha256 cellar: :any, high_sierra:   "b508d5fd894f0962328296f0d292eb3cd88e48d42d20e75934b7b9abad62c53a"
    sha256 cellar: :any, x86_64_linux:  "ceb6f33dda029e2f510741eb4e6c6fc45ea13fdf797c84dcd8cc00f315d4dfae"
  end

  depends_on "pkg-config" => :build
  depends_on "icu4c"

  uses_from_macos "expat"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include "lsd_reader.h"
      #include <cassert>

      int main() {
        std::time_t const current = std::time(NULL);
        assert(current == LSD_Reader::ToUnixTimestamp(LSD_Reader::ToTDateTime(current)));
        return 0;
      }
    EOS
    system ENV.cc, "test.cpp", "-I#{include}/liblcf", "-L#{lib}", "-llcf", "-std=c++11", \
      "-o", "test"
    system "./test"
  end
end
