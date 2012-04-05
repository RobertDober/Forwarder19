require 'spec_helper'
require 'forwarder/arguments'

describe Forwarder::Arguments do
  let( :message ){ :a_message }
  let( :target  ){ %w{a b c}  }

  describe 'without translation' do
    subject do
      described_class.new( message, to_chain: target )
    end

    it "has the correct message" do
      subject.message.should eq( message )
    end
 
    it "has the correct target" do
      subject.target.should eq( target )
    end
    
    it "cannot delegate with Forwardable" do
      should_not be_delegatable
    end

    it "cannot delegate to all" do
      should_not be_delegate_to_all
    end

    it "delegates to a chain" do
      should be_chain
    end
  end # describe 'without translation'

  describe 'with translation' do
    let( :translation ){ :a_translation }
    subject do
      described_class.new( message, to_chain: target, as: translation )
    end

    it "has the correct message" do
      subject.message.should eq( message )
    end
    it "but it does not have any messages" do
      subject.messages.should be_empty
    end

    it "has the correct target" do
      subject.target.should eq( target )
    end

    it "has the correct translation" do
      subject.translation.should eq( translation )
    end
    
    it "cannot delegate with Forwardable" do
      should_not be_delegatable
    end

    it "cannot delegate to all" do
      should_not be_delegate_to_all
    end

    it "delegates to a chain" do
      should be_chain
    end
  end # describe 'without translation'
end # describe Forwarder::Arguments
