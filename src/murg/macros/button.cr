module Murg
  module Macros
    module Button
      macro build_callbacks
        index = Engine.instance.sandbox.push_object

        get_text = ->(argument : JSON::Any) {
          case widget
          when Gtk::Button
            JSON::Any.new(widget.label)
          else
            raise Exceptions::RuntimeException.new("Invalid type provided for the closure.")
          end
        }

        set_text = ->(argument : JSON::Any) {
          case widget
          when Gtk::Button
            widget.label = argument.to_s
            JSON::Any.new(widget.label)
          else
            raise Exceptions::RuntimeException.new("Invalid type provided for the closure.")
          end
        }

        build_callback("getText", 0, get_text)
        build_callback("setText", 1, set_text)

        Engine.instance.sandbox.put_global_string(button.id)
        Engine.instance.register_component(id: button.id, type: kind, class_name: button.class_name, available_callbacks: available_callbacks)
      end
    end
  end
end
