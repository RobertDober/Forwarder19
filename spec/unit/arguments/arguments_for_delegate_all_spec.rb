require 'spec_helper'
require 'forwarder/arguments'

describe Forwarder::Arguments do
  let( :messages ){ %w{two messages} }
  let( :target  ){ :a_target  }

  describe 'with a message array' do
    subject do
      described_class.new( messages, to: target )
    end

    it "delegates to all" do
      should be_all
    end

    it "has the correct target" do
      subject.target.should eq( target )
    end
    
    it "does not delegate normally" do
      should_not be_delegatable
    end

    it "does not have a message" do
      subject.message.should eq( %w{two messages} )
    end

    it "does not have any aop" do
      should_not be_aop
    end
  end # describe 'without translation'

end # describe Forwarder::Arguments
