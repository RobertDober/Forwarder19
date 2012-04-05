require 'spec_helper'
require 'forwarder/params'

describe Forwarder::Params do
  describe "when it can use Forwardable" do
    let :forwardee do double "forwardee" end 
    let :target do :@ivar_name end
    let :message do :a_message end
    let :translation do :another_message end

    subject do
      described_class.new( forwardee )
    end

    it "forwards to a target" do
      forwardee.should_receive( :extend ).with( Forwardable ).ordered
      forwardee.should_receive( :def_delegator ).with(target, message).ordered
      subject.prepare_forward( message, to: target )
      subject.forward!
    end
    it "forward to a target with translation" do
      forwardee.should_receive( :extend ).with( Forwardable ).ordered
      forwardee.should_receive( :def_delegator ).with(target, translation, message).ordered
      subject.prepare_forward( message, to: target, as: translation )
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
      forwardee.should_receive( :extend ).with( Forwardable ).ordered
      forwardee.should_receive( :def_delegators ).with( target, *messages ).ordered
      subject.prepare_forward( messages, to: target )
      subject.forward!
    end
  end # describe "when it can use Forwardable with all"
end # describe Forwarder::Params
