require 'spec_helper'
require 'forwarder/arguments'

describe FForwarder::Arguments do
  let( :message ){ :a_message }
  let( :target  ){ :hello  }
  let( :args ){ :world }

  describe 'without translation' do
    subject do
      described_class.new( message, to: target, with: args )
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

    it "delegates to a chain" do
      should_not be_chain
    end

    it "has arguments" do
      should be_args
    end

    it "generates completed args" do
      subject.complete_args(1,2).should eq( [args,1,2] )
    end

    it "does not have a lambda" do
      should_not be_lambda
    end
  end # describe 'without translation'

  describe 'with translation' do
    let( :translation ){ :a_translation }
    subject do
      described_class.new( message, to: target, as: translation, with: args )
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

    it "delegates to a chain" do
      should_not be_chain
    end

    it "has arguments" do
      should be_args
    end

    it "does not have a lambda" do
      should_not be_lambda
    end
  end # describe 'without translation'
end # describe Forwarder::Arguments
