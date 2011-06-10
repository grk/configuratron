require "spec_helper"

describe Configuratron do
  before(:each) do
    @c = Configuratron.new
  end

  context "hash-like access" do
    it "should return nil for missing keys" do
      @c[:key].should be_nil
    end

    it "should set value for new keys" do
      @c[:key] = :value
      @c[:key].should eql(:value)
    end
  end

  context "method access" do
    it "should return nil for missing keys" do
      @c.key.should be_nil
    end

    it "should set value for new keys" do
      @c.key = :value
      @c.key.should eql(:value)
    end
  end
end
