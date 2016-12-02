module Dingding
  class Exception < RuntimeError
  end

  class MissingArgsError < RuntimeError
    def initialize(missing_keys)
      key_list = missing_keys.map(&:to_s).join(' and the ')
      super("You did not provide both required args. Please provide the #{key_list}.")
    end
  end

  class InvalidArgsError < RuntimeError
    def initialize(invalid_keys)
      key_list = invalid_keys.map(&:to_s).join(' and the ')
      super("#{key_list} should not be empty.")
    end
  end

  class InvalidAccessToken < RuntimeError
    def initialize
      super('invalid access token')
    end
  end
end
