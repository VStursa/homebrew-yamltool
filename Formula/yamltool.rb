class Yamltool < Formula
  desc "Command-line utility for reading, querying, and manipulating YAML files"
  homepage "https://gitlab.seznam.net/vojtech.stursa/tool_yamltool.git"
  license "MIT"
  head "https://gitlab.seznam.net/vojtech.stursa/tool_yamltool.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/yamltool/yamltool-v1.0.25-arm64-apple-darwin.tar.gz"
      sha256 "c970e0fbc92d05019f6781f066ce06930ea73ae2ba2c58eed4bab5ea5a15d354"
    else
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/yamltool/yamltool-v1.0.25-x86_64-apple-darwin.tar.gz"
      sha256 "58dcebf15295a2bad734cafcbe3ad4b5c359ac896de9de4846aebceaf53a398a"
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
    assert_match "v1.0.25", shell_output("#{bin}/yamltool --version")
  end
end
