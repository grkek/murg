module Murg
  module Macros
    module Box
      macro build_callbacks
        index = Engine.instance.sandbox.push_object

        print_something = ->(argument : JSON::Any) { puts "Hello, World!"; JSON::Any.new(nil) }

        build_callback("printSomething", 0, print_something)

        Engine.instance.sandbox.put_global_string(box.id)
        Engine.instance.register_component(id: box.id, type: kind, class_name: box.class_name, available_callbacks: available_callbacks)
      end
    end
  end
end
