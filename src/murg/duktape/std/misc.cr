module Murg
  module Duktape
    module Std
      module Misc
        macro misc
          sandbox.push_global_proc("__std__print__", LibDUK::VARARGS) do |ptr|
            env = ::Duktape::Sandbox.new ptr
            nargs = env.get_top
            output = String.build do |str|
              nargs.times do |index|
                str << " " unless index == 0
                str << env.safe_to_string index
              end
            end

            puts output

            env.return_undefined
          end

          sandbox.push_global_proc("__std__random_uuid4__", LibDUK::VARARGS) do |ptr|
            env = ::Duktape::Sandbox.new ptr

            env.push_string UUID.random.to_s
            env.call_success
          end

          sandbox.eval! <<-JS
            const random = {
              uuid: function() { return __std__random_uuid4__() },
            }

            function __std__value_of__(value) {
              return value
            }
          JS
        end
      end
    end
  end
end
