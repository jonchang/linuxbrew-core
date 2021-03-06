class Gleam < Formula
  desc "✨ A statically typed language for the Erlang VM"
  homepage "https://gleam.run"
  url "https://github.com/gleam-lang/gleam/archive/v0.13.2.tar.gz"
  sha256 "731c09bdfd02bb9c16ca77929c838a4ebe3430704050a982eeac114b68a46551"
  license "Apache-2.0"

  bottle do
    sha256 arm64_big_sur: "507e4e923dbd2360124ab6753a8091427a0ce84bf95d66911d82b31d57dad697"
    sha256 big_sur:       "55010c559d4fbbe94940136eb1667fb3b67c79bd213e17c7b30d15499055e4ed"
    sha256 catalina:      "3469ba547cef8f9ff75f009e80861f5e7710d237a8cc7ebfc5b575f8edee7e6d"
    sha256 mojave:        "41f34ecdf5ffacfc732a6685bba365a43e15cab4ba21679b9ae5a86ba0eea460"
    sha256 x86_64_linux:  "f42dc957456f30df5ff8220bc8da9eed304711f0085fc7aba91f29c96c600132"
  end

  depends_on "rust" => :build
  depends_on "erlang"
  depends_on "rebar3"

  on_linux do
    depends_on "pkg-config" => :build
  end

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    Dir.chdir testpath
    system "#{bin}/gleam", "new", "test_project"
    Dir.chdir "test_project"
    system "rebar3", "eunit"
  end
end
