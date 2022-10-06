module Murg
  module Macros
    module ListBox
      macro build_callbacks
        available_callbacks = [] of String
        index = Engine.instance.sandbox.push_object

        # TODO: Add callbacks for the list_box widget.

        Engine.instance.sandbox.put_global_string(list_box.id)
        Engine.instance.register_component(id: list_box.id, type: kind, class_name: list_box.class_name, available_callbacks: available_callbacks)
      end
    end
  end
end
