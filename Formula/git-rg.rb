class GitRg < Formula
  desc "Remote ripgrep for GitHub and GitLab without cloning repository history"
  homepage "https://github.com/SamuelSupe/git-rg"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.2.0/git-rg_v0.2.0_darwin_arm64.tar.gz"
      sha256 "62a791489881f9498e574e96b4e4fd494d670b9c598e478d62a93fa86885cddf"
    elsif Hardware::CPU.intel?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.2.0/git-rg_v0.2.0_darwin_amd64.tar.gz"
      sha256 "3b677a081231cd0d4e7cd9ed54c9384ae26de5dc7f6e7422c43258f16c9e7d28"
    else
      odie "git-rg provides prebuilt macOS packages for arm64 and Intel only"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.2.0/git-rg_v0.2.0_linux_arm64.tar.gz"
      sha256 "3196365bf47f9454f8cb88707bf76856d322f9c3f9e1e220042d96bdebc32af7"
    elsif Hardware::CPU.intel?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.2.0/git-rg_v0.2.0_linux_amd64.tar.gz"
      sha256 "53bd1cce20f35b3caf2a786de3d8d919e90b643e62ef51ceda5226fc1ebdeb19"
    else
      odie "git-rg provides prebuilt Linux packages for arm64 and Intel only"
    end
  end

  def install
    binary = Dir["git-rg", "git-rg_v#{version}_*/git-rg"].find { |path| File.file?(path) }
    raise "git-rg binary is missing from the release archive" unless binary

    bin.install binary => "git-rg"
  end

  test do
    assert_match "git-rg v#{version}", shell_output("#{bin}/git-rg --version")
  end
end
