require "duktape/runtime"
require "../ext/**"
require "./std/**"

module Murg
  module Duktape
    class Engine
      include Std::Process
      include Std::FileSystem
      include Std::Net
      include Std::Gtk
      include Std::Misc
      include Std::System

      property registered_modules : Array(String) = [] of String
      property sandbox : ::Duktape::Sandbox

      @@instance = new

      def self.instance
        @@instance
      end

      def initialize
        @sandbox = ::Duktape::Sandbox.new

        misc()
        process()
        gtk()
        net()
        fs()
        system()

        eval! <<-JS
          String.prototype.format = function() {
              var formatted = this;
              for( var arg in arguments ) {
                  formatted = formatted.replace("{" + arg + "}", arguments[arg]);
              }
              return formatted;
          };
        JS

        eval! ["const", "registeredModules", "=", registered_modules.to_json].join(" ")
      end

      def register_component(id : String, type : String, class_name : String, available_callbacks : Array(String))
        metadata = {type: type, className: class_name, availableCallbacks: available_callbacks}

        metadata.keys.each do |key|
          eval! [id, ".", key.to_s, "=", metadata[key].to_json].join
        end
      end

      def handle_event(id : String, event_name : String, arguments)
        eval! [id, ".", event_name, "(", arguments.to_json, ")"].join if arguments
        eval! [id, ".", event_name, "()"].join unless arguments
      end

      def eval!(source : String)
        sandbox.eval! source
      rescue exception
        Log.error(exception: exception) { source }
      end
    end
  end
end
