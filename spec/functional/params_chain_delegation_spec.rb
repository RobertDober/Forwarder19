require 'spec_helper'
require 'forwarder/params'

describe Forwarder::Params do
  # Setup
  let :args do
    double "args",
      delegatable?: false,
      delegate_to_all?: false,
      chain?: true
  end

  subject do
    described_class.new( "forwardee" )
  end

  it do
    subject.stub( arguments: args )
    subject.should_receive :delegate_to_chain
    subject.forward!
  end
end # describe Forwarder::Params do
