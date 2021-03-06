class Gitleaks < Formula
  desc "Audit git repos for secrets"
  homepage "https://github.com/zricethezav/gitleaks"
  url "https://github.com/zricethezav/gitleaks/archive/v7.2.1.tar.gz"
  sha256 "28bfebd78d339d49cc1868dc4623e549496fa2e818b612db0accd0a4744050ef"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "41e4097ab29734e49632106cf4646a7677cad530f65a88ecd55f2b4acbf0ca67"
    sha256 cellar: :any_skip_relocation, big_sur:       "0654e0aafff56b13b390e1401ba0c123331645d37fe348855b80e4d28f7cf75a"
    sha256 cellar: :any_skip_relocation, catalina:      "e726e79c0c48a11a9e9cfa4a75bceb5b448b3ec6c7185ffb388b8c154de09d1d"
    sha256 cellar: :any_skip_relocation, mojave:        "55a716a644169734208180b99a6e0752f3b7f8f2fe2b944892a23010662865ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dcac2a2c8d1ea76c1bc72880f3844718c47e440e5eaf7f9e72649ec1bd82b5b9"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-X github.com/zricethezav/gitleaks/v#{version.major}/version.Version=#{version}",
                 *std_go_args
  end

  test do
    output = shell_output("#{bin}/gitleaks -r https://github.com/gitleakstest/emptyrepo.git 2>&1", 1)
    assert_match "level=info msg=\"cloning... https://github.com/gitleakstest/emptyrepo.git\"", output
    assert_match "level=error msg=\"remote repository is empty\"", output

    assert_equal version, shell_output("#{bin}/gitleaks --version")
  end
end
