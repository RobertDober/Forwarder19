#
# These specs assure that the README examples work as intented.
#

require 'spec_helper'
require 'forwarder/helpers/integer/operators'
describe Integer do
  it "has loaded the operator lambdas" do
    Integer.methods.should include( :sum )
  end
  it "has not loaded the inc method" do
    ->{ 42.inc }.should raise_error( NoMethodError ) # hmm would 41.inc have worked?
  end
end # describe Integer
