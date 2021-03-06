class Qcachegrind < Formula
  desc "Visualize data generated by Cachegrind and Calltree"
  homepage "https://kcachegrind.github.io/"
  url "https://download.kde.org/Attic/applications/19.08.3/src/kcachegrind-19.08.3.tar.xz"
  sha256 "8fc5e0643bb826b07cb5d283b8bd6fd5da4979f6125b43b1db3a9db60b02a36a"
  license "GPL-2.0-or-later"

  # We don't match versions like 19.07.80 or 19.07.90 where the patch number
  # is 80+ (beta) or 90+ (RC), as these aren't stable releases.
  livecheck do
    url "https://download.kde.org/Attic/applications/"
    regex(%r{href=.*?v?(\d+\.\d+\.(?:(?!8\d|9\d)\d+)(?:\.\d+)*)/?["' >]}i)
  end

  bottle do
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e41ff7b471b679c92de77708248ae2a42948b39a945ac89de73d85756ed0f3f2"
    sha256 cellar: :any_skip_relocation, big_sur:       "65b5858aa4f3313bf7782bbb09de8d83f72a15da02bcf981da016a8216ff20a1"
    sha256 cellar: :any_skip_relocation, catalina:      "8ce1697e577f363929ff9ef3a112513d840da04331c0d907a03c5970f8f04807"
    sha256 cellar: :any_skip_relocation, mojave:        "a64cb74efa08ddc452e3f29eb956a2c89dd9f7eb0f5943731559fca9815350d7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e094bf0bbff8d555689a89d17af5438a9e512fc5df192071b81e62b70fead525"
  end

  depends_on "graphviz"
  depends_on "qt"

  def install
    if OS.mac?
      spec = (ENV.compiler == :clang) ? "macx-clang" : "macx-g++"
      spec << "-arm64" if Hardware::CPU.arm?
      cd "qcachegrind" do
        system "#{Formula["qt"].opt_bin}/qmake", "-spec", spec,
                                                 "-config", "release"
        system "make"
        prefix.install "qcachegrind.app"
        bin.install_symlink prefix/"qcachegrind.app/Contents/MacOS/qcachegrind"
      end
    else
      system "qmake", "-config", "release"
      system "make"
      bin.install "qcachegrind/qcachegrind"
    end
  end
end
