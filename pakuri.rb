# -*- coding: utf-8 -*-
Plugin.create(:pakuri) do
  filter_command do |menu|
    menu[:pakuri] = {
      :slug => :pakuri,
      :name => "ぱくる",
      :condition => lambda{|m| m.message.repliable?},
      :exec => lambda{|m| pakuri(m.message) },
      :visible => true,
      :role => :message
    }
    [menu]
  end
  def pakuri(message)
    name=message.idname
    message.favorite(true)
    message.retweet
    str=message.to_s
    if message[:replyto]
      Post.primary_service.update(:message => str, :replyto => message[:replyto])
    else
      Post.primary_service.update(:message => str)
    end
    Post.primary_service.update(:message => "pakuri.rbによりhttp://twitter.com/#!/#{name}/status/#{message.id}をパクリました")
  end
end
