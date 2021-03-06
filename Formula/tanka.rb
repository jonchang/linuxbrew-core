class Tanka < Formula
  desc "Flexible, reusable and concise configuration for Kubernetes using Jsonnet"
  homepage "https://tanka.dev"
  url "https://github.com/grafana/tanka.git",
      tag:      "v0.13.0",
      revision: "291814d05e298c296a954d8912bce34796e17a3c"
  license "Apache-2.0"
  head "https://github.com/grafana/tanka.git"

  bottle do
    sha256 cellar: :any_skip_relocation, big_sur:      "9b470a925b2fb43d4fa08f7798bd3c5e0ce9ab54841d71f969c33af12f09f612"
    sha256 cellar: :any_skip_relocation, catalina:     "a37f3718e66f5944930c4b7c0268f9e57c65a86327663080d438ef01fcd5c198"
    sha256 cellar: :any_skip_relocation, mojave:       "3b2759ab2b1f4c85543ca6badf31a60a2e6682037f8a4a88950bcd59efd2f532"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bd799eb5c3b607aa2123b088d56166106a1f0bc43db09dc214f54c8d36c295ab"
  end

  depends_on "go" => :build
  depends_on "kubernetes-cli"

  def install
    system "make", "static"
    bin.install "tk"
  end

  test do
    system "git", "clone", "https://github.com/sh0rez/grafana.libsonnet"
    system "#{bin}/tk", "show", "--dangerous-allow-redirect", "grafana.libsonnet/environments/default"
  end
end
