class GitRg < Formula
  desc "Remote ripgrep for GitHub and GitLab without cloning repository history"
  homepage "https://github.com/SamuelSupe/git-rg"
  version "0.4.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.4.1/git-rg_v0.4.1_darwin_arm64.tar.gz"
      sha256 "ff95bb20f4b89fbbb752483ab351098777bbec32700e070a8a666c840d4f10cf"
    elsif Hardware::CPU.intel?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.4.1/git-rg_v0.4.1_darwin_amd64.tar.gz"
      sha256 "5ca5850805907815a8921cc9ce79059603648eef13c4a581cf786e17af23eea3"
    else
      odie "git-rg provides prebuilt macOS packages for arm64 and Intel only"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.4.1/git-rg_v0.4.1_linux_arm64.tar.gz"
      sha256 "cdadd6865ded54e37e89c5cf2587ff23bd6899ceed328a61763f059fcc11b4f0"
    elsif Hardware::CPU.intel?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.4.1/git-rg_v0.4.1_linux_amd64.tar.gz"
      sha256 "4e7b94ae1bc6f12614c27c86091bc7cbc80a7ae56c6e46cdb4686e4064a9a901"
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
