require 'spec_helper'

require 'forwarder/meta'
require 'ostruct'

describe FForwarder::Meta do
  let :forwardee do
    Class.new do
      def a; OpenStruct.new.tap{|x| x.b = OpenStruct.new.tap{ |y| y.hello = 42 } } end 
    end
  end

  subject do
    described_class.new forwardee, FForwarder::Arguments.new( :hello, to_chain: %w{a b} )
  end
  it "forwards correctly" do
    subject.forward_chain
    forwardee.new.hello.should eq( 42 )
  end
end # describe Forwarder::Meta
