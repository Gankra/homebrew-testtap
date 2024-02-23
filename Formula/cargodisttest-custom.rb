class CargodisttestCustom < Formula
  desc "💬 a CLI for learning to distribute CLIs in rust"
  version "0.5.1"
  on_macos do
    on_arm do
      url "https://gankra.artifacts.axodotdev.host/cargodisttest/ax_uU6DENXwTOnagwbEVSdqu/cargodisttest-aarch64-apple-darwin.tar.gz"
      sha256 "74a5fd31c88df52a44d58594f5b70fe2af541f07234c6edfe86e9848282d01de"
    end
    on_intel do
      url "https://gankra.artifacts.axodotdev.host/cargodisttest/ax_uU6DENXwTOnagwbEVSdqu/cargodisttest-x86_64-apple-darwin.tar.gz"
      sha256 "b4cb094d968e99261b9e2003d1532641fafe1677cf07553d6c0c940214638f95"
    end
  end
  on_linux do
    on_intel do
      url "https://gankra.artifacts.axodotdev.host/cargodisttest/ax_uU6DENXwTOnagwbEVSdqu/cargodisttest-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "052ba48e6f6e33e02fe0dc2167078b740e741cfcd9ed1b2a90db36318e958fff"
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
