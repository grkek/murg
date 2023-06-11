module Murg
  module Macros
    module ListBox
      macro build_callbacks
        available_callbacks = [] of String

        index = Engine.instance.sandbox.push_object

        # TODO: Add callbacks for the list_box widget.
        # set_id = ->(argument : JSON::Any) { Murg::Registry.instance.update(list_box.id, argument.to_s); argument }

        # build_callback("setId", 1, set_id)

        Engine.instance.sandbox.put_global_string(list_box.id)
        # Engine.instance.register_component(id: list_box.id, type: kind, class_name: list_box.class_name, available_callbacks: available_callbacks)
      end
    end
  end
end
