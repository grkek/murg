module Murg
  module Macros
    module Window
      macro build_callbacks
        available_callbacks = [] of String

        index = Engine.instance.sandbox.push_object

        get_id = ->(argument : JSON::Any) { JSON::Any.new(widget.id.to_i64) }
        get_title = ->(argument : JSON::Any) { JSON::Any.new(widget.title) }

        set_title = ->(argument : JSON::Any) { widget.title = argument.to_s; JSON::Any.new(widget.title) }

        maximize = ->(argument : JSON::Any) { widget.maximize; JSON::Any.new(widget.maximized?) }
        minimize = ->(argument : JSON::Any) { widget.minimize; JSON::Any.new(nil) }

        build_callback("getId", 0, get_id)
        build_callback("getTitle", 0, get_title)

        build_callback("setTitle", 1, set_title)

        build_callback("maximize", 0, maximize)
        build_callback("minimize", 0, minimize)

        Engine.instance.sandbox.put_global_string(window.id)
        Engine.instance.register_component(id: window.id, type: kind, class_name: window.class_name, available_callbacks: available_callbacks)
      end
    end
  end
end
