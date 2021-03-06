class Juju < Formula
  desc "DevOps management tool"
  homepage "https://juju.is/"
  url "https://github.com/juju/juju.git",
      tag:      "juju-2.8.7",
      revision: "ee2cfeb2c8c716af763a011e184ddea879c0985d"
  license "AGPL-3.0-only"
  version_scheme 1
  head "https://github.com/juju/juju.git"

  livecheck do
    url :stable
    regex(/^juju[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "db336d2998265f523d77ae773691137d8524f27bad5d1500d291619324994288"
    sha256 cellar: :any_skip_relocation, big_sur:       "75f2094e43822dc5e817cfe205e7bcd5a43d307cf38edefcbad475d55d948fea"
    sha256 cellar: :any_skip_relocation, catalina:      "cb2e85deb8ea65f5bfacf7516796be7e572860eb5e821caed4f6f0bec12fe82a"
    sha256 cellar: :any_skip_relocation, mojave:        "72ac63fc890000b160adbf747f795dcfee2b76226adaba3d0580e05647c46a11"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7132126f45542d24000fbfd74b4d7848b184e3486dc853f77f9faca22e686f94"
  end

  depends_on "go" => :build

  def install
    ld_flags = %W[
      -s -w
      -X version.GitCommit=#{Utils.git_head}
      -X version.GitTreeState=clean
    ]
    system "go", "build", *std_go_args,
                 "-ldflags", ld_flags.join(" "),
                 "./cmd/juju"
    system "go", "build", *std_go_args,
                 "-ldflags", ld_flags.join(" "),
                 "-o", bin/"juju-metadata",
                 "./cmd/plugins/juju-metadata"
    bash_completion.install "etc/bash_completion.d/juju"
  end

  test do
    system "#{bin}/juju", "version"
    assert_match "No controllers registered", shell_output("#{bin}/juju list-users 2>&1", 1)
    assert_match "No controllers registered", shell_output("#{bin}/juju-metadata list-images 2>&1", 2)
  end
end
