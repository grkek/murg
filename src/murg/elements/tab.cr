require "./node"
require "./generic"

module Murg
  module Elements
    module Attributes
      class Tab < Murg::Attributes::Base
      end
    end

    class Tab < Generic
      getter kind : String = "Tab"
      getter attributes : Hash(String, JSON::Any)

      def initialize(@attributes, @children = [] of Node)
        super(@kind, @attributes, @children)
      end

      def build_widget(parent : Gtk::Widget) : Gtk::Widget
        tab = Attributes::Tab.from_json(attributes.to_json)
        container_attributes = Murg::Attributes::Container.from_json(attributes.to_json)

        widget = Gtk::Notebook.new(name: tab.id, halign: tab.horizontal_alignment, valign: tab.vertical_alignment)

        register_component()
        register_events(widget)
        register_widget(widget)
        containerize(parent, widget, container_attributes)
        add_class_to_css(widget, tab.class_name)

        widget
      end
    end
  end
end
