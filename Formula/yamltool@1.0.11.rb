class Yamltool < Formula
  desc "Command-line utility for reading, querying, and manipulating YAML files"
  homepage "https://gitlab.seznam.net/vojtech.stursa/tool_yamltool"
  url "https://sbrowser.dev.dnsz.cz/vojtech.stursa/artefacts/yamltool/yamltool-1.0.11.tar.gz"
  sha256 "b9e2f5c84d45b40b415b77743bb56467b8755ce24b059f123fc874bee9d66ecc" # Will be filled after creating the release
  license "MIT"
  head "https://gitlab.seznam.net/vojtech.stursa/tool_yamltool.git", branch: "main"

  depends_on xcode: ["14.0", :build]

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/YAMLTool" => "yamltool"
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
    assert_match "1.0.11", shell_output("#{bin}/yamltool --version")
  end
end
