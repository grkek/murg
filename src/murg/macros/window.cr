module Murg
  module Macros
    module Window
      macro build_callbacks
        index = Engine.instance.sandbox.push_object

        # TODO: Add callbacks for the window widget.

        Engine.instance.sandbox.put_global_string(window.id)
        Engine.instance.register_component(id: window.id, type: kind, class_name: window.class_name, available_callbacks: available_callbacks)
      end
    end
  end
end
