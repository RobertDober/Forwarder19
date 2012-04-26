#
# These specs assure that the README examples work as intented.
#

require 'spec_helper'

describe Forwarder do
  
  describe :forward_to_hash do
    let_forwarder_instance :wrapper, hash: { a: 42, b: 43 } do
      forward :a, to_hash: :@hash
    end

    it "forwards to the symbolic key" do
      wrapper.a.should eq( 42 )
    end

    it "does not forward to the other keys" do
      ->{ wrapper.b }.should raise_error( NoMethodError )
    end
  end # describe :forward_to_hash do

  describe :forward_many_to_hash do
    let_forwarder_instance :wrapper, hash: {a: 42, b:43, c:44} do
      attr_reader :hash
      forward_all :a, :b, to_hash: :hash
    end

    it "forwards to the first symbolic key" do
      wrapper.a.should eq( 42 )
    end

    it "forwards to the second symbolic key" do
      wrapper.b.should eq( 43 )
    end

    it "does not forward to the other keys" do
      ->{ wrapper.c }.should raise_error( NoMethodError )
    end
  end # describe :forward_many_to_hash

  describe "hash keys are irrelevant (and ressitance, of course, is futile)" do
    let_forwarder_instance :wrapper, hash: {a: 42, b:43, c:44} do
      attr_reader :hash
      forward :d, to_hash: :hash
    end
   
    it "is just nil" do
      wrapper.d.should be_nil
    end

    it "but it can be set" do
      wrapper.hash[:d] = 45
      wrapper.d.should eq( 45 )
    end
  end # describe "hash keys are irrelevant (and ressitance, of course is futile)"

  describe "hash keys are still irrelevant (and resistance, of course, is still futile)" do
    let_forwarder_instance :wrapper, hash: {a: 42, b:43, c:44} do
      attr_reader :hash
      forward_all :c, :d, to_hash: :hash
    end
   
    it "is just nil" do
      wrapper.d.should be_nil
    end

    it "or not" do
      wrapper.c.should eq( 44 )
    end

    it "but it can be set" do
      wrapper.hash[:d] = 45
      wrapper.d.should eq( 45 )
    end
  end # describe "hash keys are irrelevant (and ressitance, of course is futile)"


  describe "forward to hash with translations" do
    let_forwarder_instance :wrapper, hash: {a: 42} do
      forward :b, to_hash: :@hash, as: :a
    end
    
    it 'accesses a' do
      wrapper.b.should eq( 42 )
    end

    it 'however a is not defined' do
      ->{ wrapper.a }.should raise_error( NoMethodError ) 
    end
  end # describe "forward to hash with translations"
end # describe Forwarder do
