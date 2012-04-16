require 'spec_helper'
require 'forwarder/params'

describe Forwarder::Params do
  let :forwardee do
    double "forwardee"  
  end

  let :args do
    double "arguments"
  end

  subject do
    described_class.new forwardee
  end

  before :each do
    subject.stub arguments: args
    Forwarder::Compiler.should_receive( :new ).with( args ).and_return( compiler )
  end

  after :each do
    subject.forward!
  end

  describe "compileable" do
    let :compiled do
      "some code"
    end
    let :compiler do
      double( "compiler" ).tap{ |c|
        c.should_receive( :compile ).and_return compiled
      }
    end
    it "shall compile and forward" do
      forwardee
        .should_receive( :module_eval )
        .with( compiled, anything, anything )
    end
  end # describe "compileable"

  describe "uncompilable code" do

    let :compiler do
      double( "compiler" ).tap{ |c|
        c.should_receive( :compile ).and_return nil
      }
    end

    it "shall use Meta for forwarding" do
      Forwarder::Meta
        .should_receive( :new )
        .with( forwardee, args ).and_return( double("meta").tap{|m|m.should_receive :forward} )
    end
  end # describe "uncompilable code"

end # describe Forwarder::Params
