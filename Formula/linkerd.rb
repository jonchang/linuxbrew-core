class Linkerd < Formula
  desc "Command-line utility to interact with linkerd"
  homepage "https://linkerd.io"

  url "https://github.com/linkerd/linkerd2.git",
      tag:      "stable-2.9.2",
      revision: "d5e9d56ce431bdf5ec02e51461ec0cf4bfdd783c"
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^stable[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7da25e5cf3954bb918cb83d78754d198c8bdb110c95fad29732d3a01dbb285ba"
    sha256 cellar: :any_skip_relocation, big_sur:       "2aeadbfd6da81217224c9a1faa33ec2ac68607fed0004268bf9bbd3c9801b4c5"
    sha256 cellar: :any_skip_relocation, catalina:      "6ce86e0761fa9590cfe729a65b0e19d80715ee0df1aeaa8b2eb06df7ba0b6dc1"
    sha256 cellar: :any_skip_relocation, mojave:        "77bb58a6e8613b4ea16ebc43bb8ddf1b8e61427bf690c1c5de02370ddf00874d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b5e0648d85a56294e9d21821c8f08b1a023f66169afc7698615e717b53aa6605"
  end

  depends_on "go" => :build

  def install
    ENV["CI_FORCE_CLEAN"] = "1"

    os = if OS.mac?
      "darwin"
    else
      "linux-amd64"
    end

    system "bin/build-cli-bin"
    bin.install "target/cli/#{os}/linkerd"

    # Install bash completion
    output = Utils.safe_popen_read("#{bin}/linkerd", "completion", "bash")
    (bash_completion/"linkerd").write output

    # Install zsh completion
    output = Utils.safe_popen_read("#{bin}/linkerd", "completion", "zsh")
    (zsh_completion/"linkerd").write output

    prefix.install_metafiles
  end

  test do
    run_output = shell_output("#{bin}/linkerd 2>&1")
    assert_match "linkerd manages the Linkerd service mesh.", run_output

    version_output = shell_output("#{bin}/linkerd version --client 2>&1")
    assert_match "Client version: ", version_output
    stable_resource = stable.instance_variable_get(:@resource)
    assert_match stable_resource.instance_variable_get(:@specs)[:tag], version_output if build.stable?

    system "#{bin}/linkerd", "install", "--ignore-cluster"
  end
end
