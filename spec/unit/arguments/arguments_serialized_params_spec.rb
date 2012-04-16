require 'spec_helper'
require 'forwarder/arguments'

describe Forwarder::Arguments do
  
  let( :message ){ :a_message }
  let( :target  ){ :hello  }
  let( :args ){ :world }

  describe 'without translation' do

    it "has correct serialized empty params" do
      described_class
        .new( message, to: target )
        .serialized_params
        .should eq( "" )
    end
    it "has correct serialized params" do
      described_class
        .new( message, to: target, with: args )
        .serialized_params
        .should eq( ":world, " )
    end
    it "raises an error if params cannot be serialized" do
      -> do
        described_class
          .new( message, to: target, with: Object.new )
          .serialized_params
      end.should raise_error
    end
  end # describe 'without translation' do
 
end # describe Forwarder::Arguments do
