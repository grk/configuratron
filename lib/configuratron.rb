require "configuratron/version"
require "configuratron/blank_slate"

class Configuratron
  def initialize
    @config = ConfigHash.new
  end

  def [](key)
    @config[key]
  end

  def []=(key, value)
    @config[key] = value
  end

  def method_missing(name, *args, &block)
    @config.__send__(name, *args, &block)
  end

  class ConfigHash < BlankSlate
    def initialize(hash = nil)
      @hash = {}
      if hash
        hash.each do |k,v|
          @hash[k] = v.is_a?(Hash) ? ConfigHash.new(v) : v
        end
      end
    end

    def []=(k, v)
      @hash[k] = v.is_a?(Hash) ? ConfigHash.new(v) : v
    end

    def [](k)
      @hash[k]
    end

    def method_missing(name, *args, &block)
      if name.to_s[-1..-1] == '=' # workaround for 1.8 returning char
        base_name = name.to_s[0..-2].intern.to_sym
        _singleton_class.instance_exec(name) do |name|
          define_method(name) do |value|
            __send__ :[]=, base_name, value
          end
        end
        __send__ :[]=, base_name, *args
      else
        _singleton_class.instance_exec(name) do |name|
          define_method(name) do
            __send__(:[], name.to_sym)
          end
        end
        __send__ :[], name.to_sym
      end
    end

    private
    def _singleton_class
      class << self
        self
      end
    end
  end
end
