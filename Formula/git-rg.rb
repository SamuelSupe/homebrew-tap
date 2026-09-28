class GitRg < Formula
  desc "Remote ripgrep for GitHub and GitLab without cloning repository history"
  homepage "https://github.com/SamuelSupe/git-rg"
  version "0.7.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.7.0/git-rg_v0.7.0_darwin_arm64.tar.gz"
      sha256 "655c23f8e6be3fff03ea491618f8f15447b16b3678e6e8763b723c743f7f1afb"
    elsif Hardware::CPU.intel?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.7.0/git-rg_v0.7.0_darwin_amd64.tar.gz"
      sha256 "d4a32ca40630d9c3b39bbe038c299944f162ce6bfa95867e3b9125ddf57c7355"
    else
      odie "git-rg provides prebuilt macOS packages for arm64 and Intel only"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.7.0/git-rg_v0.7.0_linux_arm64.tar.gz"
      sha256 "a1b893064ee1fc6e5f2a532245e36e56d5c61b315680456e744d46cb02f37f07"
    elsif Hardware::CPU.intel?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.7.0/git-rg_v0.7.0_linux_amd64.tar.gz"
      sha256 "2a7df3226212aef7575b475f7184760bad8c09d184a14f8e832fde68730fe931"
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
