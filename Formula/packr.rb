class Packr < Formula
  desc "Easy way to embed static files into Go binaries"
  homepage "https://github.com/gobuffalo/packr"
  url "https://github.com/gobuffalo/packr/archive/v2.8.1.tar.gz"
  sha256 "648f8690e0349039300d3603708bd383f3568193ebaeb0760a87da8760dc7fa7"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, big_sur:      "4b36cf364f3a9c6dc7b7a3b27994172723baf660ce61e6ac8adfcee924d7f6f9"
    sha256 cellar: :any_skip_relocation, catalina:     "0db108db4960e2bd9472f3497e43ee03f7ac26dfaeabc8ff895383a2c8d182d3"
    sha256 cellar: :any_skip_relocation, mojave:       "680ec6e6b1b0f1c089e643692dcc38856cec7bb97da64839cc7b1cad28739d61"
    sha256 cellar: :any_skip_relocation, high_sierra:  "ca3ad8d799b9ef78f28279f1d5eae59fd6eacf43a874fab09d202659cfd6a7fb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "283a5a151cc191bb2f12b0e4462835247601f6d1f00287145329b5e0472b40a7"
  end

  depends_on "go" => [:build, :test]

  def install
    system "go", "build", *std_go_args, "./packr"
  end

  test do
    mkdir_p testpath/"templates/admin"

    (testpath/"templates/admin/index.html").write <<~EOS
      <!doctype html>
      <html lang="en">
      <head>
        <title>Example</title>
      </head>
      <body>
      </body>
      </html>
    EOS

    (testpath/"main.go").write <<~EOS
      package main

      import (
        "fmt"
        "log"

        "github.com/gobuffalo/packr"
      )

      func main() {
        box := packr.NewBox("./templates")

        s, err := box.FindString("admin/index.html")
        if err != nil {
          log.Fatal(err)
        }

        fmt.Print(s)
      }
    EOS

    system "go", "mod", "init", "example"
    system bin/"packr"
    system "go", "build"
    system bin/"packr", "clean"

    assert_equal File.read("templates/admin/index.html"), shell_output("./example")
  end
end
