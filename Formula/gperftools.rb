class Gperftools < Formula
  desc "Multi-threaded malloc() and performance analysis tools"
  homepage "https://github.com/gperftools/gperftools"
  url "https://github.com/gperftools/gperftools/releases/download/gperftools-2.8.1/gperftools-2.8.1.tar.gz"
  sha256 "12f07a8ba447f12a3ae15e6e3a6ad74de35163b787c0c7b76288d7395f2f74e0"
  license "BSD-3-Clause"

  livecheck do
    url :stable
    strategy :github_latest
    regex(%r{href=.*?/tag/gperftools[._-]v?(\d+(?:\.\d+)+)["' >]}i)
  end

  bottle do
    sha256 cellar: :any, big_sur:      "2a1dbba19d4457f12fca0f37c107b65a3e04315c2b04cedade26a110a4bccf71"
    sha256 cellar: :any, catalina:     "8d2e97b68f27e722336896358c6d4d29dd4eaca935f48c52983d779638edd2d2"
    sha256 cellar: :any, mojave:       "7a1d5e130ca76a6f2ba0f6743754a7ebf1ceda443cbc820588f3062d4ed9a64f"
    sha256 cellar: :any, x86_64_linux: "ff153bdfff4e0772b27e60cdaf6c8e45b3437d00155a633e922c5d354799276d"
  end

  head do
    url "https://github.com/gperftools/gperftools.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  on_linux do
    # libunwind is strongly recommended for Linux x86_64
    # https://github.com/gperftools/gperftools/blob/master/INSTALL
    depends_on "xz"

    resource "libunwind" do
      url "https://download.savannah.gnu.org/releases/libunwind/libunwind-1.2.1.tar.gz"
      sha256 "3f3ecb90e28cbe53fba7a4a27ccce7aad188d3210bb1964a923a731a27a75acb"
    end
  end

  def install
    # Fix "error: unknown type name 'mach_port_t'"
    ENV["SDKROOT"] = MacOS.sdk_path if MacOS.version == :sierra

    if OS.mac?
      ENV.append_to_cflags "-D_XOPEN_SOURCE"
    else
      resource("libunwind").stage do
        system "./configure",
               "--prefix=#{libexec}/libunwind",
               "--disable-debug",
               "--disable-dependency-tracking"
        system "make", "install"
      end

      ENV.append_to_cflags "-I#{libexec}/libunwind/include"
      ENV["LDFLAGS"] = "-L#{libexec}/libunwind/lib"
    end

    system "autoreconf", "-fiv" if build.head?
    if OS.mac?
      system "./configure", "--disable-dependency-tracking",
                            "--prefix=#{prefix}"
    else
      system "./configure", "--disable-dependency-tracking",
                            "--prefix=#{prefix}",
                            "--enable-libunwind"
    end
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <assert.h>
      #include <gperftools/tcmalloc.h>

      int main()
      {
        void *p1 = tc_malloc(10);
        assert(p1 != NULL);

        tc_free(p1);

        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-ltcmalloc", "-o", "test"
    system "./test"
  end
end
