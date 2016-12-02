module Dingding
  class Exception < RuntimeError
  end

  class MissingArgsError < Exception
    def initialize(missing_keys)
      key_list = missing_keys.map {|key| key.to_s}.join(' and the ')
      super("You did not provide both required args. Please provide the #{key_list}.")
    end
  end

  class InvalidArgsError < Exception
    def initialize(invalid_keys)
      key_list = invalid_keys.map {|key| key.to_s}.join(' and the ')
      super("#{key_list} should not be empty.")
    end
  end

  class InvalidAccessToken < Exception
    def initialize
      super('invalid access token')
    end
  end
end
