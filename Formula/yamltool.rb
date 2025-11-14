class Yamltool < Formula
  desc "Command-line utility for reading, querying, and manipulating YAML files"
  homepage "https://gitlab.seznam.net/vojtech.stursa/tool_yamltool.git"
  license "MIT"
  head "https://gitlab.seznam.net/vojtech.stursa/tool_yamltool.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/yamltool/yamltool-v1.0.28-arm64-apple-darwin.tar.gz"
      sha256 "0f58fe33955245225f4469e5d7c73421cdd622bfa01b4aeb322e32f91684cbbf"
    else
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/yamltool/yamltool-v1.0.28-x86_64-apple-darwin.tar.gz"
      sha256 "ff1db66a21c05ac6a1589f5848c7b7585cfa223383ab5403f37963dbb6c707d8"
    end
  end

  def install
    bin.install "yamltool"
  end

  test do
    # Test basic functionality
    (testpath/"test.yaml").write <<~EOS
      name: Test
      version: 1.0
      items:
        - first
        - second
    EOS

    # Test query
    output = shell_output("#{bin}/yamltool #{testpath}/test.yaml -q name")
    assert_match "Test", output

    # Test version
    assert_match "v1.0.28", shell_output("#{bin}/yamltool --version")
  end
end
