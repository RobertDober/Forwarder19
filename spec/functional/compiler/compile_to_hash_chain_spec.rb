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

    describe "for forward_to_hash" do
      args message: :a, to_hash?: [:@a_hash, :hello], translation: nil
      expect_compilation_to_be "def a; @a_hash.hello[ :a ] end"
    end

    describe "for forward_to_hash with translation" do
      args message: :a, to_hash?: [:a_hash, :w, :z], translation: :b
      expect_compilation_to_be "def a; a_hash.w.z[ :b ] end"
    end

    describe "for forward_all_to_hash" do
      args message: %w{a b}, to_hash?: [:x, :y], translation: nil
      expect_compilation_to_be [
          "def a; x.y[ :a ] end",
          "def b; x.y[ :b ] end"
        ].join("\n")
    end 

  end # compiles correctly

end # describe Forwarder::Compiler
