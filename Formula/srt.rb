class Srt < Formula
  desc "Secure Reliable Transport"
  homepage "https://www.srtalliance.org/"
  url "https://github.com/Haivision/srt/archive/v1.4.2.tar.gz"
  sha256 "28a308e72dcbb50eb2f61b50cc4c393c413300333788f3a8159643536684a0c4"
  license "MPL-2.0"
  head "https://github.com/Haivision/srt.git"

  bottle do
    rebuild 1
    sha256 cellar: :any, arm64_big_sur: "ab7f65bed615a3c83007536df1b4c4d0d0f6851f350a78093203287ef1772aab"
    sha256 cellar: :any, big_sur:       "44a1055208b9dc75d5ad82aa404b492fb28c226990ec0a01ab493a0d852bdd3b"
    sha256 cellar: :any, catalina:      "7056a06ce6405fe33266d528e6a8aa295e1a3db6780f23627494610a7f31f8fc"
    sha256 cellar: :any, mojave:        "0d14cac97d2dab6cdf4059c5472e448555fda17982c9e802869224f0049a13a2"
    sha256 cellar: :any, x86_64_linux:  "2eb6c23c608c7c6cb9db4f886fd73749351f876d276772eff175add7fc2b787a"
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "openssl@1.1"

  def install
    openssl = Formula["openssl@1.1"]
    system "cmake", ".", "-DWITH_OPENSSL_INCLUDEDIR=#{openssl.opt_include}",
                         "-DWITH_OPENSSL_LIBDIR=#{openssl.opt_lib}",
                         "-DCMAKE_INSTALL_BINDIR=bin",
                         "-DCMAKE_INSTALL_LIBDIR=lib",
                         "-DCMAKE_INSTALL_INCLUDEDIR=include",
                         *std_cmake_args
    system "make", "install"
  end

  test do
    cmd = "#{bin}/srt-live-transmit file:///dev/null file://con/ 2>&1"
    assert_match "Unsupported source type", shell_output(cmd, 1)
  end
end
