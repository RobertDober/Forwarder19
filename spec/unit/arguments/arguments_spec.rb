require 'spec_helper'
require 'forwarder/arguments'

describe Forwarder::Arguments do
  let( :message ){ :a_message }
  let( :target  ){ :a_target  }

  subject do
    described_class.new( message, to: target )
  end

  it "has the correct message" do
    subject.message.should eq( message )
  end

  it "has the correct target" do
    subject.target.should eq( target )
  end
end # describe Forwarder::Arguments
