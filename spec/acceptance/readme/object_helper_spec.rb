
#
# These specs assure that the README examples work as intented.
#

require 'spec_helper'
require 'forwarder/helpers/object'

describe Object do
  it "has an identity method" do
    Object.new.tap do | o |
      o.identity.should eq( o )
    end
  end
end # describe Object do
