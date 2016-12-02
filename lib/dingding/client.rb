module Dingding
  class Client
    attr_accessor :setting, :corp_id, :corp_secret

    REQUEST_OPTIONS_KEYS = [:corp_id, :corp_secret].freeze
    TOKEN_PATH = '/gettoken'.freeze
    ERROR_CODE_FOR_INVALID_ACCESS_TOKEN = 40_014

    def initialize
      @setting = Dingding.config.to_hash
      REQUEST_OPTIONS_KEYS.each do |opt|
        raise MissingArgsError, [opt] unless setting.key?(opt)
        raise InvalidArgsError, [opt] if setting[opt].nil?
        instance_variable_set("@#{opt}".to_sym, setting[opt])
      end
    end

    def token
      @@access_token ||= generate_token
    end

    def regenerate_token
      @@access_token = generate_token
    end

    def request_for
      try_time = 0
      begin
        res = yield
        raise InvalidAccessToken if invalid_access_token?(res.parsed_response[:errcode])
        res.parsed_response
      rescue InvalidAccessToken
        regenerate_token
        try_time += 1
        retry if try_time < 1
      end
    end

    def request_uri(path)
      "#{File.join(API_URL, path)}?access_token=#{token}"
    end

    private

    def generate_token
      Http.get(File.join(API_URL, TOKEN_PATH), query: {corpid: corp_id, corpsecret: corp_secret})[:access_token]
    end

    def invalid_access_token?(code)
      ERROR_CODE_FOR_INVALID_ACCESS_TOKEN == code
    end
  end
end
