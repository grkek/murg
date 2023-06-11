module Murg
  class Component
    getter id : String = String.new
    getter class_name : String = String.new

    property widget : Gtk::Widget

    properties : Helpers::Synchronized(Hash(String, JSON::Any)) = Helpers::Synchronized(Hash(String, JSON::Any)).new
    state : Helpers::Synchronized(Hash(String, JSON::Any)) = Helpers::Synchronized(Hash(String, JSON::Any)).new

    id_stack : Helpers::Synchronized(Array(String))
    class_name_stack : Helpers::Synchronized(Array(String))
    property_stack : Helpers::Synchronized(Array(String))
    state_stack : Helpers::Synchronized(Array(String))


    def initialize(@id : String, class_name : String, @widget : Gtk::Widget)
      @properties = Helpers::Synchronized(Hash(String, JSON::Any)).new
      @state = Helpers::Synchronized(Hash(String, JSON::Any)).new

      @property_stack = Helpers::Synchronized(Array(String)).new
      @state_stack = Helpers::Synchronized(Array(String)).new

      @property_stack.push(@properties.to_json)
      @state_stack.push(@state.to_json)

      source_code = [] of String

      source_code.push(["#{id}", ".", "isMounted", " ", "=", " ", "true", ";"].join)

      # Direct calls to the evaluation to make it a bit faster.
      JavaScript::Engine.instance.sandbox.eval_mutex! source_code.join

      # Initialize the class_name for the component.
      update_component(:class_name, class_name) if should_component_update?(:class_name, class_name)
    end

    def id=(id)
      update_component(:id, id) if should_component_update?(:id, id)
    end

    def class_name=(class_name)
      update_component(:class_name, class_name) if should_component_update?(:class_name, class_name)
    end

    def properties
      yield @properties

      update_component(:properties, @properties) if should_component_update?

      @property_stack.push(@properties.to_json)
      @property_stack.delete_at(0)
    end

    def state
      yield @state

      update_component(:state, @state) if should_component_update?

      @state_stack.push(@state.to_json)
      @state_stack.delete_at(0)
    end

    def should_component_update?
      @property_stack.last != @properties.to_json || @state_stack.last != @state.to_json
    end

    def should_component_update?(symbol : Symbol, value : String)
      case symbol
      when :id
        @id != value
      when :class_name
        @class_name != value
      end
    end

    def unmount
      source_code = [] of String

      # Direct calls to the evaluation to make it a bit faster.
      source_code.push(["#{id}", ".", "isMounted", " ", "=", " ", "false", ";"].join)
      JavaScript::Engine.instance.sandbox.eval_mutex! source_code.join

      source_code.clear

      yield

      # Direct calls to the evaluation to make it a bit faster.
      source_code.push(["#{id}", ".", "isMounted", " ", "=", " ", "true", ";"].join)
      JavaScript::Engine.instance.sandbox.eval_mutex! source_code.join
    end

    private def update_component(symbol : Symbol, value : String)
      unmount do
        source_code = [] of String

        case symbol
        when :id
          source_code.push(["const", " ", "#{value}", " ", "=", " ", "#{id}", ";"].join)
          source_code.push(["#{id}", " ", "=", " ", "undefined"].join)

          widget.name = value
          @id = value
        when :class_name
          source_code.push(["#{id}", ".", "className", " ", "=", " ", "\"", "#{value}", "\"", ";"].join)

          @class_name = value
        end

        # Direct calls to the evaluation to make it a bit faster.
        JavaScript::Engine.instance.sandbox.eval_mutex! source_code.join
      end
    end

    private def update_component(symbol : Symbol, value : Helpers::Synchronized(Hash(String, JSON::Any)))
      unmount do
        source_code = [] of String

        case symbol
        when :properties
          source_code.push(["#{id}", ".", "properties", " ", "=", " ", value.to_json.gsub("\"", ""), ";"].join)

          @properties = value
        when :state
          source_code.push(["#{id}", ".", "state", " ", "=", " ", value.to_json, ";"].join)

          @state = value
        end

        # Direct calls to the evaluation to make it a bit faster.
        JavaScript::Engine.instance.sandbox.eval_mutex! source_code.join
      end
    end
  end
end
