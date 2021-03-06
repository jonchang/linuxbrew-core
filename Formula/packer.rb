class Packer < Formula
  desc "Tool for creating identical machine images for multiple platforms"
  homepage "https://packer.io"
  url "https://github.com/hashicorp/packer.git",
      tag:      "v1.6.6",
      revision: "9b997f28d5e3a187f2141d7c06082bbf0732954b"
  license "MPL-2.0"
  head "https://github.com/hashicorp/packer.git"

  livecheck do
    url "https://releases.hashicorp.com/packer/"
    regex(%r{href=.*?v?(\d+(?:\.\d+)+)/?["' >]}i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, big_sur:      "6cec4b55dd8ad06ed0ff9377f3ef0c94742a55c52e94b018aff048f4ce4ed329"
    sha256 cellar: :any_skip_relocation, catalina:     "e087d643942e7b4a9a54e2f531f9a772f5701850bb4b2d13fba765ec8238c973"
    sha256 cellar: :any_skip_relocation, mojave:       "9b50a1b3b3daa406baceb6c39cad926adf4dfe1fc04949e145633fbd67ea8d0a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4863bb801393a4082bc02016929e73b3ae37764b78b472dd57c1a5127586bc4e"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
    zsh_completion.install "contrib/zsh-completion/_packer"
    prefix.install_metafiles
  end

  test do
    minimal = testpath/"minimal.json"
    minimal.write <<~EOS
      {
        "builders": [{
          "type": "amazon-ebs",
          "region": "us-east-1",
          "source_ami": "ami-59a4a230",
          "instance_type": "m3.medium",
          "ssh_username": "ubuntu",
          "ami_name": "homebrew packer test  {{timestamp}}"
        }],
        "provisioners": [{
          "type": "shell",
          "inline": [
            "sleep 30",
            "sudo apt-get update"
          ]
        }]
      }
    EOS
    system "#{bin}/packer", "validate", "-syntax-only", minimal
  end
end
