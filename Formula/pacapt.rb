class Pacapt < Formula
  desc "Package manager in the style of Arch's pacman"
  homepage "https://github.com/icy/pacapt"
  url "https://github.com/icy/pacapt/archive/v2.4.3.tar.gz"
  sha256 "4dcf0bad070b09267b9c7b77bf5f9ff525c57915a17e9ee63e1ee53413a635ff"
  license "Fair"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "3b681e481088b2f2279e620e542d46ca666a725515df287fbbfafb18fc398097"
    sha256 cellar: :any_skip_relocation, big_sur:       "21d766d65cbf0896dc0cd0e21454de7f2aedd1f72ef14aed9310962e8a31184b"
    sha256 cellar: :any_skip_relocation, catalina:      "88560339524e9f110cb58ddd3e8744cc44d6e24f86c0b9ca05ef01a059c55be2"
    sha256 cellar: :any_skip_relocation, mojave:        "88560339524e9f110cb58ddd3e8744cc44d6e24f86c0b9ca05ef01a059c55be2"
    sha256 cellar: :any_skip_relocation, high_sierra:   "88560339524e9f110cb58ddd3e8744cc44d6e24f86c0b9ca05ef01a059c55be2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "486019bcc3141d0e226581caf8edb5cb6636f4d74748f2cd7dd9739fbd2f83c0"
  end

  def install
    bin.mkpath
    system "make", "install", "BINDIR=#{bin}", "VERSION=#{version}"
  end

  test do
    system "#{bin}/pacapt", "-Ss", "wget"
  end
end
