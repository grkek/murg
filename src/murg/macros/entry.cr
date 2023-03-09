module Murg
  module Macros
    module Entry
      macro build_callbacks
        available_callbacks = [] of String

        index = Engine.instance.sandbox.push_object

        # TODO: Add callbacks for the entry widget.

        Engine.instance.sandbox.put_global_string(entry.id)
        Engine.instance.register_component(id: entry.id, type: kind, class_name: entry.class_name, available_callbacks: available_callbacks)
      end
    end
  end
end
