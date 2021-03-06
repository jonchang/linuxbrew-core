class Taskell < Formula
  desc "Command-line Kanban board/task manager with support for Trello"
  homepage "https://taskell.app"
  url "https://github.com/smallhadroncollider/taskell/archive/1.10.1.tar.gz"
  sha256 "5056fad8983253a8c67d28f525b2cdf1dc7a182e0e1885a6f060189832aaae54"
  license "BSD-3-Clause"

  bottle do
    sha256 cellar: :any_skip_relocation, big_sur:      "4a093b7024da7e64fa5f4cdb1be1ebca5006fda0f0513412dcdd4df2505edf3c"
    sha256 cellar: :any_skip_relocation, catalina:     "d224f2ea895ced6b1a8cc761e3d3c79478a9e210df68f3cbcdb65debacd8a246"
    sha256 cellar: :any_skip_relocation, mojave:       "6733a5756ba481343d132064e22a6a6447eef1e374ad4a9d4915d8951fe5ccb0"
    sha256 cellar: :any_skip_relocation, high_sierra:  "d7fbd709e7713e2f08a1d75a64c2527dfa87f8d935a872054119bedc4338d652"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "61efe2cd89cda960b60b736450c7fcf3a9b97663cf9835e28028f0fa9ec8c666"
  end

  depends_on "cabal-install" => :build
  depends_on "ghc@8.8" => :build
  depends_on "hpack" => :build

  uses_from_macos "ncurses"
  uses_from_macos "zlib"

  def install
    system "hpack"
    system "cabal", "v2-update"
    system "cabal", "v2-install", *std_cabal_v2_args
  end

  test do
    (testpath/"test.md").write <<~EOS
      ## To Do

      - A thing
      - Another thing
    EOS

    expected = <<~EOS
      test.md
      Lists: 1
      Tasks: 2
    EOS

    assert_match expected, shell_output("#{bin}/taskell -i test.md")
  end
end
