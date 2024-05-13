class Cargodisttest < Formula
  desc "💬 a CLI for learning to distribute CLIs in rust"
  homepage "https://github.com/Gankra/cargodisttest"
  version "0.20.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.20.0/cargodisttest-aarch64-apple-darwin.tar.gz"
      sha256 "99ea9b623da39e57b741ff326e86f7b169907466879c90d22623673a06232911"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.20.0/cargodisttest-x86_64-apple-darwin.tar.gz"
      sha256 "99c99e886ba314e2d4d815613b7bb0272a31ebb3c49447ae1b10d2601916eacb"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.20.0/cargodisttest-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2a35095a91488037c3dde51966d6850bf3c5ca1c669a775e22676453e8cc727e"
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
