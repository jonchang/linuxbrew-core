class OsmPbf < Formula
  desc "Tools related to PBF (an alternative to XML format)"
  homepage "https://wiki.openstreetmap.org/wiki/PBF_Format"
  url "https://github.com/scrosby/OSM-binary/archive/v1.5.0.tar.gz"
  sha256 "2abf3126729793732c3380763999cc365e51bffda369a008213879a3cd90476c"
  license "LGPL-3.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "5cfaf02637be652c5d7913288a576961c1d6bd9bf67c7818196c18aff0bda149"
    sha256 cellar: :any_skip_relocation, big_sur:       "cde905f5e30549acb2e9d002b95e8ebbf581aa078108abddc2e8a645329ffa71"
    sha256 cellar: :any_skip_relocation, catalina:      "a61abe978818b7abd27cf0716204b24cc0135f2589298b63d7cad95577d2550f"
    sha256 cellar: :any_skip_relocation, mojave:        "16ba12db1cc49ec09169e8463cdac17edeefb91ef7a32ff0eaa62556bfc409a0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4e9f3892dd20ce64f59809f7e0227038f40bcc01d6fb5202e2266f98f5f86ac1"
  end

  depends_on "cmake" => :build
  depends_on "protobuf"

  uses_from_macos "zlib"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    pkgshare.install "resources/sample.pbf"
  end

  test do
    assert_match "OSMHeader", shell_output("#{bin}/osmpbf-outline #{pkgshare}/sample.pbf")
  end
end
