#
# These specs assure that the README examples work as intented.
#

require 'spec_helper'
require 'lab419/core/integer'

describe Forwarder do

  describe "chain" do
    
    let_forwarder_instance :wrapper, ary: %w{one two} do
      attr_reader :ary
      forward :first_reverse, to_chain: [:@ary, :first], as: :reverse
      forward :reverse, to_chain: [:ary, :last]
    end

    it "accesses the first element" do
      wrapper.first_reverse.should eq( "eno" )
    end

    it "accesses the second element" do
      wrapper.reverse.should eq( "owt" )
    end
  end # describe "custom target"

  describe "chain with args" do
    
    let_forwarder_instance :wrapper, ary: %w{one two} do
      attr_reader :ary
      forward :letter, to_chain: [:@ary, :first], as: :[], with: 1
    end

    it "accesses the letter" do
      wrapper.letter.should eq( "n" )
    end

  end # describe "custom target"

  describe "chain with blk" do
    
    let_forwarder_instance :wrapper, ary: [[1,2,3]] do
      attr_reader :ary
      forward :letter, to_chain: [:@ary, :first], as: :inject, with_block: Integer.sum
    end

    it "accesses the letter" do
      wrapper.letter.should eq( 6 )
    end

  end # describe "custom target"
end # describe Forwarder
