class Thrift < Formula
  desc "Framework for scalable cross-language services development"
  homepage "https://thrift.apache.org/"
  url "https://www.apache.org/dyn/closer.lua?path=thrift/0.13.0/thrift-0.13.0.tar.gz"
  mirror "https://archive.apache.org/dist/thrift/0.13.0/thrift-0.13.0.tar.gz"
  sha256 "7ad348b88033af46ce49148097afe354d513c1fca7c607b59c33ebb6064b5179"
  license "Apache-2.0"

  livecheck do
    url :stable
  end

  bottle do
    rebuild 1
    sha256 cellar: :any, arm64_big_sur: "ef547715c618d3a3cd8586f9678e1b5d09e970680ca44e3a184a106142ff0537"
    sha256 cellar: :any, big_sur:       "5f5280ff34d8e814e52cddf28d84b6e519cf29cc8d56f4712421a78da8e265e8"
    sha256 cellar: :any, catalina:      "9fff4084e59bf612da35f7e731c82f5a1d714aec8ba860a2521c0ca1d73731d4"
    sha256 cellar: :any, mojave:        "840fbc8db938bc1b8e50d16f733bcd22a8918efee276cbf969fc79f779380b5d"
    sha256 cellar: :any, high_sierra:   "bec0a20279bf36bcd960c71b9e417e41a53479e8a575034bef426994e7ecc546"
    sha256 cellar: :any, x86_64_linux:  "4120ac01e7b84804261f75fd878cccc53ef87f11a8fc2b4305b680160e731c08"
  end

  head do
    url "https://github.com/apache/thrift.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
    depends_on "pkg-config" => :build
  end

  depends_on "bison" => :build
  depends_on "boost" => [:build, :test]
  depends_on "openssl@1.1"

  def install
    system "./bootstrap.sh" unless build.stable?

    args = %W[
      --disable-debug
      --disable-tests
      --prefix=#{prefix}
      --libdir=#{lib}
      --with-openssl=#{Formula["openssl@1.1"].opt_prefix}
      --without-erlang
      --without-haskell
      --without-java
      --without-perl
      --without-php
      --without-php_extension
      --without-python
      --without-ruby
      --without-swift
    ]

    ENV.cxx11 if ENV.compiler == :clang

    # Don't install extensions to /usr:
    ENV["PY_PREFIX"] = prefix
    ENV["PHP_PREFIX"] = prefix
    ENV["JAVA_PREFIX"] = buildpath

    system "./configure", *args
    ENV.deparallelize
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.thrift").write <<~'EOS'
      service MultiplicationService {
        i32 multiply(1:i32 x, 2:i32 y),
      }
    EOS

    system "#{bin}/thrift", "-r", "--gen", "cpp", "test.thrift"

    system ENV.cxx, "-std=c++11", "gen-cpp/MultiplicationService.cpp",
      "gen-cpp/MultiplicationService_server.skeleton.cpp",
      "-I#{include}/include",
      "-L#{lib}", "-lthrift"
  end
end
