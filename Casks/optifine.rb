cask 'optifine' do
  version '1.19.4_HD_U_I4'
  sha256 '30f881a65048b884f8d0908232fcb5a6eb2edb26998ed5fb1a0c6fca2a0ffede'

  url 'https://optifine.net/downloadx?f=OptiFine_1.19.4_HD_U_I4.jar&x=ac65931b4beade0a273604d3e99d3df9'
  name 'OptiFine'
  homepage 'https://optifine.net/home'

  depends_on cask: 'minecraft'

  postflight do
    system_command 'java', args: [ '-cp', "#{@cask.download}", 'optifine.Installer' ]
  end

  caveats do
    depends_on_java
  end
end
