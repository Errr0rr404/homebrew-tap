class CliConnect < Formula
  desc "Control your Mac or Windows terminal from your iPhone"
  homepage "https://github.com/Errr0rr404/cli-connect"
  url "https://registry.npmjs.org/@worldofz/cli-connect/-/cli-connect-0.1.0.tgz"
  version "0.1.0"
  sha256 "08c573df9f02fea3b087d41b93982666424265c305e3027367fd57dadbc157d1"
  license "MIT"

  def install
    if OS.mac?
      arch = Hardware::CPU.arm? ? "arm64" : "x64"
      bin.install "bin/darwin-#{arch}/cli-connect"
    elsif OS.linux?
      odie "Linux ARM not supported yet" unless Hardware::CPU.intel?
      bin.install "bin/linux-x64/cli-connect"
    else
      odie "Unsupported OS"
    end
  end

  def caveats
    <<~EOS
      Pair this machine with your iPhone:

        cli-connect login

      Then start the agent:

        cli-connect serve

      Auto-start at login (macOS):

        bash <(curl -fsSL https://raw.githubusercontent.com/Errr0rr404/cli-connect/master/scripts/install-launchd-mac.sh)
    EOS
  end

  test do
    assert_match "cli-connect", shell_output("#{bin}/cli-connect --help 2>&1", 2)
  end
end
