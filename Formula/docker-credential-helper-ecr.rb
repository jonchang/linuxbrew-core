class DockerCredentialHelperEcr < Formula
  desc "Docker Credential Helper for Amazon ECR"
  homepage "https://github.com/awslabs/amazon-ecr-credential-helper"
  url "https://github.com/awslabs/amazon-ecr-credential-helper.git",
      tag:      "v0.4.0",
      revision: "1a5791b236421b509fbc30502211b1de51ca8e30"
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, big_sur:      "fe14097587f1f22cba7ba36b49c738abc8027408cd6944e768030608deb49738"
    sha256 cellar: :any_skip_relocation, catalina:     "d5e603dc272c983cfd10995ac0b39418308e26c791a28d1a56fc13282d5425bb"
    sha256 cellar: :any_skip_relocation, mojave:       "2bcb4437b3096c71bc248e4bcbe4aa20d4cd801a63eb139c2250cd73f5c9f5cb"
    sha256 cellar: :any_skip_relocation, high_sierra:  "5db19be899dc7a06ab6e180bbf2972d6f8b4e44a092e6f7b2be35297f03044f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7cf5a406c35496bdf17ac443edf4e66f1aa49e22aed04e096c77e79d4e5a36d2"
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    dir = buildpath/"src/github.com/awslabs/amazon-ecr-credential-helper"
    dir.install buildpath.children - [buildpath/".brew_home"]

    cd dir do
      system "make", "build"
      bin.install "bin/local/docker-credential-ecr-login"
      prefix.install_metafiles
    end
  end

  test do
    output = shell_output("#{bin}/docker-credential-ecr-login", 1)
    assert_match %r{^Usage: .*/docker-credential-ecr-login.*}, output
  end
end
