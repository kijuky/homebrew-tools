require "formula"

HOMEBREW_NEXTTOOL_VERSION="1.2.1.r5"
class Nexttool < Formula
  homepage "http://bricxcc.sourceforge.net/"
  url "https://github.com/kijuky/NeXTTool/archive/#{HOMEBREW_NEXTTOOL_VERSION}.tar.gz"
  sha256 "19a3734f27c6fa314c2eb5317c251b6c55037263e67a1f25c8c2d0cd4db4c0c7"
  version HOMEBREW_NEXTTOOL_VERSION

  def install
    bin.install Dir['bin/*']
  end
end
