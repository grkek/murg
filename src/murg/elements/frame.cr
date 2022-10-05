require "./node"
require "./generic"

module Murg
  module Elements
    module Attributes
      class Frame < Murg::Attributes::Base
        include JSON::Serializable

        @[JSON::Field(key: "text")]
        property text : String?
      end
    end

    class Frame < Generic
      getter kind : String = "Frame"
      getter attributes : Hash(String, JSON::Any)

      def initialize(@attributes, @children = [] of Node)
        super(@kind, @attributes, @children)
      end

      def build_widget(parent : Gtk::Widget) : Gtk::Widget
        available_callbacks = [] of String
        frame = Attributes::Frame.from_json(attributes.to_json)
        container_attributes = Murg::Attributes::Container.from_json(attributes.to_json)

        widget = Gtk::Frame.new(name: frame.id, label: frame.text, halign: frame.horizontal_alignment, valign: frame.vertical_alignment)

        Macros::Frame.build_callbacks()

        register_events(widget)
        register_widget(widget)
        containerize(parent, widget, container_attributes)
        add_class_to_css(widget, frame.class_name)

        widget
      end
    end
  end
end
