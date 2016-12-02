# 企业会话消息接口
# https://open-doc.dingtalk.com/docs/doc.htm?spm=a219a.7629140.0.0.18DAu1&treeId=172&articleId=104973&docType=1

module Dingding
  class Message
    extend Dingding::MessageBody

    SEND_PATH = '/message/send'.freeze

    class << self
      # six types for transmit
      # transmit(chatid, 'text', {touser: 'xxx'}, {content: 'text'})
      # transmit(chatid, 'image', {touser: 'xxx'}, {media_id: 'MEDIA_ID'})
      # transmit(chatid, 'voice', {touser: 'xxx'}, {media_id: 'MEDIA_ID', duration: "10"})
      # transmit(chatid, 'file', {touser: 'xxx'}, {media_id: 'MEDIA_ID'})
      # transmit(chatid, 'link', {touser: 'xxx'},
      #           {
      #             "title": "测试", "text": "测试",
      #             "picUrl":"https://gw.alicdn.com/tps/TB1FN16LFXXXXXJXpXXXXXXXXXX-256-130.png",
      #             "messageUrl": "http://www.dingtalk.com"
      #          })
      # transmit(chatid, sender, 'oa', {})
      def transmit(agent_id, type, opts = {}, content = {})
        Http.dpost SEND_PATH, {agentid: agent_id}.merge(opts).merge(send("content_for_#{type}".to_sym, content))
      end
    end
  end
end

