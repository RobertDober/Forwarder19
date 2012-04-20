require 'spec_helper'
require 'helpers/compiler_helper'

require 'forwarder/compiler'

describe Forwarder::Compiler do

  subject do
    described_class.new( arguments )
  end

  describe "compiles correctly with args" do

    after :each do
      subject.compile.should eq( expected_string )
    end

    describe "for simple delegation" do
      args args?: true, args: [42], translation: "hello"
      expect_compilation_to_be "def hello *args, &blk; world.hello( 42, *args, &blk ) end"
    end # describe "for simple delegation"
    describe "for translated delegation with more args" do
      args args?: true, args: ["hello", :world]
      expect_compilation_to_be %{def hello *args, &blk; world.howdy( 'hello', :world, *args, &blk ) end}
    end # describe "for translated delegation with array args"



  end # describe compile simple delegation

  describe "does not compile" do
    describe "if there is a lambda" do
      args must_not_compile?: true
      it{ subject.compile.should be_nil }
    end # describe "if there is a lambda"
  end # describe "does not compile"

end # describe Forwarder::Params
