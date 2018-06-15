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
  version 'v2161'
  sha256 'a6fb8fd3ac69938692551be789f8615c4d8e1cc791306e93a9c5fbeb8bbd484a'
  url "http://sourceforge.net/projects/lejos-osek/files/nxtOSEK/nxtOSEK_#{version}.zip/download", :using => UnarDownloadStrategy

  resource 'sam7_ecrobot.lds' do
    sha256 '4b2ff524be5beb71e00e7d53ff98d90dace9a5f9cd92241006763df40e66b107'
    url 'http://lejos-osek.sourceforge.net/installation_mac_files/sam7_ecrobot.lds', :using => :nounzip
  end

  depends_on 'unar' => :build
  depends_on 'gcc-arm-none-eabi'
  depends_on 'nexttool'

  def install
    # http://lejos-osek.sourceforge.net/installation_Mac_OS_X_Lion.htm
    prefix.install Dir["nxtOSEK/*"]
    (prefix/'ecrobot/c').install resource('sam7_ecrobot.lds')
    system 'sed', '-i', '', 's!GNUARM_ROOT = /cygdrive/C/cygwin/GNUARM!GNUARM_ROOT = /usr/local/opt/gcc-arm-none-eabi!g', "#{prefix}/ecrobot/tool_gcc.mak"
    system 'sed', '-i', '', 's!NEXTTOOL_ROOT = /cygdrive/C/cygwin/nexttool!NEXTTOOL_ROOT = /usr/local/nexttool/bin!g', "#{prefix}/ecrobot/tool_gcc.mak"
    system 'sed', '-i', '', 's!NEXTTOOL  = NeXTTool.exe!NEXTTOOL  = nexttool!g', "#{prefix}/ecrobot/tool_gcc.mak"
    system 'sed', '-i', '', 's!APPFLASH  = appflash.exe!APPFLASH  = appflash!g', "#{prefix}/ecrobot/tool_gcc.mak"
    system 'sed', '-i', '', 's!RAMBOOT   = ramboot.exe!RAMBOOT   = fwexec!g', "#{prefix}/ecrobot/tool_gcc.mak"
    system 'sed', '-i', '', 's!TARGET_PREFIX :=arm-elf!TARGET_PREFIX :=arm-none-eabi!g', "#{prefix}/ecrobot/tool_gcc.mak"
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
