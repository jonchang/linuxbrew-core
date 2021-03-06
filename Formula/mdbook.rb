class Mdbook < Formula
  desc "Create modern online books from Markdown files"
  homepage "https://rust-lang.github.io/mdBook/"
  url "https://github.com/rust-lang/mdBook/archive/v0.4.6.tar.gz"
  sha256 "a0a8f8e65030370cec8f5114ccb57334c9f2b7153dc51677e12dc74632d3ed23"
  license "MPL-2.0"
  head "https://github.com/rust-lang/mdBook.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ac1f5fa9b9ba6c6926ae80d8579093314623ecc8fe59fcaf1568dbeccb5e2fda"
    sha256 cellar: :any_skip_relocation, big_sur:       "d62347bbbab1bae29ec8a810e87c75926284e725f2a3c09d90052e638f5a7a47"
    sha256 cellar: :any_skip_relocation, catalina:      "fc41c2b2c6b68b3092711c6833a9d802574c23536c4ad66a6934bf3a2e5cf2e8"
    sha256 cellar: :any_skip_relocation, mojave:        "c96044e3c99cd45164176758c457d5639d1a9155468c646a4b5d3c521bea70d9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b4142b3df9d035f878bdeea0f081cd27835e3f85f58229cb8d172568e0ad9146"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # simulate user input to mdbook init
    system "sh", "-c", "printf \\n\\n | #{bin}/mdbook init"
    system "#{bin}/mdbook", "build"
  end
end
