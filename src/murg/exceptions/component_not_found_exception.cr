module Murg
  module Exceptions
    class ComponentNotFoundException < Exception
      def initialize(id)
        super("Component #{id} was not found!")
      end
    end
  end
end
