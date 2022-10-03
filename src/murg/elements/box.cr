require "./node"
require "./generic"

module Murg
  module Elements
    module Attributes
      class Box < Murg::Attributes::Base
        include JSON::Serializable

        @[JSON::Field(key: "spacing")]
        property spacing : Int32 = 2
      end
    end

    class Box < Generic
      getter kind : String = "Box"
      getter attributes : Hash(String, JSON::Any)

      def initialize(@attributes, @children = [] of Node)
        super(@kind, @attributes, @children)
      end

      def build_widget(parent : Gtk::Widget) : Gtk::Widget
        available_callbacks = [] of String
        box = Attributes::Box.from_json(attributes.to_json)
        container_attributes = Murg::Attributes::Container.from_json(attributes.to_json)

        widget = Gtk::Box.new(name: box.id, orientation: box.orientation, spacing: box.spacing, halign: box.horizontal_alignment, valign: box.vertical_alignment)

        Macros::Box.build_callbacks

        register_events(widget)
        register_widget(widget)
        containerize(parent, widget, container_attributes)
        add_class_to_css(widget, box.class_name)

        widget
      end
    end
  end
end
