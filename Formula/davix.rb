class Davix < Formula
  desc "Library and tools for advanced file I/O with HTTP-based protocols"
  homepage "https://github.com/cern-fts/davix"
  url "https://github.com/cern-fts/davix/releases/download/R_0_7_6/davix-0.7.6.tar.gz"
  sha256 "a2e7fdff29f7ba247a3bcdb08ab1db6d6ed745de2d3971b46526986caf360673"
  license "LGPL-2.1"
  head "https://github.com/cern-fts/davix.git"

  bottle do
    rebuild 1
    sha256 cellar: :any, arm64_big_sur: "29e62d295cee33757abdf95ee7cb4c3aa5b180419e6687bf9347a6a121cab134"
    sha256 cellar: :any, big_sur:       "9e554eb91c81f79781ea0890dd7309fe94010b32787a465f2368a8c0cd9129f9"
    sha256 cellar: :any, catalina:      "e96a673e5adb6b0856928002be86673db1ba3efd3b8b06d5f87b8793d99698bb"
    sha256 cellar: :any, mojave:        "1c863a82c559b2cb4def7b425339edbb5cb31847d21ae886f92e8616bd8af497"
    sha256 cellar: :any, high_sierra:   "41917fcf64168c8f229fe025d77807e2adf7298e2bdfcb2c4b582e9d116faf4b"
    sha256 cellar: :any, x86_64_linux:  "3b7a2bd36a0298116acf702897302e985dc473c1f1a0fd66cc8e58a2d4f117fe"
  end

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "openssl@1.1"

  uses_from_macos "libxml2"

  on_linux do
    depends_on "util-linux"
  end

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/davix-get", "https://brew.sh"
  end
end
