class MathComp < Formula
  desc "Mathematical Components for the Coq proof assistant"
  homepage "https://math-comp.github.io/math-comp/"
  url "https://github.com/math-comp/math-comp/archive/mathcomp-1.12.0.tar.gz"
  sha256 "a57b79a280e7e8527bf0d8710c1f65cde00032746b52b87be1ab12e6213c9783"
  license "CECILL-B"
  revision 3
  head "https://github.com/math-comp/math-comp.git"

  bottle do
    sha256 cellar: :any_skip_relocation, big_sur:      "574f7ac4d0fa6500933d64af993125aae5a72cf0b2122f1a0068899015c079f7"
    sha256 cellar: :any_skip_relocation, catalina:     "df1c6f6e3143eb1c6d638526b7b61881cbf158b465ee0fca1a4ceceb8e4fa7ad"
    sha256 cellar: :any_skip_relocation, mojave:       "c41a2cb454c539430c5f154a0ebac436bfa370e9b8090049bda57eea8bb8ea87"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bcb9cf1736235c3ac7239b94f4ace8a9d184d860be9affdd1aec5044df96adc7"
  end

  depends_on "ocaml" => :build
  depends_on "coq"

  def install
    coqlib = "#{lib}/coq/"

    (buildpath/"mathcomp/Makefile.coq.local").write <<~EOS
      COQLIB=#{coqlib}
    EOS

    cd "mathcomp" do
      system "make", "Makefile.coq"
      system "make", "-f", "Makefile.coq", "MAKEFLAGS=#{ENV["MAKEFLAGS"]}"
      system "make", "install", "MAKEFLAGS=#{ENV["MAKEFLAGS"]}"

      elisp.install "ssreflect/pg-ssr.el"
    end

    doc.install Dir["docs/*"]
  end

  test do
    (testpath/"testing.v").write <<~EOS
      From mathcomp Require Import ssreflect seq.

      Parameter T: Type.
      Theorem test (s1 s2: seq T): size (s1 ++ s2) = size s1 + size s2.
      Proof. by elim : s1 =>//= x s1 ->. Qed.

      Check test.
    EOS

    coqc = Formula["coq"].opt_bin/"coqc"
    cmd = "#{coqc} -R #{lib}/coq/user-contrib/mathcomp mathcomp testing.v"
    assert_match /\Atest\s+: forall/, shell_output(cmd)
  end
end
