class Opa < Formula
  desc "Open source, general-purpose policy engine"
  homepage "https://www.openpolicyagent.org"
  url "https://github.com/open-policy-agent/opa/archive/v0.26.0.tar.gz"
  sha256 "d7d0a3341dc73283bddd3bf2d4e23b9d3013e4dca450b4415cb592ff83533541"
  license "Apache-2.0"
  head "https://github.com/open-policy-agent/opa.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "807ae148ee96fbd2410c423ff7c090f166c87f0185b8e4c68f26d6ed3c1e8670"
    sha256 cellar: :any_skip_relocation, big_sur:       "08b65a777358d937bb66947fc72ed8bd121c061f2540957e9458076e1595a227"
    sha256 cellar: :any_skip_relocation, catalina:      "489fc53b198027f9b4bb154e6a4f386693e4f6b3dd35858e189f708394cbf20e"
    sha256 cellar: :any_skip_relocation, mojave:        "8235efc789d25061e449d7c915ac09e4a03f6584e14a846a6bf9a8814cc69a53"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8e6afdec7ee6ef8881ca13dee739521ff9424ece2e1c9c12b9749dcb84a1f022"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args,
              "-ldflags", "-X github.com/open-policy-agent/opa/version.Version=#{version}"
    system "./build/gen-man.sh", "man1"
    man.install "man1"
  end

  test do
    output = shell_output("#{bin}/opa eval -f pretty '[x, 2] = [1, y]' 2>&1")
    assert_equal "+---+---+\n| x | y |\n+---+---+\n| 1 | 2 |\n+---+---+\n", output
    assert_match "Version: #{version}", shell_output("#{bin}/opa version 2>&1")
  end
end
