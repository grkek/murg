require "./node"
require "./generic"

module Murg
  module Elements
    module Attributes
      class Image < Murg::Attributes::Base
        include JSON::Serializable

        @[JSON::Field(key: "file")]
        property file : String = ""

        @[JSON::Field(key: "width")]
        property width : Int32 = 256

        @[JSON::Field(key: "height")]
        property height : Int32 = 256
      end
    end

    class Image < Generic
      getter kind : String = "Image"
      getter attributes : Hash(String, JSON::Any)

      def initialize(@attributes, @children = [] of Node)
        super(@kind, @attributes, @children)
      end

      def build_widget(parent : Gtk::Widget) : Gtk::Widget
        image = Attributes::Image.from_json(attributes.to_json)
        container_attributes = Murg::Attributes::Container.from_json(attributes.to_json)

        widget = Gtk::Image.new(name: image.id, file: image.file, halign: image.horizontal_alignment, valign: image.vertical_alignment)

        Macros::Image.build_callbacks

        register_events(widget)
        register_widget(widget)
        containerize(parent, widget, container_attributes)
        add_class_to_css(widget, image.class_name)

        widget
      end
    end
  end
end
