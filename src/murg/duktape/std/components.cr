require "http/client"

module Murg
  module Duktape
    module Std
      module Components
        macro components
          # Append the module to the registered module list.
          registered_modules.push("components")
        end
      end
    end
  end
end
