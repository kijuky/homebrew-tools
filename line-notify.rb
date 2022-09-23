class LineNotify < Formula
  desc "LINE Notify CLI."
  homepage "https://github.com/kijuky/line-notify"
  version "0.1.4"
  license "MIT"

  url "https://github.com/kijuky/line-notify/releases/download/0.1.4/line-notify.tar.gz"
  sha256 "0ae5a12f10f9513cb2a58d44be3cd69d027a155abc10b10f86607cde2e2e93f7"

  def install
    bin.install "line-notify"
  end
end
