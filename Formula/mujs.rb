class Mujs < Formula
  desc "Embeddable Javascript interpreter"
  homepage "https://www.mujs.com/"
  # use tag not tarball so the version in the pkg-config file isn't blank
  url "https://github.com/ccxvii/mujs.git",
      tag:      "1.0.9",
      revision: "6871e5b41c07558b17340f985f2af39717d3ba77"
  license "ISC"
  revision 1
  head "https://github.com/ccxvii/mujs.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b346f30e520540c9bf22be4438ea215ef7954eaf85c66ba71f4fc7be0f5c7f1d"
    sha256 cellar: :any_skip_relocation, big_sur:       "352e5c6c8ad24b3f36ad44e1b929e6f34a00360e5144a4fd490b228e2c9837bb"
    sha256 cellar: :any_skip_relocation, catalina:      "f0392da52d7b94279981010c643dc106946cb6a669e1cdb4de03f4732d260341"
    sha256 cellar: :any_skip_relocation, mojave:        "138027da2db61c148fb93d5176717c10265467551ec5762163d9b7017614c774"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f17c3735246a77bc8777f1b4a08b1d207b12443af065d36049d2ab6bf393705d"
  end

  on_linux do
    depends_on "readline"
  end

  def install
    system "make", "release"
    system "make", "prefix=#{prefix}", "install"
    system "make", "prefix=#{prefix}", "install-shared"
  end

  test do
    (testpath/"test.js").write <<~EOS
      print('hello, world'.split().reduce(function (sum, char) {
        return sum + char.charCodeAt(0);
      }, 0));
    EOS
    assert_equal "104", shell_output("#{bin}/mujs test.js").chomp
  end
end
