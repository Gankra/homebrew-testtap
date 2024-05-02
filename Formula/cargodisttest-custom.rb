class CargodisttestCustom < Formula
  desc "💬 a CLI for learning to distribute CLIs in rust"
  homepage "https://github.com/Gankra/cargodisttest"
  version "0.7.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.7.1/cargodisttest-aarch64-apple-darwin.tar.gz"
      sha256 "11b3771cf89693613db14dafa8681a806d806baafd8253ce6122cf7afb38bef4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.7.1/cargodisttest-x86_64-apple-darwin.tar.gz"
      sha256 "6c9433d099afeb96599d13e1f11f1db1b09479f01ac79bf0d7921fdb8ae9f1fd"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.7.1/cargodisttest-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1a0ab28bf0b7b3f972d6724dd9ce9a9fdb97a26a39989784a4a61d34d2aa6ea8"
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
