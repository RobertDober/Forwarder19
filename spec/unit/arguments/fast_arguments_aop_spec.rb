require 'spec_helper'
require 'forwarder/arguments'

describe FForwarder::Arguments do
  let( :message ){ :a_message }
  let( :target  ){ :a_target  }

  describe 'without translation' do
    subject do
      described_class.new( message, to: target, before: :use_block ){ 42 }
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
    
    it "cannot delegate with Forwardable" do
      should_not be_delegatable
    end

    it "cannot delegate to all" do
      should_not be_all
    end
    
    it "is aop" do
      should be_aop
    end

    it "is not after" do
      should_not be_after
    end

    it "is before" do
      should be_before
    end

    # !!!!!
    it "is *not* lambda, the block is used by AOP" do
      should_not be_lambda
    end

    it "can access before" do
      subject.before.().should eq( 42 )
    end
  end # describe 'without translation'

  describe 'with translation' do
    let( :translation ){ :a_translation }
    subject do
      described_class.new( message, to: target, as: translation, after: ->(x){2*x} )
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

    it "is aop" do
      should be_aop
    end

    it "is after" do
      should be_after
    end

    it "can exec after" do
      subject.after.(21).should eq( 42 )
    end

    it "is not before" do
      should_not be_before
    end
  end # describe 'without translation'
end # describe Forwarder::Arguments
