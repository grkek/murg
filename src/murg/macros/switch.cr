module Murg
  module Macros
    module Switch
      macro build_callbacks
        available_callbacks = [] of String

        index = Engine.instance.sandbox.push_object

        # TODO: Add callbacks for the switch widget.

        Engine.instance.sandbox.put_global_string(switch.id)
        Engine.instance.register_component(id: switch.id, type: kind, class_name: switch.class_name, available_callbacks: available_callbacks)
      end
    end
  end
end
