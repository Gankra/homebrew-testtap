class CargodisttestCustom < Formula
  desc "💬 a CLI for learning to distribute CLIs in rust"
  version "0.6.4"
  on_macos do
    on_arm do
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.6.4/cargodisttest-aarch64-apple-darwin.tar.gz"
      sha256 "a253c38cf336e1a9be8ab993d1975b780063a41e793e70d8883e8fd1de6e8b64"
    end
    on_intel do
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.6.4/cargodisttest-x86_64-apple-darwin.tar.gz"
      sha256 "c724042bc55c303f405d73fdb4331f2a4134eeca0cf82917bf2a9236d7d4767a"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.6.4/cargodisttest-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c4520d06ba80a8ef0f0a04744586d2ae5abb45c86879524f067642da73f31ccb"
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
