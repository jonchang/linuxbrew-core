class Hebcal < Formula
  desc "Perpetual Jewish calendar for the command-line"
  homepage "https://github.com/hebcal/hebcal"
  url "https://github.com/hebcal/hebcal/archive/v4.24.tar.gz"
  sha256 "64e885d45b2006539af3135dacdb3b540092483bf0380e1b0e5bea224ca19889"
  license "GPL-2.0-or-later"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "33af9a0346510a27b1e046bcd8d7d4e734216d578ad907a54ebb9ad6aae3ace9"
    sha256 cellar: :any_skip_relocation, big_sur:       "ff567e2bcda1ae361e63e8a86ddf85199c6224894a57caedee078e1483fdc521"
    sha256 cellar: :any_skip_relocation, catalina:      "21a0b493d2ce497baed5a0badb60a312f5e96afb8b2afbe1d8eecc584d885207"
    sha256 cellar: :any_skip_relocation, mojave:        "dea0961f7ee0fe3420f4b3eed313016897a1c2aca43e4b50a0936ee2b9c6653e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0f5e4217004a2b4df6a82a78f0a9f054f57e384975260b780c8d773262077d57"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "./configure", "--prefix=#{prefix}", "ACLOCAL=aclocal", "AUTOMAKE=automake"
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/hebcal 01 01 2020").chomp
    assert_equal output, "1/1/2020 4th of Tevet, 5780"
  end
end
