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

      it "has an - implicit - translation" do
        subject.translation.should eq( :[] )
      end

      it "has arguments (to the implicit translation)" do
        should be_args
      end
      
      it "has the message as argument" do
        subject.args.should eq( [message ] )
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
        subject.translation.should eq( :[] )
      end

      it "has arguments (to the implicit translation)" do
        should be_args
      end
      it "has the - explicit - translation as argument" do
        subject.args.should eq( [ :alpha ] )
      end
    end # describe "simple"
  end # describe :to_hash
end # describe Forwarder::Arguments
