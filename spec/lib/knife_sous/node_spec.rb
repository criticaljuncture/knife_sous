require 'spec_helper'

describe KnifeSous::Node do
  describe "#initialize" do
    it "should set the name that was passed in" do
      KnifeSous::Node.new('Node-Fuu').name.should == 'Node-Fuu'
    end

    it "should convert symbols to strings" do
      KnifeSous::Node.new(:node_tastic).name.should == 'node_tastic'
    end

    it "should accept config arguments as a hash" do
      options_hash = {ssh_config: 'stuff', other_something: 'foo' }
      KnifeSous::Node.new(:node_tastic, options_hash).config.should == options_hash
    end
  end

  describe "#update_config" do
    it "should merge config options" do
     node =  KnifeSous::Node.new(:node_tastic, foo: 'bar', baz: 'stuff')
     node.update_config(baz: 'new stuff')
     node.config.should == { foo: 'bar', baz: 'new stuff' }
    end
  end

  describe "config hash" do
    it "should sanitize hash keys" do
      KnifeSous::Node.new(:node_tastic, 'fOO-BAr' => 'baz').config.keys.should =~ [:foo_bar]
    end
  end

  describe "#method_missing" do
    it "should try to access from config hash" do
      KnifeSous::Node.new(:node_tastic, foo_bar: 'baz').foo_bar.should == 'baz'
    end

    it "should return nil if config doesn't exist" do
      KnifeSous::Node.new(:node_tastic).foo_bar.should == nil
    end
  end
end

