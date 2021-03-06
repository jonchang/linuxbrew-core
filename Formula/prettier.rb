require "language/node"

class Prettier < Formula
  desc "Code formatter for JavaScript, CSS, JSON, GraphQL, Markdown, YAML"
  homepage "https://prettier.io/"
  url "https://registry.npmjs.org/prettier/-/prettier-2.2.1.tgz"
  sha256 "8a1c8e42a692691469bd57b6a44369f0c4e661ff5b6527b30e5598517b06d238"
  license "MIT"
  head "https://github.com/prettier/prettier.git"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d9b64844714a25d33344ae68af32131f6c0eaa883bb02072d868d047de98b36a"
    sha256 cellar: :any_skip_relocation, big_sur:       "cc0490eacc3a11e2f4b20ee9e56d85df64c7f95cee6811539b73e21b94417561"
    sha256 cellar: :any_skip_relocation, catalina:      "6f6364f7a63a4eab3f1cc1fd51a7fd3c3c62fb0a17c1ffd5d583b294cc435558"
    sha256 cellar: :any_skip_relocation, mojave:        "617d2fdfe6caf2cb7fb83621e6e7da49dd477a8d9672305d1ccd4a0aa9100338"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bc08a4e60557aae53c42f50343b537b518e074012fb70f74f71622e75fd9ec0f"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"test.js").write("const arr = [1,2];")
    output = shell_output("#{bin}/prettier test.js")
    assert_equal "const arr = [1, 2];", output.chomp
  end
end
