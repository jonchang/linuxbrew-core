class Akamai < Formula
  desc "CLI toolkit for working with Akamai's APIs"
  homepage "https://github.com/akamai/cli"
  url "https://github.com/akamai/cli/archive/1.1.5.tar.gz"
  sha256 "759c3c3bc59c2623fc8a5f91907f55d870f77aef1839f2ecc703db5c469b852a"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, big_sur:      "6a34e6b26f58c2401efee9e063d44db8e753672751c3f7e9a6783e87f1ba8c70"
    sha256 cellar: :any_skip_relocation, catalina:     "a986f3bfc261227cd44447d5ff9cdfb461c50c002118d36caed068f5859432e1"
    sha256 cellar: :any_skip_relocation, mojave:       "ce3ea6b8dba89d48bfec3be3bbf5701e7b1dcdde7a2f76a97dd668752b1e95fb"
    sha256 cellar: :any_skip_relocation, high_sierra:  "2b6d07c4926858e1be33bef070a925a6746f396fa27566aaa313d5a2673cb25f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "748751d8976fcaaa48a7921168a25794a81ca3bbd978471f1757e7346854783d"
  end

  depends_on "dep" => :build
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GLIDE_HOME"] = HOMEBREW_CACHE/"glide_home/#{name}"

    srcpath = buildpath/"src/github.com/akamai/cli"
    srcpath.install buildpath.children

    cd srcpath do
      system "dep", "ensure", "-vendor-only"
      system "go", "build", "-tags", "noautoupgrade nofirstrun", "-o", bin/"akamai"
      prefix.install_metafiles
    end
  end

  test do
    assert_match "Purge", shell_output("#{bin}/akamai install --force purge")
  end
end
