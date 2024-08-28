class Cargodisttest < Formula
  desc "💬 a CLI for learning to distribute CLIs in rust"
  homepage "https://github.com/Gankra/cargodisttest"
  version "0.20.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.20.5/cargodisttest-aarch64-apple-darwin.tar.gz"
      sha256 "d25629dfec1d2347c6ff0a8d612c0753089e2832c5f10d0acbea5df164139a06"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.20.5/cargodisttest-x86_64-apple-darwin.tar.gz"
      sha256 "7d7556db338b095ef50e89611a4652edaa7c289be4c183a9c7340f7a9e0c8759"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/Gankra/cargodisttest/releases/download/v0.20.5/cargodisttest-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "2cf3d4213e06ac9855f32437d91b20db736c9c709cd4107970962901234a6819"
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
    "x86_64-unknown-linux-gnu": {},
  }.freeze

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
    bin.install "cargodisttest" if OS.mac? && Hardware::CPU.arm?
    bin.install "cargodisttest" if OS.mac? && Hardware::CPU.intel?
    bin.install "cargodisttest" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
