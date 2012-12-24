# -*- coding: utf-8 -*-
Plugin.create(:pakuri) do
  command(:pakuri,
          name: "ぱくる",
          condition: Plugin::Command[:CanReplyAll],
          visible: true,
          role: :timeline ) do |m|
    m.messages.map do |msg|
      pakuri(msg.message)
    end
  end
  def pakuri(message)
    name=message.idname
    message.favorite(true)
    message.retweet
    str=message.to_s
    Post.primary_service.update(:message => str,:replyto => message[:replyto])
    Post.primary_service.update(:message => "pakuri.rbによりhttp://twitter.com/#!/#{name}/status/#{message.id}をパクリました")
  end
end
