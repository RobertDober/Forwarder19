require 'spec_helper'
require 'forwarder/params'

describe Forwarder::Params do
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
end # describe Forwarder::Params
