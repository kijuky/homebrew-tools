cask "cmmsp" do
  version '1.19.4'
  sha256 '72141ea83805c7f98c25afec503b0c3ecf34f5bc8ee0a6672c146a34b22a180f'

  url 'https://download1505.mediafire.com/0bt5nqunyfsguX16CRCW89jZleDZYiZp_AHsfgiajIzzIMAgJ1ai5fWJatv6-dqtd1Alx2MYH3YlDpiq5dSwquQ6ANXV/2wh9ldvehq6431v/Cute+Mob+Model+Sounds.zip'
  name 'Sound Pack - CUTE MOB MODELS (1.19!)'
  homepage 'https://www.planetminecraft.com/texture-pack/voice-for-cute-mob-models-female-mob-voices/'

  depends_on cask: 'cmmrp'

  postflight do
    system_command 'mv', args: [ "#{@cask.download}" ] << "#{Dir.home}/Library/Application Support/minecraft/resourcepacks"
  end
end
