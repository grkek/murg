module Murg
  module Macros
    module TextView
      macro build_callbacks
        available_callbacks = [] of String

        index = Engine.instance.sandbox.push_object

        # TODO: Add callbacks for the text_view widget.
        # set_id = ->(argument : JSON::Any) { Murg::Registry.instance.update(text_view.id, argument.to_s); argument }

        # build_callback("setId", 1, set_id)

        Engine.instance.sandbox.put_global_string(text_view.id)
        # Engine.instance.register_component(id: text_view.id, type: kind, class_name: text_view.class_name, available_callbacks: available_callbacks)
      end
    end
  end
end
