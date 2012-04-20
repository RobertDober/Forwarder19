require 'spec_helper'
require 'forwarder/arguments'

describe Forwarder::Arguments do
  let( :message ){ :a_message }
  let( :target  ){ :a_target  }

  describe 'must not compile' do
    
    subject do
      described_class.new( message, to: target )
    end

    it "if it has a lambda" do
      subject.stub( lambda?: true )
      subject.should be_must_not_compile
    end
    it "if it is aop" do
      subject.stub( aop?: true )
      subject.should be_must_not_compile
    end
    it "if it has a custom_target" do
      subject.stub( custom_target?: true )
      subject.should be_must_not_compile
    end

  end # describe 'must not compile' do

  describe 'might compile' do
    subject do
      described_class.new( message, to: target )
    end
    it "if it has none of the above" do
      subject.should_not be_must_not_compile
    end
  end # describe 'might compile'

end # describe Forwarder::Arguments
