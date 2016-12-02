# 群会话
# https://open-doc.dingtalk.com/docs/doc.htm?spm=a219a.7629140.0.0.f6sqZD&treeId=172&articleId=104977&docType=1

module Dingding
  class Chat
    extend Dingding::MessageBody

    class << self
      CREATE_PATH = '/chat/create'.freeze
      SEND_PATH   = '/chat/send'.freeze
      GET_PATH    = '/chat/get'.freeze
      UPDATE_PATH = '/chat/update'.freeze

      def get(chatid)
        Http.dget GET_PATH, chatid: chatid
      end

      def create(name, owner_id, user_id)
        Http.dpost CREATE_PATH, name: name, owner: owner_id, useridlist: user_id
      end

      # opts[:name]            String : chat name,     eg: 'xxx'
      # opts[:owner]           String : chat owner id, eg: '10020202'
      # opts[:add_useridlist]  Array  : add user id,   eg: ['10020202']
      # opts[:del_useridlist]  Array  : del user id,   eg: ['10020202']
      def update(chatid, opts = {})
        Http.dpost UPDATE_PATH, {chatid: chatid}.merge(opts)
      end

      # six types for transmit
      # transmit(chatid, sender, 'text', {content: 'text'})
      # transmit(chatid, sender, 'image', {media_id: 'MEDIA_ID'})
      # transmit(chatid, sender, 'voice', {media_id: 'MEDIA_ID', duration: "10"})
      # transmit(chatid, sender, 'file', {media_id: 'MEDIA_ID'})
      # transmit(chatid, sender, 'link',
      #           {
      #             "title": "测试", "text": "测试",
      #             "picUrl":"https://gw.alicdn.com/tps/TB1FN16LFXXXXXJXpXXXXXXXXXX-256-130.png",
      #             "messageUrl": "http://www.dingtalk.com"
      #          })
      # transmit(chatid, sender, 'oa', {})
      def transmit(chatid, sender, type, opts = {})
        Http.dpost SEND_PATH, {chatid: chatid, sender: sender}.merge(send("content_for_#{type}".to_sym, opts))
      end

    end
  end
end
