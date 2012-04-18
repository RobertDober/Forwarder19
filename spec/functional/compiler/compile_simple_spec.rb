require 'spec_helper'
require 'helpers/compiler_helper'

require 'forwarder/compiler'

describe Forwarder::Compiler do

  subject do
    described_class.new( arguments )
  end

  describe "compiles correctly" do

    after :each do
      subject.compile.should eq( expected_string )
    end

    describe "for simple delegation" do
      args
      expect_compilation_to_be "def hello *args, &blk; world.howdy( *args, &blk ) end"
    end # describe "for simple delegation"

    describe "for chain delegation" do
      args chain?: true, target: %w{@a b}
      expect_compilation_to_be "def hello *args, &blk; @a.b.howdy( *args, &blk ) end"
    end # describe "for chain delegation"

    describe "for simple delegation to many" do
      args message: %w{a b}, translation: nil
      expect_compilation_to_be [
          "def a *args, &blk; world.a( *args, &blk ) end",
          "def b *args, &blk; world.b( *args, &blk ) end"
        ].join("\n")
    end # describe "for simple delegation"

  end # describe compile simple delegation

  describe "does not compile" do
    describe "if there is a lambda" do
      args lambda?: true
      it{ subject.compile.should be_nil }
    end # describe "if there is a lambda"
    describe "if there is aop" do
      args aop?: true
      it{ subject.compile.should be_nil }
    end # describe "if there is a lambda"
    describe "if there are args" do
      args args?: true, args: [Object.new]
      it{ subject.compile.should be_nil }
    end # describe "if there is a lambda"
    describe "if there is a custom target" do
      args custom_target?: true
      it{ subject.compile.should be_nil }

    end # describe "if there is a custom target"
  end # describe "does not compile"

end # describe Forwarder::Params
