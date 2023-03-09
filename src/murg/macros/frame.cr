module Murg
  module Macros
    module Frame
      macro build_callbacks
        available_callbacks = [] of String

        index = Engine.instance.sandbox.push_object

        # TODO: Add callbacks for the frame widget.

        Engine.instance.sandbox.put_global_string(frame.id)
        Engine.instance.register_component(id: frame.id, type: kind, class_name: frame.class_name, available_callbacks: available_callbacks)
      end
    end
  end
end
