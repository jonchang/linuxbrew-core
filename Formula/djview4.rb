class Djview4 < Formula
  desc "Viewer for the DjVu image format"
  homepage "https://djvu.sourceforge.io/djview4.html"
  url "https://downloads.sourceforge.net/project/djvu/DjView/4.12/djview-4.12.tar.gz"
  sha256 "5673c6a8b7e195b91a1720b24091915b8145de34879db1158bc936b100eaf3e3"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    regex(%r{url=.*?/djview[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 cellar: :any, big_sur:      "6dd9895644f2bc9be226ccab8affe012c31cd9a27835cd62dd3d4edddd2c0049"
    sha256 cellar: :any, catalina:     "67dc7e3fab1c0c1407ec62c346071ec45e2981185948ec6015e75762e179cf0f"
    sha256 cellar: :any, mojave:       "6ae80a29abde4d055c6ee544f997a8cd6bfe5bc5d9a0fa3bd7584d29cd32c73f"
    sha256 cellar: :any, x86_64_linux: "9aa96d207fee31358aad731555b58a0b995e2b0fc58e9e66bbad2ce7a04c7f8a"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "djvulibre"
  depends_on "qt"

  def install
    system "autoreconf", "-fiv"

    system "./configure", "--disable-debug",
                          "--prefix=#{prefix}",
                          "--with-x=no",
                          "--disable-nsdejavu",
                          "--disable-desktopfiles"
    system "make", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}"

    # From the djview4.8 README:
    # NOTE: Do not use command "make install".
    # Simply copy the application bundle where you want it.
    on_macos do
      prefix.install "src/djview.app"
    end
    on_linux do
      prefix.install "src/djview"
    end
  end
end
