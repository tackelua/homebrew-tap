class Portctl < Formula
  desc "Lightweight, zero-daemon, local-first Port Manager and automated Edge Ingress CLI"
  homepage "https://portctl.pages.dev"
  version "2.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/tackelua/portctl/releases/download/v2.1.0/portctl-v2.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "c9f68d55eebca09add933dc0a6226220fcce3866070bd5ecb0df59e989a40e1b"
    else
      url "https://github.com/tackelua/portctl/releases/download/v2.1.0/portctl-v2.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "a68c508e13ef4ac695aa3a1be1b6d61a81d68e8791166bbd41c60dde3911ec09"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/tackelua/portctl/releases/download/v2.1.0/portctl-v2.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ab0a3c12f7b6d9ed42d3046bc7dac49c6446131aa7f2241a61542526338e0d14"
    end
  end

  def install
    bin.install "portctl"

    # Install shell completions if supported
    output = Utils.safe_popen_read("#{bin}/portctl", "completion", "bash")
    (bash_completion/"portctl").write output

    output = Utils.safe_popen_read("#{bin}/portctl", "completion", "zsh")
    (zsh_completion/"_portctl").write output

    output = Utils.safe_popen_read("#{bin}/portctl", "completion", "fish")
    (fish_completion/"portctl.fish").write output
  end

  test do
    assert_match "portctl #{version}", shell_output("#{bin}/portctl --version")
  end
end
