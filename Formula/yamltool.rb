class Yamltool < Formula
  desc "Command-line utility for reading, querying, and manipulating YAML files"
  homepage "https://gitlab.seznam.net/vojtech.stursa/tool_yamltool"
  license "MIT"
  head "https://gitlab.seznam.net/vojtech.stursa/tool_yamltool.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/yamltool/yamltool-v1.0.18-arm64-apple-darwin.tar.gz"
      sha256 "5166813d883ff309c45041c229ff57e8463c24a647d777ce5147935dc12332d3"
    else
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/yamltool/yamltool-v1.0.18-x86_64-apple-darwin.tar.gz"
      sha256 "f41eda2312572788717d7c7c75da15dbc360b34ad6bbbf0d01c15c537f2d5aa6"
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
    assert_match "v1.0.18", shell_output("#{bin}/yamltool --version")
  end
end
