module Murg
  module Macros
    module ScrolledWindow
      macro build_callbacks
        index = Engine.instance.sandbox.push_object

        # TODO: Add callbacks for the scrolled_window widget.

        Engine.instance.sandbox.put_global_string(scrolled_window.id)
        Engine.instance.register_component(id: scrolled_window.id, type: kind, class_name: scrolled_window.class_name, available_callbacks: available_callbacks)
      end
    end
  end
end
