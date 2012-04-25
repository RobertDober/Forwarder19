module ArgumentStubber
  def args keys={}
    let :arguments do
      double( "arguments" ).tap{ |args|
        args.stub( 
                  {lambda?: false,
                    aop?: false,
                    args?: false,
                    args: nil,
                    custom_target?: false,
                    chain?: false,
                    translation: "howdy",
                    target: :world,
                    to_hash?: nil,
                    must_not_compile?: false,
                    message: :hello}.merge( keys )
                 )
      }
    end

    def expect_compilation_to_be compiled
      let :expected_string do compiled  end
      it{}
    end
  end
end # module ArgumentStubber
  
RSpec.configure do | r |
  r.extend ArgumentStubber
end

