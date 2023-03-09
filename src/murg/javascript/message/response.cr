module Murg
  module JavaScript
    module Message
      struct Response
        include JSON::Serializable

        @[JSON::Field(key: "request")]
        property request : Request

        @[JSON::Field(key: "exception")]
        property exception : Exception?

        def initialize(@request : Request, exception : ::Exception?)
          Exception.new(exception.message, exception.backtrace)
        end
      end
    end
  end
end
