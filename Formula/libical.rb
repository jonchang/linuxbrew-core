class Libical < Formula
  desc "Implementation of iCalendar protocols and data formats"
  homepage "https://libical.github.io/libical/"
  url "https://github.com/libical/libical/releases/download/v3.0.9/libical-3.0.9.tar.gz"
  sha256 "bd26d98b7fcb2eb0cd5461747bbb02024ebe38e293ca53a7dfdcb2505265a728"
  license any_of: ["LGPL-2.1-or-later", "MPL-2.0"]

  bottle do
    sha256 cellar: :any, big_sur:      "e12adf682ea1f397351271c34de6ea2ef1d8d2b85f06fef6a6fa5e9c0639009e"
    sha256 cellar: :any, catalina:     "36981c1f3b12fb5fb5b2b5cb9992c4fad91bbdcabb0ba3d369fb2e56c6c912c9"
    sha256 cellar: :any, mojave:       "31f627dd8dd297bc02be8c7a4b790058d9209d98839cb31e727b7a948e29a66a"
    sha256 cellar: :any, x86_64_linux: "ddd5b97edd5b5bbdffa5fb3f8385fd0b8ed28e53b545223d4b772b89e66b3963"
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "icu4c"

  uses_from_macos "libxml2"

  def install
    system "cmake", ".", "-DBDB_LIBRARY=BDB_LIBRARY-NOTFOUND",
                         "-DENABLE_GTK_DOC=OFF",
                         "-DSHARED_ONLY=ON",
                         *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #define LIBICAL_GLIB_UNSTABLE_API 1
      #include <libical-glib/libical-glib.h>
      int main(int argc, char *argv[]) {
        ICalParser *parser = i_cal_parser_new();
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-o", "test", "-L#{lib}", "-lical-glib",
                   "-I#{Formula["glib"].opt_include}/glib-2.0",
                   "-I#{Formula["glib"].opt_lib}/glib-2.0/include"
    system "./test"
  end
end
