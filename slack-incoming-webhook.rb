class SlackIncomingWebhook < Formula
  desc "Slack Incoming-Webhook CLI."
  homepage "https://github.com/kijuky/slack-incoming-webhook"
  version "0.1.1"
  license "MIT"

  url "https://github.com/kijuky/slack-incoming-webhook/releases/download/0.1.1/slack-incoming-webhook.zip"
  sha256 "322b22bb6b0b31380b1d525109af5ecf38bbe8802ecb12339e4aaf63c054d3f8"

  def install
    bin.install "slack-incoming-webhook"
  end
end
