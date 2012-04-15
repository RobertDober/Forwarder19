#
# These specs assure that the README examples work as intented.
#

require 'spec_helper'

describe Forwarder do
  
  describe "simple without translation" do
    let_forwarder_instance :wrapper, ary: %w{one two} do
      attr_reader :ary
      forward :first, to: :ary
    end

    it "accesses the first element" do
      wrapper.first.should eq( "one" )
    end
    
  end # describe "simple without translation" do

  describe "simple with translation" do
    let_forwarder_instance :wrapper, ary: %w{one two} do
      forward :tail, to: :@ary, as: :last
    end

    it "accesses the first element" do
      wrapper.tail.should eq( "two" )
    end
  end # describe "simple without translation" do

  describe "simple with translations, assure args are passed trhorugh)" do
    let_forwarder_instance :wrapper, ary: %w{one two} do
      attr_reader :ary
      forward :get, to: :ary, as: :[]
    end

    it "accesses the first element" do
      wrapper.get( 0 ).should eq( "one" )
    end
    
    it "accesses the second element" do
      wrapper.get( 1 ).should eq( "two" )
    end
    
  end # describe "simple without translation" do

end # describe Forwarder do
