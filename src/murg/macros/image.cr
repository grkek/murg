module Murg
  module Macros
    module Image
      macro build_callbacks
        available_callbacks = [] of String

        index = Engine.instance.sandbox.push_object

        # TODO: Add callbacks for the image widget.

        Engine.instance.sandbox.put_global_string(image.id)
        Engine.instance.register_component(id: image.id, type: kind, class_name: image.class_name, available_callbacks: available_callbacks)
      end
    end
  end
end
