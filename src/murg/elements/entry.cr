require "./node"
require "./generic"

module Murg
  module Elements
    module Attributes
      class Entry < Murg::Attributes::Base
        include JSON::Serializable

        @[JSON::Field(key: "text")]
        property text : String?

        @[JSON::Field(key: "placeHolder")]
        property place_holder : String?

        @[JSON::Field(key: "passwordCharacter")]
        property password_character : String?

        @[JSON::Field(key: "isVisible")]
        property is_visible : Bool = true
      end
    end

    class Entry < Generic
      getter kind : String = "Entry"
      getter attributes : Hash(String, JSON::Any)

      def initialize(@attributes, @children = [] of Node)
        super(@kind, @attributes, @children)
      end

      def build_widget(parent : Gtk::Widget) : Gtk::Widget
        entry = Attributes::Entry.from_json(attributes.to_json)
        container_attributes = Murg::Attributes::Container.from_json(attributes.to_json)

        widget = Gtk::Entry.new(name: entry.id, text: entry.text, placeholder_text: entry.place_holder, invisible_char: entry.password_character.try(&.bytes.first.to_u32), visibility: entry.is_visible, halign: entry.horizontal_alignment, valign: entry.vertical_alignment)

        Macros::Entry.build_callbacks

        register_events(widget)
        register_widget(widget)
        containerize(parent, widget, container_attributes)
        add_class_to_css(widget, entry.class_name)

        widget
      end
    end
  end
end
