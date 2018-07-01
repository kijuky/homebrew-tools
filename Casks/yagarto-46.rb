cask 'yagarto-46' do
  version '20111119'
  sha256 '770dd75a0c6c032029a04f9a0268da2a7439035ed31c1078eed555a5841064e1'

  url 'https://sourceforge.net/projects/yagarto/files/YAGARTO%20for%20Mac%20OS%20X/20111119/yagarto-bu-2.21_gcc-4.6.2-c-c%2B%2B_nl-1.19.0_gdb-7.3.1_eabi_intelmac_20111119.dmg/download'
  name 'yagarto (gcc 4.6)'
  homepage 'http://www.yagarto.org/index.html'

  installer script: 'yagarto-4.6.2.app/Contents/MacOS/7zX-SEA'
end
