begin
  require 'active_support/core_ext/string/inflections'
rescue LoadError
  class String
    def constantize
      names = self.split('::')
      names.shift if names.empty? || names.first.empty?

      constant = Object
      names.each do |name|
        constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
      end
      constant
    end
  end if !''.respond_to?(:constantize)
end

begin
  require 'active_support/core_ext/hash/keys'
  require 'active_support/core_ext/hash/deep_merge'
rescue LoadError
  class Hash
    def symbolize_keys
      keys.each do |key|
        self[(key.to_sym rescue key) || key] = delete(key)
      end
      self
    end if !{}.respond_to?(:symbolize_keys)
  end
end