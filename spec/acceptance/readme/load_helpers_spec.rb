
#
# These specs assure that the README examples work as intented.
#

require 'spec_helper'
require 'forwarder/helpers'

describe "loading of many helpers" do
  it "loaded Kernel helpers" do
    sendmsg(:+, 1).( 41 ).should eq( 42 )
  end
  it "loaded Integer helpers" do
    Integer.sum(1).should eq(1) # Hmm is this a misstype?
  end
  it "loaded Proc helper" do
    Proc.identity.(42).should eq(42)
  end
end # describe Object do
