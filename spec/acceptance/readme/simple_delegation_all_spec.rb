#
# These specs assure that the README examples work as intented.
#

require 'spec_helper'

describe Forwarder do
  
  describe "simple delegate all" do
    
    let_forwarder_instance :wrapper, ary: %w{one two} do
      attr_reader :ary
      forward_all :size, :[], :reverse, to: :ary
    end

    it "forwards size" do
      wrapper.size.should eq( 2 )
    end

    it "forwards :[] with passed params" do
      wrapper[-1].should eq( "two" )
    end

    it "forwards reverse" do
      wrapper.reverse.should eq( %w{two one} )
    end
  end # describe "simple delegate all" do
end # describe Forwarder do
