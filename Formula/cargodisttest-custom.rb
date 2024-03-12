class CargodisttestCustom < Formula
  desc "💬 a CLI for learning to distribute CLIs in rust"
  version "0.6.3"
  on_macos do
    on_arm do
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.6.3/cargodisttest-aarch64-apple-darwin.tar.gz"
      sha256 "a492334edfe83c4f12c34999ad5d2c68565d47d341d3457da7fd9393b582e827"
    end
    on_intel do
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.6.3/cargodisttest-x86_64-apple-darwin.tar.gz"
      sha256 "5382d00af6e2fe25b1da79560f61778766c2f9d75dcf12f3e9f8b29c369c3f8b"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/Gankra/cargodisttest/releases/download/v0.6.3/cargodisttest-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "99869bf00c60e50782611ae3af34a311778693d16c7520e82bd336a7009e9a94"
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
