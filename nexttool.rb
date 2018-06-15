HOMEBREW_NEXTTOOL_VERSION="1.2.1.r5"
class Nexttool < Formula
  homepage "http://bricxcc.sourceforge.net/"
  url "http://bricxcc.sourceforge.net/nexttool_osx.zip"
  sha256 "7d455fe10191f06cbccd69075449041663c7e98fed917f49d18f24ca1f87f6d6"
  version HOMEBREW_NEXTTOOL_VERSION

  def install
    bin.install Dir["nexttool"]
  end
end
