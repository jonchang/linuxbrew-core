class Libxres < Formula
  desc "X.Org: X-Resource extension client library"
  homepage "https://www.x.org/"
  url "https://www.x.org/archive/individual/lib/libXres-1.2.0.tar.bz2"
  sha256 "ff75c1643488e64a7cfbced27486f0f944801319c84c18d3bd3da6bf28c812d4"
  license "MIT"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "10d33ad166cc2ce0992e7837eea0ffeee0e68541b83a449985c4f23456962331"
    sha256 cellar: :any, big_sur:       "fcb9ac04422ee9752674c1fe7cad12cf079b299b0bbd7492866c1cd51223455d"
    sha256 cellar: :any, catalina:      "9284047f0480984d64b23e375e7aea8fe986e92cf511aac09cd6966221a2e7a7"
    sha256 cellar: :any, mojave:        "1e5bda4d9cd50b6d45252949946e03758e0e05bdd4bf0e3d4e4724a43cd9aa55"
    sha256 cellar: :any, high_sierra:   "bfec4cc0604f69d40a032f4ec36d231be3bac9eca44bcfcf4fb18ecd23023fbc"
    sha256 cellar: :any, x86_64_linux:  "330099f32018ac85a11e831f56eef602a87f17b3ea75de5f5efbfe846da6af28"
  end

  depends_on "pkg-config" => :build
  depends_on "xorgproto" => :build
  depends_on "libx11"
  depends_on "libxext"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include "X11/Xlib.h"
      #include "X11/extensions/XRes.h"

      int main(int argc, char* argv[]) {
        XResType client;
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lXRes"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
