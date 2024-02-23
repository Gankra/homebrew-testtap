class CargodisttestCustom < Formula
  desc "💬 a CLI for learning to distribute CLIs in rust"
  version "0.5.0"
  on_macos do
    on_arm do
      url "https://gankra.artifacts.axodotdev.host/cargodisttest/ax_Vk5E8GBnq7kF-u62zw1lg/cargodisttest-aarch64-apple-darwin.tar.gz"
      sha256 "3ac161f9e2464cc2e6b4337fc4ad0cc880825da25fc18cde73ce3e2c91c2a7d3"
    end
    on_intel do
      url "https://gankra.artifacts.axodotdev.host/cargodisttest/ax_Vk5E8GBnq7kF-u62zw1lg/cargodisttest-x86_64-apple-darwin.tar.gz"
      sha256 "15abb6b01e762e8f706d4a6b4def880730f4419d2a7339c70d15693e3d2bc8d4"
    end
  end
  on_linux do
    on_intel do
      url "https://gankra.artifacts.axodotdev.host/cargodisttest/ax_Vk5E8GBnq7kF-u62zw1lg/cargodisttest-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5e88049fa721cd09eb70123990023e56a3b77dcf8bc30205ae2fd78ad847e13d"
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
