require "./node"
require "./generic"

module Murg
  module Elements
    class Script < Generic
      getter kind : String = "Script"
      getter attributes : Hash(String, JSON::Any)

      def initialize(@attributes, @children = [] of Node)
        super(@kind, @attributes, @children)
      end
    end
  end
end
