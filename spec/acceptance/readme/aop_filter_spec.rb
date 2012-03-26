#
# These specs assure that the README examples work as intented.
#

require 'spec_helper'

describe Forwarder do
  describe "AOP" do
    describe :after do

      let_forwarder_instance :wrapper, hash: { 1 => 30, 2 => 20, 3 => 10 } do
        forward :max_value1, to: :@hash, as: :values_at, after: lambda{ |x| x.max }
        forward :max_value2, to: :@hash, as: :values_at, after: :use_block do | x |
          x.max
        end
        forward :max_value3, to: :@hash, as: :values_at, after: sendmsg( :max )
      end

      it "gets 3 for max_value1" do
        wrapper.max_value1( 1, 2, 3 ).should eq( 30 )
      end

      it "gets 3 for max_value2" do
        wrapper.max_value2( 1, 2, 3 ).should eq( 30 )
      end
      
      it "gets 3 for max_value3" do
        wrapper.max_value3( 1, 2, 3 ).should eq( 30 )
      end
      
    end # describe :after

    describe :before do
      
      let_forwarder_instance :wrapper, hash: { 1 => 30, 2 => 20, 3 => 10 } do
        forward :value_of_max1, to: :@hash, as: :[], before: lambda{ |*args| args.max }
        forward :value_of_max2, to: :@hash, as: :[], before: :use_block do | *args |
          args.max
        end
        forward :value_of_max3, to: :@hash, as: :[], before: sendmsg( :max )
      end

    end # describe :before
  end # describe "AOP"
end # describe Forwarder do
