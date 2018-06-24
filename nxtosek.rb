class Nxtosek < Formula
  class UnarDownloadStrategy < CurlDownloadStrategy
    def stage
      case type = cached_location.compression_type
      when :zip
        quiet_safe_system 'unar', cached_location
      else
        super
      end
    end
  end

  homepage 'https://sourceforge.net/projects/lejos-osek/'
  #version 'v2161'
  #sha256 'a6fb8fd3ac69938692551be789f8615c4d8e1cc791306e93a9c5fbeb8bbd484a'
  version 'v218'
  sha256 '702a740aa747cb5f912074d4590dfae09c26b777252f3599a227c81168b90a8f'
  url "http://sourceforge.net/projects/lejos-osek/files/nxtOSEK/nxtOSEK_#{version}.zip/download", :using => UnarDownloadStrategy

  resource 'sam7_ecrobot.lds' do
    sha256 '4b2ff524be5beb71e00e7d53ff98d90dace9a5f9cd92241006763df40e66b107'
    url 'http://lejos-osek.sourceforge.net/installation_mac_files/sam7_ecrobot.lds', :using => :nounzip
  end

  resource 'toppers_osek' do
    sha256 '30a4641bff8b88445df9dd614fb094675481ebb10180dff47a72fd9491a960e9'
    url 'http://www.toppers.jp/download.cgi/osek_os-1.1.lzh'
  end

  depends_on 'lha' => :build
  depends_on 'unar' => :build
  depends_on 'gcc-arm-none-eabi'
  depends_on 'nexttool'
  depends_on 'wine'

  def install
    # http://lejos-osek.sourceforge.net/installation_Mac_OS_X_Lion.htm
    prefix.install Dir["nxtOSEK/*"]
    #resource('sam7_ecrobot.lds').stage { mv 'sam7_ecrobot.lds', prefix/'ecrobot/c' }
    resource('toppers_osek').stage { mv 'toppers_osek/sg/sg.exe', prefix/'toppers_osek/sg' }
    #system 'sed', '-i', '', 's!GNUARM_ROOT = /cygdrive/C/cygwin/GNUARM!GNUARM_ROOT = /usr/local/Caskroom/yagarto/20121222/yagarto-4.7.2!g', "#{prefix}/ecrobot/tool_gcc.mak"
    system 'sed', '-i', '', 's!GNUARM_ROOT = /cygdrive/C/cygwin/GNUARM!GNUARM_ROOT = /usr/local/opt/gcc-arm-none-eabi!g', "#{prefix}/ecrobot/tool_gcc.mak"
    system 'sed', '-i', '', 's!NEXTTOOL_ROOT = /cygdrive/C/cygwin/nexttool!NEXTTOOL_ROOT = /usr/local/opt/nexttool/bin!g', "#{prefix}/ecrobot/tool_gcc.mak"
    system 'sed', '-i', '', 's!NEXTTOOL  = NeXTTool.exe!NEXTTOOL  = nexttool!g', "#{prefix}/ecrobot/tool_gcc.mak"
    system 'sed', '-i', '', 's!APPFLASH  = appflash.exe!APPFLASH  = appflash!g', "#{prefix}/ecrobot/tool_gcc.mak"
    system 'sed', '-i', '', 's!RAMBOOT   = ramboot.exe!RAMBOOT   = fwexec!g', "#{prefix}/ecrobot/tool_gcc.mak"
    system 'sed', '-i', '', 's!TARGET_PREFIX :=arm-elf!TARGET_PREFIX :=arm-none-eabi!g', "#{prefix}/ecrobot/tool_gcc.mak"
    system 'sed', '-i', '', 's!WINECONSOLE := /Applications/Wine.app/Contents/MacOS/startwine wineconsole!WINECONSOLE := /usr/local/opt/wine/bin/wineconsole!g', "#{prefix}/ecrobot/ecrobot.mak"
    system 'sed', '-i', '', 's!WINECONSOLE := /Applications/Wine.app/Contents/MacOS/startwine wineconsole!WINECONSOLE := /usr/local/opt/wine/bin/wineconsole!g', "#{prefix}/ecrobot/ecrobot++.mak"
    system 'make', '-C', "#{prefix}/ecrobot/c++", 'all'
    system 'make', '-C', "#{prefix}/ecrobot/c++", 'release'
    system 'make', '-C', "#{prefix}/ecrobot/c", 'all'
    system 'make', '-C', "#{prefix}/ecrobot/c", 'release'
    system 'make', '-C', "#{prefix}/ecrobot/bios", 'all'
    system 'make', '-C', "#{prefix}/ecrobot/bios", 'release'
    system 'make', '-C', "#{prefix}/ecrobot/nxtway_gs_balancer", 'all'
    system 'make', '-C', "#{prefix}/ecrobot/nxtway_gs_balancer", 'release'
  end
end
