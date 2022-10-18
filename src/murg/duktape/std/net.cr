require "http/client"

module Murg
  module Duktape
    module Std
      module Net
        macro net
          # Append the module to the registered module list.
          registered_modules.push("http")

          sandbox.push_global_proc("__std__http_request__", 3) do |ptr|
            env = ::Duktape::Sandbox.new(ptr)
            method = env.require_string 0
            path = env.require_string 1
            params = env.require_object 2

            response = HTTP::Client.exec(method, path)
            env.push_string response.body

            env.call_success
          end

          sandbox.eval! <<-JS
            const http = {
              get: function(path, params) { return __std__http_request__("GET", path, params); },
              post: function(path, params) { return __std__http_request__("POST", path, params); }
            };
          JS
        end
      end
    end
  end
end
