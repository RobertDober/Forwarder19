#
# These specs assure that the README examples work as intented.
#

require 'spec_helper'
require 'lab419/core/kernel'

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
        forward :value_of_max3, to: :@hash, as: :[], before: ->(*args){args.max}
      end

      it "gets value_of_max1" do
        wrapper.value_of_max1( 0, 1, 2, 3 ).should eq( 10 )
      end

      it "gets value of max 2" do
        wrapper.value_of_max2( 0, 1, 2 ).should eq( 20 )
      end

      it "gets value of max 3" do
        wrapper.value_of_max3( 0, 1, 2, 4 ).should be_nil
      end
    end # describe :before

    describe "after and before" do
      select_odd =
        ->(*args){ args.select(&sendmsg(:odd?)) }

      let_forwarder_instance :wrapper, ary: [*0..9] do
        forward :odd_doubled_sum,
          to: :@ary,
          as: :values_at, 
          before: select_odd,
          after: :use_block do |e|
          e.inject(0,&Integer.sum)
          end
      end

      it "sums correctly" do
        wrapper.odd_doubled_sum(1, 2, 3).should eq( 4 )
      end
    end # describe "after and before"

    describe "state in after and before" do 
      init_state =
        ->{self.state = 1;[]}

      context "standard forward" do
        let_forwarder_instance :target, state: nil do
          forward :object_id, to: :state, # A NOP
            before: init_state,
            after: :use_block do
            self.state += 1
            end
        end
        it "executes all blox in the correct context" do
          target.object_id
          target.state.should == 2
        end

      end # context "forward to object"
      context "forward to object" do
        let_forwarder_instance :target, state: nil do
          forward :object_id, to_object: Object, # A NOP
            before: init_state,
            after: :use_block do
            self.state += 1
            end
        end
        it "executes all blox in the correct context" do
          target.object_id
          target.state.should == 2
        end

      end # context "forward to object"

    end # describe "state in after and before", :wip
  end # describe "AOP"
end # describe Forwarder do
