require 'spec_helper'

require 'forwarder/meta'
require 'ostruct'

describe Forwarder::Meta do
  let :forwardee do
    Class.new do
      def a; "abc" end 
    end
  end

  describe "params without translation" do
    subject do
      described_class.new forwardee, Forwarder::Arguments.new( :[], to: :a, with: 1 )
    end
    it "forwards correctly" do
      subject.forward
      forwardee.new[].should eq( "b" )
    end
  end # describe "params without translation"

  describe "params with translation" do
    subject do
      described_class.new forwardee, Forwarder::Arguments.new( :get, to: :a, with: 1, as: :[] )
    end
    it "forwards correctly" do
      subject.forward
      forwardee.new.get.should eq( "b" )
    end
  end # describe "params without translation"
end # describe Forwarder::Meta

