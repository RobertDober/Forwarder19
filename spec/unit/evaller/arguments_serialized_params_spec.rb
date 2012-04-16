require 'spec_helper'
require 'forwarder/arguments'

describe Forwarder::Evaller do
  
  let( :message ){ :a_message }
  let( :target  ){ :hello  }
  let( :args ){ :world }

  describe 'without translation' do

    it "has correct serialized no params" do
      described_class
        .serialize( nil )
        .should eq( "" )
    end
    it "has correct serialized empty params" do
      described_class
        .serialize( [] )
        .should eq( "" )
    end
    it "has correct serialized params" do
      described_class
        .serialize( [:world, 1, "hello"] )
        .should eq( ':world, 1, "hello", ' )
    end
    it "has complex representations" do
      described_class
        .serialize( [1, [nil, "a"], :b] )
        .should eq( '1, [ nil, "a" ], :b, ' )
    end
    it "raises an error if params cannot be serialized" do
      -> do
        described_class
          .serialize( Object.new )
      end.should raise_error
    end
  end # describe 'without translation' do
 
end # describe Forwarder::Arguments do
