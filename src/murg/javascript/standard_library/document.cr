require "./module"

module Murg
  module JavaScript
    module StandardLibrary
      class Document < Module
        property sandbox : Duktape::Sandbox

        def initialize(@sandbox : Duktape::Sandbox)
          register_get_widget_by_id

          register_create_box
          register_create_button
          register_create_entry
          register_create_label
        end

        def name : String
          "Document"
        end

        def module_name : String
          "document"
        end

        def description : String
          "Document module to allow the users to create GUI components."
        end

        private def register_create_button
          sandbox.push_global_proc("_createButton", 1) do |ptr|
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
        end

        private def register_create_box
          sandbox.push_global_proc("_createBox", 1) do |ptr|
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
        end

        private def register_create_label
          sandbox.push_global_proc("_createLabel", 1) do |ptr|
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
        end

        private def register_create_entry
          sandbox.push_global_proc("_createEntry", 1) do |ptr|
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
        end

        private def register_get_widget_by_id
          sandbox.push_global_proc("_getWidgetById", 1) do |ptr|
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
        end

        def module_definition : String
          <<-JS
            {
              createBox: function(element) {
                var widget = _getWidgetById(element.id);
                var widgetId = _createBox(widget);

                return globalThis[widgetId];
              },
              createButton: function(element) {
                var widget = _getWidgetById(element.id);
                var widgetId = _createButton(widget);

                return globalThis[widgetId];
              },
              createEntry: function(element) {
                var widget = _getWidgetById(element.id);
                var widgetId = _createEntry(widget);

                return globalThis[widgetId];
              },
              createLabel: function(element) {
                var widget = _getWidgetById(element.id);
                var widgetId = _createLabel(widget);

                return globalThis[widgetId];
              },
              createBox: function() {
                return createBox({id: "mainWindow"});
              },
              createButton: function() {
                return createButton({id: "mainWindow"});
              },
              createEntry: function() {
                return createEntry({id: "mainWindow"});
              },
              createLabel: function() {
                return createLabel({id: "mainWindow"});
              },
              getElementById: function(id) { return globalThis[id]; }
            };
          JS
        end
      end
    end
  end
end
