
#
# These specs assure that the README examples work as intented.
#

require 'spec_helper'
require 'helpers/integer'

describe Integer do
  it "has an inc instance method" do
    41.inc.should eq( 42 )
  end
  describe "basic operartors as lambdas" do
    it "has one for +" do
      Integer.sum(1, 41).should eq( 42 )
    end
    it "can add many summands" do
      Integer.sum(*[*1..10]).should eq( 42 + 13 )
    end
    it "has one for -" do
      Integer.diff(43,1).should eq( 42 )
    end
    it "has one for *" do
      Integer.prod(2,21,1).should eq( 42 )
    end
    it "has one for /" do
      Integer.div(172,4).should eq( 42 )
    end
    it "has one for %" do
      Integer.mod( 2012, 985 ).should eq( 42 )
    end
  end # describe "basic operartors as lambdas"
end # describe Integer do
