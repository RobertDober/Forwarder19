#
# These specs assure that the README examples work as intented.
#

require 'spec_helper'
require 'forwardable'

describe Forwarder do

  describe "delegation to Forwardable#def_delegator" do
    let :myclass do
      Class.new
    end

    it "forward without translation" do
      myclass.should_receive( :extend ).with( Forwardable ).ordered
      myclass.should_receive( :def_delegator ).with( :@elements, :size ).ordered
      myclass.module_eval do
        extend Forwarder
        forward :size, to: :elements
      end
    end

    it "forward with translation" do
      myclass.should_receive( :extend ).with( Forwardable ).ordered
      myclass.should_receive( :def_delegator ).with( :@elements, :size, :count ).ordered
      myclass.module_eval do
        extend Forwarder
        forward :count, to: :elements, as: :size
      end
    end
  end # describe "delegation to Forwardable#def_delegator"

  describe "delegation to Forwardable#def_delegators" do
    let :mymodule do
      Module.new
    end

    it "with forward_all" do
      mymodule.should_receive( :extend ).with( Forwardable ).ordered
      mymodule.should_receive( :def_delegators ).with( :@elements, :size, :<<, :first ).ordered
      mymodule.module_eval do
        extend Forwarder
        forward_all :size, :<<, :first, to: :elements
      end
    end

  end # describe "delegation to Forwardable#def_delegator"

end # describe Forwarder