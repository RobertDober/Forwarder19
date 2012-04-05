require 'spec_helper'
require 'forwarder/params'

describe Forwarder::Params do
  describe "when it chains" do
    let :forwardee do double "forwardee" end 
    let :message do :a_message end
    let :chain do %w{a b c} end
    let :translation do :trans end

    let :meta do double( "meta" ) end
    
    subject do
      described_class.new( forwardee )
    end

    it "forwards to a target" do
      Forwarder::Meta.should_receive(:new).with( forwardee, Forwarder::Arguments.new( forwardee, to_chain: chain ) ).and_return( meta )
      subject.prepare_forward( message, to_chain: chain )
      subject.forward!
    end
    it "forward to a target with translation" do
      subject.prepare_forward( message, to_chain: target, as: translation )
      subject.forward!
    end
  end

  describe "when it can use Forwardable with all" do
    let :forwardee do double "forwardee" end 
    let :target do :@ivar_name end
    let :messages do %w{one two three} end
    let :translation do :another_message end

    subject do
      described_class.new( forwardee )
    end
    
    it "forwards all to target" do
      forwardee.should_receive( :def_delegators ).with( target, *messages ).ordered
      subject.prepare_forward( messages, to: target )
      subject.forward!
    end
  end # describe "when it can use Forwardable with all"
end # describe Forwarder::Params
