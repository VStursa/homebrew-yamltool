class Yamltool < Formula
  desc "Command-line utility for reading, querying, and manipulating YAML files"
  homepage "https://gitlab.seznam.net/vojtech.stursa/tool_yamltool"
  license "MIT"
  head "https://gitlab.seznam.net/vojtech.stursa/tool_yamltool.git", branch: "main"

  on_macos do
    if Hardware::CPU.arm?
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/yamltool/yamltool-v1.0.24-arm64-apple-darwin.tar.gz"
      sha256 "5d26da5461e4ab2cc59d88e396c3bad229aa7127f63fac82d4dac3eece75eb72"
    else
      url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/yamltool/yamltool-v1.0.24-x86_64-apple-darwin.tar.gz"
      sha256 "0f693f03e4bfe6737a6ed0ec19f66a8ee63ad923e7aee88ce57b0400e680ce68"
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
    assert_match "v1.0.24", shell_output("#{bin}/yamltool --version")
  end
end
