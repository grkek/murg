require "./node"
require "./generic"

module Murg
  module Elements
    class EventBox < Generic
      getter kind : String = "EventBox"
      getter attributes : Hash(String, JSON::Any)

      def initialize(@attributes, @children = [] of Node)
        super(@kind, @attributes, @children)
      end
    end
  end
end
