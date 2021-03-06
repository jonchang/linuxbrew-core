class Ghz < Formula
  desc "Simple gRPC benchmarking and load testing tool"
  homepage "https://ghz.sh"
  url "https://github.com/bojand/ghz/archive/v0.90.0.tar.gz"
  sha256 "fbfd832bd81d4ae5b9bcd90b6a441dcfcd63e6519eda16dcab6282ddb06cbc8f"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e036f4eca74aeebf2df2136d695e23ccc8600af00bc379193d9c3f985254aa3e"
    sha256 cellar: :any_skip_relocation, big_sur:       "36338f86d67670825bd89e765a9945fe54f460df6d62dfe8b2d010acd3db18bb"
    sha256 cellar: :any_skip_relocation, catalina:      "f7b379a8f131ecd42c92ebda60b7a7bf78b67f76f719de5dcdd5ab01846b1eb2"
    sha256 cellar: :any_skip_relocation, mojave:        "c619d11138b2ae31dd637fdeae1788294b4abc4f008b9c9ea31f503105d6ce26"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "55c46a974a2c50b96e137c2e887e6c42b528b794a45dbea84c47bd4e6c5b1720"
  end

  depends_on "go" => :build

  def install
    system "go", "build",
      "-ldflags", "-s -w -X main.version=#{version}",
      *std_go_args,
      "cmd/ghz/main.go"
    prefix.install_metafiles
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ghz -v 2>&1")
    (testpath/"config.toml").write <<~EOS
      proto = "greeter.proto"
      call = "helloworld.Greeter.SayHello"
      host = "0.0.0.0:50051"
      insecure = true
      [data]
      name = "Bob"
    EOS
    assert_match "open greeter.proto: no such file or directory",
      shell_output("#{bin}/ghz --config config.toml 2>&1", 1)
  end
end
