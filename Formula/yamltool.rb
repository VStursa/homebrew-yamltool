class Yamltool < Formula
  desc "Command-line utility for reading, querying, and manipulating YAML files"
  homepage "https://gitlab.seznam.net/vojtech.stursa/tool_yamltool"
  license "MIT"
  head "https://gitlab.seznam.net/vojtech.stursa/tool_yamltool.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/yamltool/yamltool-v1.0.20-arm64-apple-darwin.tar.gz"
      sha256 "8d993f7ad21199a46bf03c88617b717854db9bb322cb76e765806578d5219a96"
    else
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/yamltool/yamltool-v1.0.20-x86_64-apple-darwin.tar.gz"
      sha256 "2a88e67c1e48bd1ac096e39232469dc875061113c660eeff0743fc58e03d90be"
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
    assert_match "v1.0.20", shell_output("#{bin}/yamltool --version")
  end
end
