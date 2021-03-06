class Atomicparsley < Formula
  desc "MPEG-4 command-line tool"
  homepage "https://github.com/wez/atomicparsley"
  url "https://github.com/wez/atomicparsley/archive/20210114.184825.1dbe1be.tar.gz"
  version "20210114.184825.1dbe1be"
  sha256 "8877262c86d0ad231a5b0eaa8ab9c0c1d4e06fafea0b96a819d9a5e565a28b8c"
  license "GPL-2.0-or-later"
  version_scheme 1
  head "https://github.com/wez/atomicparsley.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a8e5692e8ef0283fd49d2f49c4496bfc89a083514da2334fa02eb6fc2f4e2989"
    sha256 cellar: :any_skip_relocation, big_sur:       "be1e8745667ef864650fff051ad1c14449401ecd407d16c737f58e38785ded95"
    sha256 cellar: :any_skip_relocation, catalina:      "49a797a44dce461bbd76fea51e4d4a855eec29bd6b83e592ff8acee2d44f8055"
    sha256 cellar: :any_skip_relocation, mojave:        "a979f00c124189f4799f08b55b8554c5e36ddc17a1e682ac33e4d9615bdcc339"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "852d987f1257766f155f7b275a5583ba45a00608923bd5e4866988abd19fcee2"
  end

  depends_on "cmake" => :build
  uses_from_macos "zlib"

  unless OS.mac?
    fails_with gcc: "4"
    fails_with gcc: "5"
    fails_with gcc: "6"
    depends_on "gcc@7" => :build
  end

  def install
    system "cmake", ".", *std_cmake_args
    system "cmake", "--build", ".", "--config", "Release"
    bin.install "AtomicParsley"
  end

  test do
    cp test_fixtures("test.m4a"), testpath/"file.m4a"
    system "#{bin}/AtomicParsley", testpath/"file.m4a", "--artist", "Homebrew", "--overWrite"
    output = shell_output("#{bin}/AtomicParsley file.m4a --textdata")
    assert_match "Homebrew", output
  end
end
