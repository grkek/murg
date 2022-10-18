module Murg
  module Duktape
    module Std
      module System
        macro system
          # Append the module to the registered module list.
          registered_modules.push("system")

          sandbox.push_global_proc("__std__cpu_count__", 0) do |ptr|
            env = ::Duktape::Sandbox.new(ptr)
            env.push_int(System.cpu_count)
            env.call_success
          end

          sandbox.push_global_proc("__std__hostname__", 0) do |ptr|
            env = ::Duktape::Sandbox.new(ptr)
            env.push_string(System.hostname)
            env.call_success
          end

          sandbox.eval! <<-JS
            const system = {
              getCpuCount : function () {
                return __std__cpu_count__();
              },
              getHostname : function () {
                return __std__hostname__();
              }
            };
          JS
        end
      end
    end
  end
end
