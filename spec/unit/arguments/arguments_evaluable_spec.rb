require 'spec_helper'
require 'forwarder/arguments'
require 'forwarder/evaller'

describe Forwarder::Arguments do

  describe 'evaluable' do

    it "simple forward is evaluable" do
      described_class.new( "hello", to: :@ivar ).should be_evaluable
    end
    
    it "simple forward with translation is evaluable" do
      described_class.new( "hello", to: :@ivar, as: :greetings ).should be_evaluable
    end

    it "simple forward to all is evaluable" do
      described_class.new( %w[a b c], to: :method ).should be_evaluable
    end

    it "forward to chain is evaluable" do
      described_class.new( :msg, to_chain: %w{a b} ).should be_evaluable
    end
 
    it "forward to chain with translation is evaluable" do
      described_class.new( :msg, to_chain: %w{a b}, as: :other ).should be_evaluable
    end

    it "simple forward with evaluable parameters are evaluable" do
      described_class.new( :message, to: :target, as: :[], with: 1 ).should be_evaluable
    end

    it "simple forward to hash without translation should be evaluable" do
      described_class.new( :access, to_hash: :some_hash ).should be_evaluable
    end

    it "simple forward to hash with translation should be evaluable" do
      described_class.new( :access, to_hash: :some_hash, as: :some_key ).should be_evaluable
    end

    it "chain forward with evaluable parameters is evaluable" do
      described_class.new( :message, to_chain: %w{a @b}, with: "hello" ).should be_evaluable
    end

    it "is evaluable for custom targets that are" do
      described_class.new( :hello, to_object: "World" ).should be_evaluable
    end

    it "is evaluable if the paramters are" do
      Forwarder::Evaller.stub( evaluable?: true )
      described_class.new( :message, to: :alpha, as: :beta, with: Object.new ).should be_evaluable
    end
  end # describe 'without translation'

  describe 'not evaluable' do
    it "is not evaluable for custom targets that are not" do
      described_class.new( :hello, to_object: Object.new ).should_not be_evaluable
    end

    it "is not evaluable for arbitrary parameters" do
      described_class.new( :hello, to: :world, with: Object.new ).should_not be_evaluable
    end

    it "is not evaluable if the paramters are not" do
      Forwarder::Evaller.stub( evaluable?: false )
      described_class.new( :message, to: :alpha, as: :beta, with: Object.new ).should_not be_evaluable
    end
  end # describe 'without translation'
end # describe Forwarder::Arguments
