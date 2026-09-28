class GitRg < Formula
  desc "Remote ripgrep for GitHub and GitLab without cloning repository history"
  homepage "https://github.com/SamuelSupe/git-rg"
  version "0.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.6.0/git-rg_v0.6.0_darwin_arm64.tar.gz"
      sha256 "7c65ab0aecc3c80047445113bc1e6a1a7de97340f19029a548555496b616543b"
    elsif Hardware::CPU.intel?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.6.0/git-rg_v0.6.0_darwin_amd64.tar.gz"
      sha256 "ae7ef2472a5b09c730f0aacfbf7215a3a710021a6b5bf2761715405eeed2048a"
    else
      odie "git-rg provides prebuilt macOS packages for arm64 and Intel only"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.6.0/git-rg_v0.6.0_linux_arm64.tar.gz"
      sha256 "0bb05df6e80c9735cc7a5ca351d5bec9ec63cb60b429ad4f631f4793fdae139e"
    elsif Hardware::CPU.intel?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.6.0/git-rg_v0.6.0_linux_amd64.tar.gz"
      sha256 "dba65954217c43670d83a2468d17c2c74f66c0cf2427109c9297699f1d72d594"
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
