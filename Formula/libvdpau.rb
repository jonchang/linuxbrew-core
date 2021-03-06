class Libvdpau < Formula
  desc "Open source Video Decode and Presentation API library"
  homepage "https://www.freedesktop.org/wiki/Software/VDPAU/"
  url "https://gitlab.freedesktop.org/vdpau/libvdpau/uploads/14b620084c027d546fa0b3f083b800c6/libvdpau-1.2.tar.bz2"
  sha256 "6a499b186f524e1c16b4f5b57a6a2de70dfceb25c4ee546515f26073cd33fa06"
  license "MIT"

  livecheck do
    url "https://gitlab.freedesktop.org/vdpau/libvdpau.git"
    regex(/^(?:libvdpau[._-])?v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 arm64_big_sur: "50169a382bb560230e7e1e5aab6c20e6027773a8557af8623183daa81205586c"
    sha256 big_sur:       "74a3ea48e33530a014162fab0c6502f7a6be8aff25b05bd5fe971dd9d39e1371"
    sha256 catalina:      "9b57bf4d53024c75f4a431fd814fa0b6f54163d13dfbb63607d41c1a43b7117d"
    sha256 mojave:        "59980ec6bf90b676354ddda5e3c93a6240c4564d1c01aa35b1f1aa804d7b949a"
    sha256 x86_64_linux:  "c40783e983a9ff27448211993a732a1bef2b07f7b9ba01fc9b9c25ec68c18291"
  end

  depends_on "pkg-config" => [:build, :test]
  depends_on "libx11"
  depends_on "libxext"
  depends_on "xorgproto"

  def install
    on_macos do
      ENV.append "LDFLAGS", "-lx11"
    end
    system "./configure", "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--enable-dri2"
    system "make"
    system "make", "install"
  end

  test do
    assert_match "-I#{include}", shell_output("pkg-config --cflags vdpau")
  end
end
