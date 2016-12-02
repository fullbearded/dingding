module Dingding
  module MessageBody
    MESSAGE_TYPE = %i(text file link image voice oa).freeze
    private

    MESSAGE_TYPE.each do |type|
      define_method "content_for_#{type}" do |opts|
        {msgtype: type, type => opts}
      end
    end
  end
end