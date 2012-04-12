#
# These specs assure that the README examples work as intented.


require 'spec_helper'
require 'lab419/core/kernel'
require 'lab419/core/integer'

describe "Forwarder complex examples" do
  
  describe "chain and AOP" do

    let_forwarder_instance :wrapper, ary: [[*0..9]] do
      forward :odd_squared_sum,
              to_chain: [:@ary, :first],
              as: :values_at,
              before: ->(*args){ args.select(&sendmsg(:odd?)) },
              after:  ->(x){y = x.inject{ |s, e| s + e }; y * y }
    end

    it "should be 1 + 3 + 5 + 7 + 9 squared, equallying 625" do
      wrapper.odd_squared_sum(*[*0..9]).should eq( 625 )
    end
    
  end # describe "A complex example"
  
  describe "chain and AOP and block" do

    let_forwarder_instance :wrapper, ary: ["ab bc cd"] do
      forward :doubled,
              to_chain: [:@ary, :first],
              as: :gsub,
              before: ->(arg){ %r<#{arg}+> },
              after: sendmsg(:reverse) do |x| x + x end
    end

    it "should be dcdc cbcb baba" do
      wrapper.doubled(/\S/).should eq( "dcdc cbcb baba" )
    end
    
  end # describe "A complex example"
  
  describe "custom target and AOP and block" do

    let_forwarder_instance :wrapper do
      forward :doubled,
              to_object: "ab bc cd",
              as: :gsub,
              before: ->(arg){ %r<#{arg.upcase}+> },
              after: sendmsg(:reverse) do |x| x + x end
    end

    it "should be dcdc cbcb baba" do
      wrapper.doubled('\s').should eq( "dcdc cbcb baba" )
    end
    
  end # describe "A complex example"
end # describe Forwarder do
