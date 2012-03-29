
#
# These specs assure that the README examples work as intented.
#

require 'spec_helper'
require 'helpers/kernel'

def inc x; x.succ end

describe Kernel do
  describe :sendmsg do
    it "replaces the Symbol#to_proc kludge" do
      (1..10).map( &sendmsg( :pred ) ).should eq( [*0..9] )
    end
    it "can send parameters too" do
      (1..2).map( &sendmsg( :*, 2 ) ).should eq( [2, 4] )
    end
    it "can exist as a true object" do
      sendmsg( :+, 1 ).should be_kind_of( Proc )
      sendmsg( :+, 1 ).(41).should eq( 42 )
    end
  end # describe :sendmsg

  describe :applyto do
    it "can do what Symbol#to_proc cannot do anymore" do
      (0..1).map( &applyto( :inc ) ).should eq( [1, 2] ) 
    end
    it "can implement curried functions" do
      x = lambda{ |y,z| [y,z].min }
      applyto( x, 2 ).(1).should eq( 1 )
    end
  end # describe :applyto

end # describe Kernel
