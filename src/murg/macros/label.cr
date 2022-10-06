module Murg
  module Macros
    module Label
      macro build_callbacks
        available_callbacks = [] of String
        index = Engine.instance.sandbox.push_object

        # TODO: Add callbacks for the label widget.

        Engine.instance.sandbox.put_global_string(label.id)
        Engine.instance.register_component(id: label.id, type: kind, class_name: label.class_name, available_callbacks: available_callbacks)
      end
    end
  end
end
