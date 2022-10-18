module Murg
  module Duktape
    module Std
      module Process
        macro process
          # Append the module to the registered module list.
          registered_modules.push("process")

          sandbox.push_global_proc("__std__exit__", 1) do |ptr|
            env = ::Duktape::Sandbox.new(ptr)
            exit_code = env.require_int 0
            exit(exit_code)
            env.call_success
          end

          sandbox.eval! <<-JS
            const process = {
              exit : function (exitCode) {
                __std__exit__(exitCode);
              },
            };
          JS
        end
      end
    end
  end
end
