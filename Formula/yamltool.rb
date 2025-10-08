class Yamltool < Formula
  desc "Command-line utility for reading, querying, and manipulating YAML files"
  homepage "https://gitlab.seznam.net/vojtech.stursa/tool_yamltool"
  url "https://gitlab.seznam.net/vojtech.stursa/tool_yamltool/-/archive/v1.0.1/tool_yamltool-v1.0.1.tar.gz"
  sha256 "1f30fe11d53a3dd4ff565612419f3c5c6220264833d6a93742eda367d7e040ad" # Will be filled after creating the release
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
    assert_match "1.0.1", shell_output("#{bin}/yamltool --version")
  end
end
