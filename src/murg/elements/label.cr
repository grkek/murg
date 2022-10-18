require "./node"
require "./generic"

module Murg
  module Elements
    module Attributes
      class Label < Murg::Attributes::Base
      end
    end

    class Label < Generic
      getter kind : String = "Label"
      getter attributes : Hash(String, JSON::Any)

      def initialize(@attributes, @children = [] of Node)
        super(@kind, @attributes, @children)
      end

      def build_widget(parent : Gtk::Widget) : Gtk::Widget
        label = Attributes::Label.from_json(attributes.to_json)
        container_attributes = Murg::Attributes::Container.from_json(attributes.to_json)
        text = children.first.as(Text).content.to_s if children.size != 0

        widget = Gtk::Label.new(name: label.id, label: text, halign: label.horizontal_alignment, valign: label.vertical_alignment, wrap: true)

        Macros::Label.build_callbacks

        register_events(widget)
        register_widget(widget)
        containerize(parent, widget, container_attributes)
        add_class_to_css(widget, label.class_name)

        widget
      end
    end
  end
end
