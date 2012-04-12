require 'spec_helper'
require 'forwarder/arguments'

describe FForwarder::Arguments do
  let( :message ){ :a_message }
  let( :target  ){ %w{a b c}  }

  describe 'without translation' do
    subject do
      described_class.new( message, to_object: target )
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
      should_not be_all
    end

    it "does not delegate to a chain" do
      should_not be_chain
    end

    it "delegates to a custom object" do
      should be_custom_target
    end

    it "does not have a lambda" do
      should_not be_lambda
    end

    it "has an object target" do
      subject.object_target( 42 ).should eq( target )
    end
  end # describe 'without translation'

  describe 'with translation' do
    let( :target ){ :self }
    let( :translation ){ :a_translation }
    subject do
      described_class.new( message, to_object: target, as: translation, with_block: ->{} )
    end

    it "has the correct message" do
      subject.message.should eq( message )
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
      should_not be_all
    end

    it "does not delegate to a chain" do
      should_not be_chain
    end

    it "delegates to a custom object" do
      should be_custom_target
    end

    it "has a lambda" do
      should be_lambda
    end
    it "has an object target to be passed in" do
      subject.object_target( 42 ).should eq( 42 )
    end
  end # describe 'without translation'
end # describe Forwarder::Arguments
