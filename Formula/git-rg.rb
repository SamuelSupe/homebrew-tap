class GitRg < Formula
  desc "Remote ripgrep for GitHub and GitLab without cloning repository history"
  homepage "https://github.com/SamuelSupe/git-rg"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.3.0/git-rg_v0.3.0_darwin_arm64.tar.gz"
      sha256 "58dc5c8d402a7ea1bd23f4f31beb292e6a3b70c2b5912b3b178c6aa22e9ce6af"
    elsif Hardware::CPU.intel?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.3.0/git-rg_v0.3.0_darwin_amd64.tar.gz"
      sha256 "ae0723c4447c2f9b10055a651b9483c9634fa3dec6b6757081d212a1f190b32d"
    else
      odie "git-rg provides prebuilt macOS packages for arm64 and Intel only"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.3.0/git-rg_v0.3.0_linux_arm64.tar.gz"
      sha256 "39bd1dce511ff59ba281ae8f5fb357dbe897c6a35e70ac0736cc82ab6c4a3a0e"
    elsif Hardware::CPU.intel?
      url "https://github.com/SamuelSupe/git-rg/releases/download/v0.3.0/git-rg_v0.3.0_linux_amd64.tar.gz"
      sha256 "593497bda3b7b9db12f2532f5865ec06a8fbd9a1c04dec95cc9172bd77a9f808"
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
