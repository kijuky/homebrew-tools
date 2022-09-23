class LineNotify < Formula
  desc "LINE Notify CLI."
  homepage "https://github.com/kijuky/line-notify"
  version "0.1.7"
  license "MIT"

  url "https://github.com/kijuky/line-notify/releases/download/0.1.7/line-notify.zip"
  sha256 "b3761d82077e207026d350707679e4761f8bfa32ee27a51904c70ea0fa6ff188"

  def install
    bin.install "line-notify"
  end
end
