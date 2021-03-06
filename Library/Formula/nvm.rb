class Nvm < Formula
  homepage "https://github.com/creationix/nvm"
  url "https://github.com/creationix/nvm/archive/v0.25.2.tar.gz"
  sha256 "ae3f0320071eaf347437adaf55d776342abefe3e1d991e9a6aa9ce718b4f0593"
  head "https://github.com/creationix/nvm.git"

  resource "nvm-exec" do
    url "https://raw.githubusercontent.com/creationix/nvm/v0.25.2/nvm-exec"
    sha256 "a0581795f10114b9759992a82a43496daf4b4a52ad381a3072d8eee9866a28c5"
  end

  def install
    prefix.install "nvm.sh"
    bash_completion.install "bash_completion" => "nvm"

    resource("nvm-exec").stage do
      prefix.install("nvm-exec")
      chmod 0755, "#{prefix}/nvm-exec"
    end
  end

  def caveats; <<-EOS.undent
      Add NVM's working directory to your $HOME path (if it doesn't exist):

        mkdir ~/.nvm

      Copy nvm-exec to NVM's working directory

        cp $(brew --prefix nvm)/nvm-exec ~/.nvm/

      Add the following to $HOME/.bashrc, $HOME/.zshrc, or your shell's
      equivalent configuration file:

        export NVM_DIR=~/.nvm
        source $(brew --prefix nvm)/nvm.sh

      Type `nvm help` for further information.
    EOS
  end
end
