require "spec_helper"

describe Configuratron::ConfigHash do
  %w(instance_variable_get is_a? methods).each do |m|
    if RUBY18
      Configuratron::ConfigHash.reveal(m)
    else
      Configuratron::ConfigHash.reveal(m.to_sym)
    end
  end

  if defined?(RUBY_ENGINE) && RUBY_ENGINE == "rbx"
    Configuratron::ConfigHash.reveal("singleton_methods")
    Configuratron::ConfigHash.reveal("kind_of?")
  end

  before(:each) do
    @ch = Configuratron::ConfigHash.new
  end

  context "when created" do
    it "should be empty" do
      @ch.instance_variable_get(:@hash).should be_empty
    end
  end

  context "keys" do
    it "should return nil for missing key" do
      @ch[:missing_key].should be_nil
    end

    it "should set value for new key" do
      @ch[:new_key] = :value
      @ch.instance_variable_get(:@hash)[:new_key].should eql(:value)
    end

    it "should return value for existing key" do
      @ch.instance_variable_get(:@hash)[:existing_key] = :value
      @ch[:existing_key].should eql(:value)
    end
  end

  context "method access" do
    it "should return nil for missing key" do
      @ch.missing_key.should be_nil
    end

    it "should set value for new key" do
      @ch.new_key = :value
      @ch.instance_variable_get(:@hash)[:new_key].should eql(:value)
    end

    it "should return value for existing key" do
      @ch.instance_variable_get(:@hash)[:existing_key] = :value
      @ch.existing_key.should eql(:value)
    end
  end

  context "hash keys" do
    it "should convert hash keys to self class" do
      @ch[:hash_key] = {:new => :hash}
      @ch[:hash_key].should be_a(Configuratron::ConfigHash)
    end

    it "should convert nested hash keys recursively" do
      @ch[:nested_hash] = {:root => {:nested => :value}}
      @ch[:nested_hash].should be_a(Configuratron::ConfigHash)
      @ch[:nested_hash][:root].should be_a(Configuratron::ConfigHash)
    end

    it "should access nested hash keys by methods" do
      @ch.nested_hash = {:root => {:nested => :value}}
      @ch.nested_hash.should be_a(Configuratron::ConfigHash)
      @ch.nested_hash.root.should be_a(Configuratron::ConfigHash)
      @ch.nested_hash.root.nested.should eql(:value)
    end
  end

  context "defining methods on method_missing" do
    it "should not have instance methods defined before first call" do
      @ch.methods.should_not include(RUBY18 ? "test_key" : :test_key)
      @ch.methods.should_not include(RUBY18 ? "test_key=" : :test_key=)
    end

    it "should have instance methods defined after first call" do
      @ch.test_key
      @ch.methods.should include(RUBY18 ? "test_key" : :test_key)

      @ch.test_key = :value
      @ch.methods.should include(RUBY18 ? "test_key=" : :test_key=)
    end
  end
end
