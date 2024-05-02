class CargodisttestCustom < Formula
  desc "💬 a CLI for learning to distribute CLIs in rust"
  homepage "https://github.com/Gankra/cargodisttest"
  version "0.7.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.7.2/cargodisttest-aarch64-apple-darwin.tar.gz"
      sha256 "d65c4ab410b4089fccc685bbad98f84e8211e63befe9a634da3144d5a25f7c09"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.7.2/cargodisttest-x86_64-apple-darwin.tar.gz"
      sha256 "7778513c6bbb0148b620e427ec9a61d2b4f2a52e864bd14c6605a32a1bc823cf"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.7.2/cargodisttest-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a56db11d1cdc4d158c50b495658cc52184d699d75f223afb24eea7b5ae67f4b4"
    end
  end
  license "MIT OR Apache-2.0"

  BINARY_ALIASES = {"aarch64-apple-darwin": {"cargodisttest": ["meowmeow", "supercoolcli"]}, "x86_64-apple-darwin": {"cargodisttest": ["meowmeow", "supercoolcli"]}, "x86_64-pc-windows-gnu": {"cargodisttest.exe": ["meowmeow.exe", "supercoolcli.exe"]}, "x86_64-unknown-linux-gnu": {"cargodisttest": ["meowmeow", "supercoolcli"]}, "x86_64-unknown-linux-musl-dynamic": {"cargodisttest": ["meowmeow", "supercoolcli"]}, "x86_64-unknown-linux-musl-static": {"cargodisttest": ["meowmeow", "supercoolcli"]}}

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "cargodisttest"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cargodisttest"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cargodisttest"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
