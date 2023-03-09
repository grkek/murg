module Murg
  module JavaScript
    module Message
      struct Request
        include JSON::Serializable

        @[JSON::Field(key: "id")]
        property id : String

        @[JSON::Field(key: "directory")]
        property directory : String

        @[JSON::Field(key: "file")]
        property file : String

        @[JSON::Field(key: "line")]
        property line : Int32

        @[JSON::Field(key: "processing")]
        property processing : Processing

        @[JSON::Field(key: "sourceCode")]
        property source_code : String?

        def initialize(@id : String, @directory : String, @file : String, @line : Int32, @processing : Processing, @source_code : String?)
        end
      end
    end
  end
end
