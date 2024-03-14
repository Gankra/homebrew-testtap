class CargodisttestCustom < Formula
  desc "💬 a CLI for learning to distribute CLIs in rust"
  version "0.6.5"
  on_macos do
    on_arm do
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.6.5/cargodisttest-aarch64-apple-darwin.tar.gz"
      sha256 "d0e5ac805246a1f6a7e0714935ee1e4d68ee07fe43e08014136c3a5bdd64a366"
    end
    on_intel do
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.6.5/cargodisttest-x86_64-apple-darwin.tar.gz"
      sha256 "7ea0cf905a78d354691bd5bed388c4f7ff4137c9ddd75077129555232420ab96"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.6.5/cargodisttest-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3a63651ed3a4aaee61fb49851e2599026e7bcd708fc202b0043791cf98188490"
    end
  end
  license "MIT OR Apache-2.0"

  def install
    on_macos do
      on_arm do
        bin.install "cargodisttest"
      end
    end
    on_macos do
      on_intel do
        bin.install "cargodisttest"
      end
    end
    on_linux do
      on_intel do
        bin.install "cargodisttest"
      end
    end

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
