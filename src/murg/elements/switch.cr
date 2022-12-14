require "./node"
require "./generic"

module Murg
  module Elements
    module Attributes
      class Switch < Murg::Attributes::Base
        include JSON::Serializable

        @[JSON::Field(key: "state")]
        property state : Bool = false
      end
    end

    class Switch < Generic
      getter kind : String = "Switch"
      getter attributes : Hash(String, JSON::Any)

      def initialize(@attributes, @children = [] of Node)
        super(@kind, @attributes, @children)
      end

      def build_widget(parent : Gtk::Widget) : Gtk::Widget
        switch = Attributes::Switch.from_json(attributes.to_json)
        container_attributes = Murg::Attributes::Container.from_json(attributes.to_json)

        widget = Gtk::Switch.new(name: switch.id, halign: switch.horizontal_alignment, valign: switch.vertical_alignment, state: switch.state)

        Macros::Switch.build_callbacks

        register_events(widget)
        register_widget(widget)
        containerize(parent, widget, container_attributes)
        add_class_to_css(widget, switch.class_name)

        widget
      end
    end
  end
end
