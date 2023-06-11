module Murg
  module Macros
    module Box
      macro build_callbacks
        available_callbacks = [] of String

        index = Engine.instance.sandbox.push_object

        # TODO: Add callbacks for the box widget.
        # set_id = ->(argument : JSON::Any) { Murg::Registry.instance.update(box.id, argument.to_s); argument }

        # build_callback("setId", 1, set_id)

        Engine.instance.sandbox.put_global_string(box.id)
        # Engine.instance.register_component(id: box.id, type: kind, class_name: box.class_name, available_callbacks: available_callbacks)
      end
    end
  end
end
