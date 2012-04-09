#
# These specs assure that the README examples work as intented.
#

require 'spec_helper'

describe Forwarder do

  describe "custom target" do
    
    let_forwarder_instance :wrapper, ary: %w{one two} do
      attr_reader :ary
      forward :first_reverse, to_chain: [:@ary, :first], as: :reverse
      forward :reverse, to_chain: [:ary, :last]
    end

    it "accesses the first element" do
      wrapper.new.first_reverse.should eq( "eno" )
    end

    it "accesses the second element" do
      wrapper.new.reverse.should eq( "owt" )
    end
  end # describe "custom target"

end # describe Forwarder
