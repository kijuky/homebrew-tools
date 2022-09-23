class LineNotify < Formula
  desc "LINE Notify CLI."
  homepage "https://github.com/kijuky/line-notify"
  version "0.1.3"
  license "MIT"

  url "https://github.com/kijuky/line-notify/releases/download/0.1.3/line-notify.tar.gz"
  sha256 "d298a81b683db6f0d5e5584e492ce04421fdeb673a84b6727a5bf33ac6f4673b"

  def install
    bin.install "line-notify"
  end
end
