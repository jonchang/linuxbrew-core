class Voroxx < Formula
  desc "3D Voronoi cell software library"
  homepage "http://math.lbl.gov/voro++"
  url "http://math.lbl.gov/voro++/download/dir/voro++-0.4.6.tar.gz"
  sha256 "ef7970071ee2ce3800daa8723649ca069dc4c71cc25f0f7d22552387f3ea437e"
  revision 1

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "fe957e10239223b1027bb38058a9b6275af5b11bef45ec2c92ad6e718c48df87"
    sha256 cellar: :any_skip_relocation, big_sur:       "36e9ac6de84545992490e09c1ff6202988bafc4e99a164907338d3117bcefe3c"
    sha256 cellar: :any_skip_relocation, catalina:      "d3e73665fab068af530be8c745fbe03498a3d2060110264e99e17935f0980581"
    sha256 cellar: :any_skip_relocation, mojave:        "cd60116a442b685c8275ba23f64fd453b01b517247d0a7c969d3b4fe5a7ae706"
    sha256 cellar: :any_skip_relocation, high_sierra:   "72c8a07d26abe320651fb74425c67baecd8044e23f2951d86704c8dba88f3871"
    sha256 cellar: :any_skip_relocation, sierra:        "9d522e672d8f551439c18b536e0ca2d0dc94a6036722eba12bbaba37d2aa3428"
    sha256 cellar: :any_skip_relocation, el_capitan:    "b10e4cccc62a7fff1a34c6f80174e2f62cb12dfcaf2782b2c81cc567f0928943"
    sha256 cellar: :any_skip_relocation, yosemite:      "d7ce06fd7ebd51a8a592c2409f80eae0bbc6a5fc0d906ffa324534c805249af1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5d85269b238071c06300df8766e1f8b3f58b8c87cc1bf05e50bcf2cb2657060d"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
    pkgshare.install("examples")
    mv prefix/"man", share/"man"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include "voro++.hh"
      double rnd() { return double(rand())/RAND_MAX; }
      int main() {
        voro::container con(0, 1, 0, 1, 0, 1, 6, 6, 6, false, false, false, 8);
        for (int i = 0; i < 20; i++) con.put(i, rnd(), rnd(), rnd());
        if (fabs(con.sum_cell_volumes() - 1) > 1.e-8) abort();
        con.draw_cells_gnuplot("test.gnu");
      }
    EOS
    system ENV.cxx, "test.cpp", "-I#{include}/voro++", "-L#{lib}",
                    "-lvoro++"
    system "./a.out"
    assert_predicate testpath/"test.gnu", :exist?
  end
end
