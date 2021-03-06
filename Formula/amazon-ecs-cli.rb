class AmazonEcsCli < Formula
  desc "CLI for Amazon ECS to manage clusters and tasks for development"
  homepage "https://aws.amazon.com/ecs"
  url "https://github.com/aws/amazon-ecs-cli/archive/v1.21.0.tar.gz"
  sha256 "27e93a5439090486a2f2f5a9b02cbbd1493e3c14affbbe2375ed57f8f903e677"
  license "Apache-2.0"
  head "https://github.com/aws/amazon-ecs-cli.git"

  bottle do
    sha256 cellar: :any_skip_relocation, big_sur:      "8187369aca2df5729df9a721097041d54858c9740c515f15fb05cd940a3a67f6"
    sha256 cellar: :any_skip_relocation, catalina:     "67f9ed0ea2931923798d0066b322c4fce84f868c45c5c78fbea985317c453256"
    sha256 cellar: :any_skip_relocation, mojave:       "8531ed09d9fbdcae96adebe4057aa099556d961c355a1b0179b1c50957f40e91"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2d8bc9d634da02643139b4a1129faa3b3006cd786c64e9aa43ff15795c8428a4"
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/aws/amazon-ecs-cli").install buildpath.children
    cd "src/github.com/aws/amazon-ecs-cli" do
      system "make", "build"
      bin.install "bin/local/ecs-cli"
      prefix.install_metafiles
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ecs-cli -v")
  end
end
