module Murg
  class Registry
    @@instance = new

    def self.instance
      @@instance
    end

    property registered_components : Helpers::Synchronized(Hash(String, Murg::Component)) = Helpers::Synchronized(Hash(String, Murg::Component)).new

    def process_event(id : String)
      component = registered_components[id]

      component.properties do |properties|
      end
    end

    def register(component : Murg::Component)
      component.properties do |properties|
        properties["motionNotify"] = JSON::Any.new("function() {}")
        properties["focusChange"] = JSON::Any.new("function() {}")

        properties["onPress"] = JSON::Any.new("function() {}")
        properties["onRelease"] = JSON::Any.new("function() {}")

        properties["onKeyPress"] = JSON::Any.new("function() {}")
      end

      registered_components[component.id] = component
    end

    def unregister(id : String)
      registered_components.delete(id)
    end
  end
end
