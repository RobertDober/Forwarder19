#
# These specs assure that the README examples work as intented.
#

require 'spec_helper'
require 'forwarder'

describe Forwarder do

  describe :to_object do
    describe "self" do
      
      klass = Class.new do
        class << self
          extend Forwarder
          forward :<<, to: :instances

          def instances; @instances ||= [] end
        end

        extend Forwarder
        forward :register, to_object: self, as: :<<
      end

      it "registers itself" do
        instance = klass.new
        instance.register instance
        klass.instances.should eq( [instance] )
      end
    end # describe "self"

    describe ":self" do
      let_forwarder_instance :wrapper, ary: %w{one two} do
        forward :second, to_object: :self, as: :[], with: 1
        forward :[], to: :@ary
      end
      
      it "accesses the second element" do
        wrapper.second.should eq( "two" )
      end
    end # describe ":self"

    describe "as closure" do
      let_forwarder_instance :counter do
        container = []
        forward :register, to_object: container, as: :<<, with: :sentinel
        forward :count, to_object: container, as: :size
      end

      it "is initially zero" do
        counter.count.should be_zero
      end

      it "can be incremented" do
        counter.count.should be_zero
        2.times{ counter.register }
        counter.count.should eq( 2 )
      end
    end # describe "as closure"
  end # describe :to_object

end # describe Forwarder
