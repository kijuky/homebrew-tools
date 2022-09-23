class LineNotify < Formula
  desc "LINE Notify CLI."
  homepage "https://github.com/kijuky/line-notify"
  version "0.1.5"
  license "MIT"

  url "https://github.com/kijuky/line-notify/releases/download/0.1.5/line-notify.tar.gz"
  sha256 "bdd796493381640990c3a2c5f587716fe1f6b0e133c9968a4922559de047b00c"

  def install
    bin.install "line-notify"
  end
end
