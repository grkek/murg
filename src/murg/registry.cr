module Murg
  class Registry
    @@instance = new

    def self.instance
      @@instance
    end

    property registered_widgets : Helpers::Synchronized(Hash(String, Gtk::Widget)) = Helpers::Synchronized(Hash(String, Gtk::Widget)).new

    def register(id : String, widget : Gtk::Widget)
      registered_widgets[id] = widget
    end

    def unregister(id : String)
      registered_widgets.delete(id)
    end
  end
end
