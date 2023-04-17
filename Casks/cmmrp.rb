cask "cmmrp" do
  version '1.0-1.19.1'
  sha256 '18a1358247a2114794a5d4efe7dfdbac8b2d4c6890a9922d9badbfddffcf28aa'

  url 'https://mediafilez.forgecdn.net/files/3934/271/CMMRP+Release+1.0+-+%5B1.19+-+1.19.1%5D.zip'
  name 'Cute Mob Models Resource Pack (Official Java Port)'
  homepage 'https://www.curseforge.com/minecraft/texture-packs/cute-mob-models-resource-pack'

  depends_on cask: 'optifine'

  postflight do
    system_command 'mv', args: [ "#{@cask.download}" ] << "#{Dir.home}/Library/Application Support/minecraft/resourcepacks"
  end
end
