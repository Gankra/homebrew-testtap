class Cargodisttest < Formula
  desc "💬 a CLI for learning to distribute CLIs in rust"
  homepage "https://github.com/Gankra/cargodisttest"
  version "0.20.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.20.4/cargodisttest-aarch64-apple-darwin.tar.gz"
      sha256 "b78f6fa7a59ae9188a00f75d311c44a09589c71a8f3f50144eec86738b58506b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.20.4/cargodisttest-x86_64-apple-darwin.tar.gz"
      sha256 "7a71a5e5c005db56efc95c65e54bdfcb335f6ce6d19f9f64b7ec32866d2c533d"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.20.4/cargodisttest-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ec968582122ad58c3cbcb8ea1123438a469ad355dd393d48000c6ee88814f41d"
    end
  end
  license "MIT OR Apache-2.0"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}}

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
