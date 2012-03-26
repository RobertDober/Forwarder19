#
# These specs assure that the README examples work as intented.
#

require 'spec_helper'

describe Forwarder do

  describe "custom target" do
    
    let_forwarder_instance :wrapper, ary: %w{one two} do
      forward :first_reverse, to: [:@ary, :first] as: :reverse
    end

    it "accesses the second element" do
      wrapper.first_reverse.should eq( "eno" )
    end
  end # describe "custom target"

end # describe Forwarder
