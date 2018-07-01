cask 'yagarto' do
  version '20121222'
  sha256 'a996758d2836c06bca9b78fc7128f7ae5e0352ce2dc5b5157848e810052b103e'

  url 'https://sourceforge.net/projects/yagarto/files/YAGARTO%20for%20Mac%20OS%20X/20121222/yagarto-bu-2.23.1_gcc-4.7.2-c-c%2B%2B_nl-1.20.0_gdb-7.5.1_eabi_intelmac_20121222.dmg/download'
  name 'yagarto'
  homepage 'http://www.yagarto.org/index.html'

  installer script: 'yagarto-4.7.2.app/Contents/MacOS/7zX-SEA'
end
