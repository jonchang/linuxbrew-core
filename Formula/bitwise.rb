class Bitwise < Formula
  desc "Terminal based bit manipulator in ncurses"
  homepage "https://github.com/mellowcandle/bitwise"
  url "https://github.com/mellowcandle/bitwise/releases/download/v0.41/bitwise-v0.41.tar.gz"
  sha256 "33ce934fb99dadf7652224152cc135a0abf6a211adde53d96e9be7067567749c"
  license "GPL-3.0"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "c62df0d484c67a94b8e889cf3d551a90bb3b2884df44b8e250c2995893fca88e"
    sha256 cellar: :any, big_sur:       "cfa1a51366d29d7b81e0521c74afbdb5636b1ceb64e3cef8156f40eb58776d74"
    sha256 cellar: :any, catalina:      "d7d90a1402b7b87e1989b2504e6c55ea5bea27282f4bf909b6248aac2d5263cd"
    sha256 cellar: :any, mojave:        "95674ac94d09b5502765956cc94b5f1a9687f22f145e2757bd708f7f7613f913"
    sha256 cellar: :any, high_sierra:   "e5e76e2ec3f762a6c79b52552fb5513bc891e55831aa75806f61b75834369d6d"
    sha256 cellar: :any, x86_64_linux:  "dd29287d00806ef80327a226de16d1721c442c74b5cd7962fd0c29ed8ba62509"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "readline"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"

    system "make", "install"
  end

  test do
    assert_match "0 0 1 0 1 0 0 1", shell_output("#{bin}/bitwise --no-color '0x29A >> 4'")
  end
end
