require "./module"

# private def register_create_button
#   sandbox.push_global_proc("_createButton", 1) do |ptr|
#     env = ::Duktape::Sandbox.new(ptr)

#     begin
#       pointer = ::Box(Gtk::Widget).unbox(env.require_pointer(0))
#       element = Elements::Button.new({} of String => JSON::Any, [] of Elements::Node)

#       widget = element.build_widget(pointer)

#       env.push_string(widget.name)
#       env.call_success
#     rescue exception
#       raise exception
#     end
#   end
# end

# private def register_create_box
#   sandbox.push_global_proc("_createBox", 1) do |ptr|
#     env = ::Duktape::Sandbox.new(ptr)

#     begin
#       pointer = ::Box(Gtk::Widget).unbox(env.require_pointer(0))
#       element = Elements::Box.new({} of String => JSON::Any, [] of Elements::Node)

#       widget = element.build_widget(pointer)

#       env.push_string(widget.name)
#       env.call_success
#     rescue exception
#       env.call_failure
#       raise exception
#     end
#   end
# end

# private def register_create_label
#   sandbox.push_global_proc("_createLabel", 1) do |ptr|
#     env = ::Duktape::Sandbox.new(ptr)

#     begin
#       pointer = ::Box(Gtk::Widget).unbox(env.require_pointer(0))
#       element = Elements::Label.new({} of String => JSON::Any, [] of Elements::Node)

#       widget = element.build_widget(pointer)

#       env.push_string(widget.name)
#       env.call_success
#     rescue exception
#       env.call_failure
#       puts exception
#       raise exception
#     end
#   end
# end

# private def register_create_entry
#   sandbox.push_global_proc("_createEntry", 1) do |ptr|
#     env = ::Duktape::Sandbox.new(ptr)

#     begin
#       pointer = ::Box(Gtk::Widget).unbox(env.require_pointer(0))
#       element = Elements::Entry.new({} of String => JSON::Any, [] of Elements::Node)

#       widget = element.build_widget(pointer)

#       env.push_string(widget.name)
#       env.call_success
#     rescue exception
#       env.call_failure
#       puts exception
#       raise exception
#     end
#   end
# end

# private def register_get_widget_by_id
#   sandbox.push_global_proc("_getWidgetById", 1) do |ptr|
#     env = ::Duktape::Sandbox.new(ptr)

#     begin
#       id = env.require_string(0)
#       widget = Registry.instance.registered_components[id]

#       env.push_pointer(::Box.box(widget))

#       env.call_success
#     rescue exception
#       env.call_failure
#       raise exception
#     end
#   end
# end

module Murg
  module JavaScript
    module StandardLibrary
      class Element < Module
        property sandbox : Duktape::Sandbox

        def initialize(@sandbox : Duktape::Sandbox)
          @sandbox.eval_mutex! "std.element = {};"
        end

        def name : String
          "Element"
        end

        def module_name : String
          "element"
        end

        def description : String
          "Element module allows the user to create GUI components."
        end

        def definitions : Array(Definition)
          @sandbox.push_global_proc("stdElementGetElementById", 1) do |ptr|
            env = ::Duktape::Sandbox.new(ptr)

            begin
              id = env.require_string(0)
              component = Registry.instance.registered_components[id]

              env.push_pointer(::Box.box(component.widget))

              env.call_success
            rescue exception
              Log.error(exception: exception) { exception.message }

              LibDUK::Err::Error.to_i
            end
          end

          @sandbox.eval_mutex! "std.element.getElementById = function(id) { return stdElementGetElementById(id); };"

          [ElementDefinitions::Button.new(@sandbox)] of Definition
        end
      end
    end
  end
end
