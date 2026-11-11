class GitRg < Formula
  desc "Remote ripgrep for GitHub and GitLab without cloning repository history"
  homepage "https://github.com/SamuelSupe/git-rg"
  version "0.8.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.8.0/git-rg_v0.8.0_darwin_arm64.tar.gz"
      sha256 "63cf2334057a8e025e66aea53848a1b894d40c47622c4547f845b634f7906a5a"
    elsif Hardware::CPU.intel?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.8.0/git-rg_v0.8.0_darwin_amd64.tar.gz"
      sha256 "84fec96d5dc803479c410924fb1aa07c3a91d227df3152a54ac12599ac599cff"
    else
      odie "git-rg provides prebuilt macOS packages for arm64 and Intel only"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.8.0/git-rg_v0.8.0_linux_arm64.tar.gz"
      sha256 "6bac61fd0b66f6463f47ca239ff9f717e0b84fba837e884931d33e0805421934"
    elsif Hardware::CPU.intel?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.8.0/git-rg_v0.8.0_linux_amd64.tar.gz"
      sha256 "f3f0b9c0215455731381e9588c1b52e98f6d081d0ae394f4877ecd1d6f4f0df7"
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
