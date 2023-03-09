module Murg
  module JavaScript
    module StandardLibrary
      abstract class Module
        abstract def name : String
        abstract def description : String

        abstract def module_name : String
        abstract def module_definition : String
      end
    end
  end
end
