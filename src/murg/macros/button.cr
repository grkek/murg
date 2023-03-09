module Murg
  module Macros
    module Button
      macro build_callbacks
        available_callbacks = [] of String

        index = Engine.instance.sandbox.push_object

        get_label : Proc(JSON::Any, JSON::Any) = ->(argument : JSON::Any) { JSON::Any.new(widget.label) }
        set_label = ->(argument : JSON::Any) { widget.label = argument.to_s; JSON::Any.new(widget.label) }
        get_has_frame = ->(argument : JSON::Any) { JSON::Any.new(widget.has_frame) }
        set_has_frame = ->(argument : JSON::Any) { widget.has_frame = argument.as_bool; JSON::Any.new(widget.has_frame) }
        get_icon_name = ->(argument : JSON::Any) { JSON::Any.new(widget.icon_name) }
        set_icon_name = ->(argument : JSON::Any) { widget.icon_name = argument.to_s; JSON::Any.new(widget.icon_name) }
        get_use_underline = ->(argument : JSON::Any) { JSON::Any.new(widget.use_underline) }
        set_use_underline = ->(argument : JSON::Any) { widget.use_underline = argument.as_bool; JSON::Any.new(widget.use_underline) }

        build_callback("getLabel", 0, get_label)
        build_callback("setLabel", 1, set_label)
        build_callback("getHasFrame", 0, get_has_frame)
        build_callback("setHasFrame", 1, set_has_frame)
        build_callback("getIconName", 0, get_icon_name)
        build_callback("setIconName", 1, set_icon_name)
        build_callback("getUseUnderline", 0, get_use_underline)
        build_callback("setUseUnderline", 1, set_use_underline)

        Engine.instance.sandbox.put_global_string(button.id)
        Engine.instance.register_component(id: button.id, type: kind, class_name: button.class_name, available_callbacks: available_callbacks)
      end
    end
  end
end
