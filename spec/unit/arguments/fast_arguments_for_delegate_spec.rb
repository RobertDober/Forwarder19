require 'spec_helper'
require 'forwarder/arguments'

describe Forwarder::Arguments do
  let( :message ){ :a_message }
  let( :target  ){ :a_target  }

  describe 'without translation' do
    subject do
      described_class.new( message, to: target )
    end

    it "has the correct message" do
      subject.message.should eq( message )
    end

    it "has no translation, meaning the translation uses the passed in default" do
      subject.translation(42).should eq( 42 )
    end
 
    it "has the correct target" do
      subject.target.should eq( target )
    end
    
    it "can delegate with Forwardable" do
      should be_delegatable
    end

    it "cannot delegate to all" do
      should_not be_all
    end
  end # describe 'without translation'

  describe 'with translation' do
    let( :translation ){ :a_translation }
    subject do
      described_class.new( message, to: target, as: translation )
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
    
    it "can delegate with Forwardable" do
      should be_delegatable
    end

    it "does not have any aop" do
      should_not be_aop
    end
  end # describe 'without translation'
end # describe Forwarder::Arguments
