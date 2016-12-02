require 'httparty'
module Dingding
  class Http
    include ::HTTParty

    format :json
    headers 'Content-Type' => 'application/json'
    debug_output Dingding.config.debug ? $stderr : nil

    default_timeout 5

    parser proc { |data|
      JSON.parse(data).symbolize_keys
    }

    METHODS = %i(get post put delete head).freeze

    METHODS.each do |method|
      define_singleton_method method do |path, options = {}, &block|
        Dingding.request_for do
          perform_request "Net::HTTP::#{method.capitalize}".constantize, path, options, &block
        end
      end
    end

    class << self
      def dpost(path, parameters)
        post Dingding.request_uri(path), body: parameters.to_json
      end

      def dget(path, parameters)
        get Dingding.request_uri(path), query: parameters
      end
    end
  end
end
