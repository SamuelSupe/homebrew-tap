class GitRg < Formula
  desc "Remote ripgrep for GitHub and GitLab without cloning repository history"
  homepage "https://github.com/SamuelSupe/git-rg"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.4.0/git-rg_v0.4.0_darwin_arm64.tar.gz"
      sha256 "3f0c243e6792e5389859280dc14626365b0ad2945a9868b34be4c897e45434cb"
    elsif Hardware::CPU.intel?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.4.0/git-rg_v0.4.0_darwin_amd64.tar.gz"
      sha256 "3c1e31b845d8a8ca4c76d0ffc26903ca98f40ba8845772c4d9db45fd36e43453"
    else
      odie "git-rg provides prebuilt macOS packages for arm64 and Intel only"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.4.0/git-rg_v0.4.0_linux_arm64.tar.gz"
      sha256 "f6665402a16649f1c9df1ef1d044956a0aae57dcc2741ec2391f0113d9cab1cd"
    elsif Hardware::CPU.intel?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.4.0/git-rg_v0.4.0_linux_amd64.tar.gz"
      sha256 "c34f1c8bb4cceec4971bfbeb89ab2039c1e7f16f9451dd0611125df0bbe87133"
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
