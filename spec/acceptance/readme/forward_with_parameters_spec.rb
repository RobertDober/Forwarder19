#
# These specs assure that the README examples work as intented.
#

require 'lab419/core/integer'
require 'spec_helper'

describe Forwarder do

  describe "passing one parameter" do
    let_forwarder_instance :wrapper, :ary => %w{one two} do
      forward :second, to: :@ary, as: :[], with: 1
    end

    it "accesses the second element" do
      wrapper.second.should eq( 'two' )
    end
  end # describe "passing one parameter"

  describe "passing more parameters" do
    let_forwarder_instance :wrapper, :str => "the,quick, brown.fox." do
      forward :add_whitespace_to_punctuation,
              to: :@str,
              as: :gsub!,
              with: [ /[,.]\b/, '\& ' ]      
    end

    it "adds whitespaces where needed" do
      wrapper.add_whitespace_to_punctuation
      wrapper.instance_variable_get( :@str ).should eq( "the, quick, brown. fox." )
    end
  end # describe "passing more parameters"

  describe "passing one array" do
    describe "wrapped into another one" do
      let_forwarder_instance :wrapper, :ary => %w{Hello} do
        forward :append_suffix, to: :@ary, as: :concat, with: [%w{ Brave New World }]
      end
      it "appends correctly" do
        wrapper.append_suffix
        wrapper.instance_variable_get( :@ary ).should eq( %w{Hello Brave New World} )
      end
    end

    describe "using with_ary:" do
      let_forwarder_instance :wrapper, :ary => %w{Hello} do
        forward :append_suffix, to: :@ary, as: :concat, with_ary: %w{ Brave New World }
      end
      it "appends correctly" do
        wrapper.append_suffix
        wrapper.instance_variable_get( :@ary ).should eq( %w{Hello Brave New World} )
      end
    end
  end # describe "passing one array"

  describe "passing a block" do
    describe "as block of forward" do
      let_forwarder_instance :gauss, :elements => [*1..100] do
        attr_reader :elements
        forward :sum, to: :@elements, as: :inject, &Integer.sum
      end
      it "computes 5050" do
        gauss.sum.should eq( 5050 )
      end
    end # describe as block of forward
    describe "using with_block: and a lambda" do
      let_forwarder_instance :gauss, :elements => [*1..100] do
        forward :sum, to: :@elements, as: :inject, with_block: Integer.sum
      end
      it "computes 5050" do
        gauss.sum.should eq( 5050 )
      end
    end # describe as block of forward
  end # describe "passing a block"
end # describe Forwarder
