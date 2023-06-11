module Murg
  module Macros
    module Switch
      macro build_callbacks
        available_callbacks = [] of String

        index = Engine.instance.sandbox.push_object

        # TODO: Add callbacks for the switch widget.
        # set_id = ->(argument : JSON::Any) { Murg::Registry.instance.update(switch.id, argument.to_s); argument }

        # build_callback("setId", 1, set_id)

        Engine.instance.sandbox.put_global_string(switch.id)
        # Engine.instance.register_component(id: switch.id, type: kind, class_name: switch.class_name, available_callbacks: available_callbacks)
      end
    end
  end
end
