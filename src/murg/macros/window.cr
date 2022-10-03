module Murg
  module Macros
    module Window
      macro build_callbacks
        index = Engine.instance.sandbox.push_object

        get_title = ->(argument : JSON::Any) { JSON::Any.new(widget.title) }
        set_title = ->(argument : JSON::Any) { widget.title = argument.to_s ; JSON::Any.new(widget.title) }

        build_callback("getTitle", 0, get_title)
        build_callback("setTitle", 1, set_title)

        Engine.instance.sandbox.put_global_string(window.id)
        Engine.instance.register_component(id: window.id, type: kind, class_name: window.class_name, available_callbacks: available_callbacks)
      end
    end
  end
end
