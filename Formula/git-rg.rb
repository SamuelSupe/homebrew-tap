class GitRg < Formula
  desc "Remote ripgrep for GitHub and GitLab without cloning repository history"
  homepage "https://github.com/SamuelSupe/git-rg"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.5.0/git-rg_v0.5.0_darwin_arm64.tar.gz"
      sha256 "e24623810cd0a02f3b6be4ed54d1397b0972b845e2d7e0af034f0d5c73d478ef"
    elsif Hardware::CPU.intel?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.5.0/git-rg_v0.5.0_darwin_amd64.tar.gz"
      sha256 "973fe56fd92d8cc2860466edc0f32c8ee5117f509b04239ca987d82f2013c966"
    else
      odie "git-rg provides prebuilt macOS packages for arm64 and Intel only"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.5.0/git-rg_v0.5.0_linux_arm64.tar.gz"
      sha256 "75e03bed41ed17f98900fa4aaec6e1ccc9ea430ceeec8590c3b7afb8ce436df0"
    elsif Hardware::CPU.intel?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.5.0/git-rg_v0.5.0_linux_amd64.tar.gz"
      sha256 "edb8bae1e72a58e903f9d7b50db7a6ba646ed08b7bcabb11e277c29648bdf747"
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
