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
        .should eq( ":world, 1, 'hello', " )
    end
    it "has complex representations" do
      described_class
        .serialize( [1, [nil, "a"], :b] )
        .should eq( "1, [ nil, 'a' ], :b, " )
    end

    it "saves us for evalluation" do
      described_class
        .serialize( [ '#{1+1}' ] )
        .should eq( %w<' # { 1 + 1 } ' ,>.join + " " )
    end

    it "can descend into hashes and arrays" do
      described_class
        .serialize( [{ a: 42, b: [ "a", {c: 44} ], c: {d:4, e:5} }, ["a"], {}] )
        .should eq( "{ :a => 42, :b => [ 'a', { :c => 44 } ], :c => { :d => 4, :e => 5 } }, [ 'a' ], {  }, " )
    end

    it "detects recursion in the datastructure" do
      x = {  }
      x.update( a: x )
      described_class
        .serialize( [x] )
        .should be_nil
    end
    it "does not detect recursion for primitive types..." do
      described_class
        .serialize( [ { a: true, b: 42, c: nil, d: { a: 42, b: true, c: [ nil ] } } ] )
        .should eq( "{ :a => true, :b => 42, :c => nil, :d => { :a => 42, :b => true, :c => [ nil ] } }, " )
    end
    it "...nor for symbols" do
      described_class
        .serialize( [ { a: :a, b: 42, c: nil, d: { a: 42, b: :a, c: [ :a, 42 ] } } ] )
        .should eq( "{ :a => :a, :b => 42, :c => nil, :d => { :a => 42, :b => :a, :c => [ :a, 42 ] } }, " )
    end
    it "raises an error if params cannot be serialized" do
      described_class
        .serialize( [Object.new] ).should be_nil
    end
  end # describe 'without translation' do
 
end # describe Forwarder::Arguments do
