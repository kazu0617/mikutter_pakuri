# -*- coding: utf-8 -*-
Plugin.create :mikutter_pakuri do
  command(:rtpakuri,
          name: "ふぁぼぱく",
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
    str=message.to_s
    Post.primary_service.update(:message => str,:replyto => message[:replyto])
  end
end
