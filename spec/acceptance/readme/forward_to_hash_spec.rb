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
      wrapper.c should eq( 44 )
    end

    it "but it can be set" do
      wrapper.hash[:d] = 45
      wrapper.d.should eq( 45 )
    end
  end # describe "hash keys are irrelevant (and ressitance, of course is futile)"

  describe "who am I to decide on keys" do
    let_forwarder_instance :wrapper, hash: {a: 42, b:43, c:44} do
      attr_reader :hash
      forward_all :c, :d, to_hash: :hash, key_required: true
    end

    it "can still access c" do
      wrapper.c.should eq( 44 )
    end

    it "raises an IndexError for d though" do
      ->{ wrapper.d }.should raise_error( IndexError )
    end
    
    it "which can be remedied (sp?) by defining the key of course" do
      wrapper.hash[:d] = nil
      wrapper.d.should be_nil
    end
  end # describe "who am I to decide on keys"

  describe "names, are you calling me names" do
    let_forwarder_instance :wrapper, hash: { a: 42, b: 43 } do
      attr_reader :hash
      forward :a, to_hash: :@hash, as_key: :b
      forward :b, to_hash: :@hash, as_key: :c, key_required: true
    end

    it "forwards to the symbolic key" do
      wrapper.a.should eq( 43 )
    end

    it "raises IndexError for b" do
      ->{ wrapper.b }.should raise_error( IndexError )
    end

    it "can by helped, though (why am I sooo good to you?)" do
      wrapper.hash[:c]=nil
      wrapper.b.should be_nil
    end
  end # describe :forward_to_hash do
end # describe Forwarder do
