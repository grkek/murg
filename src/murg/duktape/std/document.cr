require "http/client"

module Murg
  module Duktape
    module Std
      module Document
        macro document
          # Append the module to the registered module list.
          registered_modules.push("document")

          sandbox.push_global_proc("__std__create_button__", 2) do |ptr|
            env = ::Duktape::Sandbox.new(ptr)

            begin
              pointer = ::Box(Gtk::Widget).unbox(env.require_pointer(0))
              element = Elements::Button.new({} of String => JSON::Any, [] of Elements::Node)

              widget = element.build_widget(pointer)

              env.push_string(widget.name)
              env.call_success
            rescue exception
              raise exception
            end
          end

          sandbox.push_global_proc("__std__create_box__", 2) do |ptr|
            env = ::Duktape::Sandbox.new(ptr)

            begin
              pointer = ::Box(Gtk::Widget).unbox(env.require_pointer(0))
              element = Elements::Box.new({} of String => JSON::Any, [] of Elements::Node)

              widget = element.build_widget(pointer)

              env.push_string(widget.name)
              env.call_success
            rescue exception
              env.call_failure
              raise exception
            end
          end

          sandbox.push_global_proc("__std__create_label__", 2) do |ptr|
            env = ::Duktape::Sandbox.new(ptr)

            begin
              pointer = ::Box(Gtk::Widget).unbox(env.require_pointer(0))
              element = Elements::Label.new({} of String => JSON::Any, [] of Elements::Node)

              widget = element.build_widget(pointer)

              env.push_string(widget.name)
              env.call_success
            rescue exception
              env.call_failure
              puts exception
              raise exception
            end
          end

          sandbox.push_global_proc("__std__create_entry__", 2) do |ptr|
            env = ::Duktape::Sandbox.new(ptr)

            begin
              pointer = ::Box(Gtk::Widget).unbox(env.require_pointer(0))
              element = Elements::Entry.new({} of String => JSON::Any, [] of Elements::Node)

              widget = element.build_widget(pointer)

              env.push_string(widget.name)
              env.call_success
            rescue exception
              env.call_failure
              puts exception
              raise exception
            end
          end

          sandbox.push_global_proc("__std__get_widget_by_id__", 1) do |ptr|
            env = ::Duktape::Sandbox.new(ptr)

            begin
              id = env.require_string(0)
              widget = Registry.instance.registered_widgets[id]

              env.push_pointer(::Box.box(widget))

              env.call_success
            rescue exception
              env.call_failure
              raise exception
            end
          end

          sandbox.eval! <<-JS
            const document = {
              createElement: function(element, tagName, id) {
                switch(tagName.toLowerCase()) {
                  case "button":
                    var widget = __std__get_widget_by_id__(element.id);
                    var widgetId = __std__create_button__(widget, tagName);

                    return globalThis[widgetId];
                  case "box":
                    var widget = __std__get_widget_by_id__(element.id);
                    var widgetId = __std__create_box__(widget, tagName);

                    return globalThis[widgetId];
                  case "label":
                    var widget = __std__get_widget_by_id__(element.id);
                    var widgetId = __std__create_label__(widget, tagName);

                    return globalThis[widgetId];

                  case "entry":
                    var widget = __std__get_widget_by_id__(element.id);
                    var widgetId = __std__create_entry__(widget, tagName);

                    return globalThis[widgetId];
                }
              },
              getElementById: function(id) { return globalThis[id]; }
            };
          JS
        end
      end
    end
  end
end
