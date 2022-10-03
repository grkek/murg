module Murg
  module Attributes
    class Generic
      include JSON::Serializable

      @[JSON::Field(key: "id")]
      property id : String = Helpers::ULID.generate.downcase

      @[JSON::Field(key: "className")]
      property class_name : String = UUID.random.to_s
    end
  end
end
