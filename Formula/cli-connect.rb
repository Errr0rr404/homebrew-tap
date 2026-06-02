class CliConnect < Formula
  desc "Control your Mac, Windows, or Linux terminal from your iPhone or Android phone"
  homepage "https://github.com/Errr0rr404/cli-connect"
  # Homebrew installs the prebuilt binary straight from the published npm
  # tarball. After each `npm publish`, bump url + version here and set sha256 to
  # the SHA-256 of the registry tarball:
  #   curl -fsSL <url> | shasum -a 256
  # then mirror this file into the Errr0rr404/homebrew-tap repo.
  url "https://registry.npmjs.org/@worldofz/cli-connect/-/cli-connect-0.1.4.tgz"
  version "0.1.4"
  sha256 "da8961e8a7602082bc8a8a6011b6c8e2b3c7914e54a3f91f512b75a0d92c89db"
  license "MIT"

  def install
    if OS.mac?
      arch = Hardware::CPU.arm? ? "arm64" : "x64"
      bin.install "bin/darwin-#{arch}/cli-connect"
    elsif OS.linux?
      arch = Hardware::CPU.arm? ? "arm64" : "x64"
      bin.install "bin/linux-#{arch}/cli-connect"
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
    assert_match "cli-connect", shell_output("#{bin}/cli-connect --help 2>&1")
  end
end
