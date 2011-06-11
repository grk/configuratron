require "spec_helper"

describe Configuratron::Configurable do
  context "included" do
    class A
      include Configuratron::Configurable
    end

    before(:all) do
      @a = A.new
    end

    it "should define config for instances" do
      @a.should respond_to(:config)
      @a.config.should be_a(Configuratron)
    end

    it "should not define config for class" do
      A.should_not respond_to(:config)
    end
  end

  context "extended" do
    class B
      extend Configuratron::Configurable
    end

    before(:all) do
      @b = B.new
    end

    it "should not define config for instances" do
      @b.should_not respond_to(:config)
    end

    it "should define config for class" do
      B.should respond_to(:config)
      B.config.should be_a(Configuratron)
    end
  end
end
