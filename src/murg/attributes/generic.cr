module Murg
  module Attributes
    class Generic
      include JSON::Serializable
      include Helpers::Randomizer

      @[JSON::Field(key: "id")]
      property id : String = Helpers::Randomizer.random_string

      @[JSON::Field(key: "className")]
      property class_name : String = Helpers::Randomizer.random_string
    end
  end
end
