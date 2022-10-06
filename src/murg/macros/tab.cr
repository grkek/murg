module Murg
  module Macros
    module Tab
      macro build_callbacks
        available_callbacks = [] of String
        index = Engine.instance.sandbox.push_object

        # TODO: Add callbacks for the tab widget.

        Engine.instance.sandbox.put_global_string(tab.id)
        Engine.instance.register_component(id: tab.id, type: kind, class_name: tab.class_name, available_callbacks: available_callbacks)
      end
    end
  end
end
