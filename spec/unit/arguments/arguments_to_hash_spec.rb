require 'spec_helper'
require 'forwarder/arguments'

describe Forwarder::Arguments do
  let( :message ){ :a_message }
  let( :target  ){ :hello  }
  let( :args ){ :world }
  describe :to_hash do
    describe "simple" do
      subject do
        described_class.new( message, to_hash: target )
      end

      it "has the correct message" do
        subject.message.should eq( message )
      end

      it "has the correct target" do
        subject.target.should eq( target )
      end

      it "does not have an implicit translation" do
        subject.translation.should be_nil
      end

      it "has no arguments" do
        should_not be_args
      end
      
      it "is to_hash" do
        should be_to_hash
      end
    end # describe "simple"
    
    describe "translated" do
      subject do
        described_class.new( message, to_hash: target, as: :alpha )
      end

      it "has the correct message" do
        subject.message.should eq( message )
      end

      it "has the correct target" do
        subject.target.should eq( target )
      end

      it "has an - implicit - translation" do
        subject.translation.should eq( :alpha )
      end

      it "has no arguments" do
        should_not be_args
      end
    end # describe "simple"
    describe "all" do
      
      subject do
        described_class.new( [:m1, :m2], to_hash: target )
      end

      it "has the correct message" do
        subject.message.should eq( [:m1, :m2] )
      end

      it "has the correct target" do
        subject.target.should eq( target )
      end

      it "has an - implicit - translation" do
        subject.translation.should be_nil
      end

      it "does not have arguments" do
        should_not be_args
      end
    end # describe "simple"
  end # describe :to_hash
end # describe Forwarder::Arguments
