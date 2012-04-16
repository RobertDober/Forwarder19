require 'spec_helper'
require 'forwarder/compiler'

describe Forwarder::Compiler do

  subject do
    described_class.new( arguments )
  end

  describe "compiles correctly" do
    let :arguments do
      double( "arguments" ).tap{ |args|
        args.stub( lambda?: false, aop?: false, args?: false, translation: "howdy", target: :world, message: :hello )
      }
    end

    after :each do
      subject.compile.should eq( expected_string )
    end
    
    describe "for simple delegation" do
      let :expected_string do
        "def hello *args, &blk; world.howdy( *args, &blk ) end"
      end
      it{}
    end # describe "for simple delegation"

    describe 
  end # describe compile simple delegation

  describe "does not compile" do
    describe "if there is a lambda" do
      let :arguments do
        double( "arguments" ).tap{ |args|
          args.stub( lambda?: true, aop?: false, args?: false, translation: "hello", target: :world, message: :hello )
        }
      end
      it{ subject.compile.should be_nil }
    end # describe "if there is a lambda"
    describe "if there is aop" do
      let :arguments do
        double( "arguments" ).tap{ |args|
          args.stub( lambda?: false, aop?: true, args?: false, translation: "hello", target: :world, message: :hello )
        }
      end
      it{ subject.compile.should be_nil }
    end # describe "if there is a lambda"
    describe "if there are args" do
      let :arguments do
        double( "arguments" ).tap{ |args|
          args.stub( lambda?: false, aop?: false, args?: true, translation: "hello", target: :world, message: :hello )
        }
      end
      it{ subject.compile.should be_nil }
    end # describe "if there is a lambda"
  end # describe "does not compile"

end # describe Forwarder::Params
