cask 'nxtosek' do
  version 'v218'
  sha256 '702a740aa747cb5f912074d4590dfae09c26b777252f3599a227c81168b90a8f'

  url "https://sourceforge.net/projects/lejos-osek/files/nxtOSEK/nxtOSEK_#{version}.zip/download"
  name 'nxtOSEK'
  homepage 'http://lejos-osek.sourceforge.net/jp/index.htm'

  depends_on formula: 'unar'
  depends_on formula: 'wine'
  depends_on cask: 'yagarto-46'

  # https://qiita.com/tac0x2a/items/b1d82050c660935765ef
  postflight do
    system_command '/bin/mv', args: Dir[ "#{staged_path}/nxtOSEK/*" ] << "#{staged_path}"
    system_command '/bin/rmdir', args: [ "#{staged_path}/nxtOSEK" ]

    # patch linker script
    require 'open-uri'
    open('http://lejos-osek.sourceforge.net/installation_mac_files/sam7_ecrobot.lds') { |file|
      open("#{staged_path}/ecrobot/c/sam7_ecrobot.lds", 'w') { |out|
        out.write(file.read)
      }
    }

    # extract sg.exe
    require 'open-uri'
    open('http://www.toppers.jp/download.cgi/osek_os-1.1.lzh') { |file|
      open("#{staged_path}/osek_os-1.1.lzh", 'w+b') { |out|
        out.write(file.read)
      }
      system_command '/usr/local/bin/unar', args: [ '-o', "#{staged_path}/osek_os-1.1", "#{staged_path}/osek_os-1.1.lzh" ]
      system_command '/bin/mv', args: [ "#{staged_path}/osek_os-1.1/toppers_osek/sg/sg.exe", "#{staged_path}/toppers_osek/sg" ]
      system_command '/bin/rm', args: [ "#{staged_path}/osek_os-1.1.lzh" ]
      system_command '/bin/rm', args: [ '-r', "#{staged_path}/osek_os-1.1" ]
    }

    # extract nexttool
    require 'open-uri'
    open('http://bricxcc.sourceforge.net/nexttool_osx.zip') { |file|
      open("#{staged_path}/nexttool_osx.zip", 'w+b') { |out|
        out.write(file.read)
      }
      system_command '/usr/bin/unzip', args: [ '-d', "#{staged_path}/bin", "#{staged_path}/nexttool_osx.zip" ]
      system_command '/bin/rm', args: [ "#{staged_path}/nexttool_osx.zip" ]
    }

    # modify tool_gcc.mak
    open("#{staged_path}/ecrobot/tool_gcc.mak.tmp", 'w') { |o|
      open("#{staged_path}/ecrobot/tool_gcc.mak").each { |line|
        o.puts line.gsub('GNUARM_ROOT = /cygdrive/C/cygwin/GNUARM', 'GNUARM_ROOT = /usr/local/Caskroom/yagarto-46/20111119/yagarto-4.6.2')
                   .gsub('NEXTTOOL_ROOT = /cygdrive/C/cygwin/nexttool', "NEXTTOOL_ROOT = #{staged_path}/bin")
                   .gsub('NEXTTOOL  = NeXTTool.exe', 'NEXTTOOL  = nexttool')
                   .gsub('APPFLASH  = appflash.exe', 'APPFLASH  = appflash')
                   .gsub('RAMBOOT   = ramboot.exe', 'RAMBOOT   = fwexec')
                   .gsub('TARGET_PREFIX :=arm-elf', 'TARGET_PREFIX :=arm-none-eabi')
      }
      system_command '/bin/mv', args: [ "#{staged_path}/ecrobot/tool_gcc.mak.tmp", "#{staged_path}/ecrobot/tool_gcc.mak" ]
    }

    # modify ecrobot.mak
    open("#{staged_path}/ecrobot/ecrobot.mak.tmp", 'w') { |o|
      open("#{staged_path}/ecrobot/ecrobot.mak").each { |line|
        o.puts line.gsub('WINECONSOLE := /Applications/Wine.app/Contents/MacOS/startwine wineconsole', 'WINECONSOLE := /usr/local/opt/wine/bin/wineconsole')
                   .gsub('$(shell cygpath -m -w ${TOPPERS_OSEK_OIL_SOURCE})', '${TOPPERS_OSEK_OIL_SOURCE}')
                   .gsub('$(shell cygpath -m -w ${TOPPERS_OSEK_ROOT_SG})', '${TOPPERS_OSEK_ROOT_SG}')
      }
      system_command '/bin/mv', args: [ "#{staged_path}/ecrobot/ecrobot.mak.tmp", "#{staged_path}/ecrobot/ecrobot.mak" ]
    }

    # modify ecrobot++.mak
    open("#{staged_path}/ecrobot/ecrobot++.mak.tmp", 'w') { |o|
      open("#{staged_path}/ecrobot/ecrobot++.mak").each { |line|
        o.puts line.gsub('WINECONSOLE := /Applications/Wine.app/Contents/MacOS/startwine wineconsole', 'WINECONSOLE := /usr/local/opt/wine/bin/wineconsole')
                   .gsub('$(shell cygpath -m -w ${TOPPERS_OSEK_OIL_SOURCE})', '${TOPPERS_OSEK_OIL_SOURCE}')
                   .gsub('$(shell cygpath -m -w ${TOPPERS_OSEK_ROOT_SG})', '${TOPPERS_OSEK_ROOT_SG}')
      }
      system_command '/bin/mv', args: [ "#{staged_path}/ecrobot/ecrobot++.mak.tmp", "#{staged_path}/ecrobot/ecrobot++.mak" ]
    }

    # make
    system_command '/usr/bin/make', args: [ '-C', "#{staged_path}/ecrobot/c++", 'all' ], print_stderr: false
    system_command '/usr/bin/make', args: [ '-C', "#{staged_path}/ecrobot/c++", 'release' ]
    system_command '/usr/bin/make', args: [ '-C', "#{staged_path}/ecrobot/c", 'all' ], print_stderr: false
    system_command '/usr/bin/make', args: [ '-C', "#{staged_path}/ecrobot/c", 'release' ]
    system_command '/usr/bin/make', args: [ '-C', "#{staged_path}/ecrobot/bios", 'all' ], print_stderr: false
    system_command '/usr/bin/make', args: [ '-C', "#{staged_path}/ecrobot/bios", 'release' ]
    system_command '/usr/bin/make', args: [ '-C', "#{staged_path}/ecrobot/nxtway_gs_balancer", 'all' ], print_stderr: false
    system_command '/usr/bin/make', args: [ '-C', "#{staged_path}/ecrobot/nxtway_gs_balancer", 'release' ]
  end
end
