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
        base_name = name.to_s[0..-2].to_sym
        _define_singleton_method(name) do |name|
          __send__ :[]=, base_name, value
        end
        __send__ :[]=, base_name, *args
      else
        _define_singleton_method(name) do
          __send__(:[], name.to_sym)
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

    def _singleton_exec(*args, &block)
      _singleton_class.instance_exec(*args, &block)
    end

    def _define_singleton_method(name, &block)
      _singleton_exec(name) do |name|
        define_method(name, &block)
      end
    end
  end
end
