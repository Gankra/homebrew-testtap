class CargodisttestCustom < Formula
  desc "💬 a CLI for learning to distribute CLIs in rust"
  homepage "https://github.com/Gankra/cargodisttest"
  version "0.7.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.7.3/cargodisttest-aarch64-apple-darwin.tar.gz"
      sha256 "32d8c98feaa4bef88560fe5a3e592578649b705c91ace5d7e58de5edaebd284f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.7.3/cargodisttest-x86_64-apple-darwin.tar.gz"
      sha256 "7d557e1f8592611cc72053ab07bce3b6fded97e823936280353c26f4261880cc"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.7.3/cargodisttest-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c3c173d288331f712e8d00fd8681e78a7f7c2e3612d2de1535bc1cec9f7b7ed5"
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
