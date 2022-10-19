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
      include Std::Document

      property registered_modules : Array(String) = [] of String
      property sandbox : ::Duktape::Sandbox

      @@instance = new

      def self.instance
        @@instance
      end

      def initialize
        @sandbox = ::Duktape::Sandbox.new

        # Evaluate Babel source code for a modern JavaScript interface.
        sandbox.eval!(Storage.get("babel.js").gets_to_end)

        misc()
        process()
        gtk()
        net()
        fs()
        system()
        document()

        # This is the method used to capture the required modules by the require function.
        sandbox.eval!("const exports = {};")

        # TODO: Re-work the require function to have a better way of module identification.
        sandbox.eval! <<-JS
          const require = function(filePath) {
            var fullPath = filePath + ".js"

            if(fs.fileExists(fullPath)) {
              var sourceCode = fs.readFile(fullPath)
              eval(Babel.transform(sourceCode, {presets: ['es2015']}).code)

              return exports.default;
            } else {
              throw "File doesn't exist, " + fullPath
            }
          }
        JS

        eval! <<-JS
          String.prototype.format = function() {
              var formatted = this;
              for( var arg in arguments ) {
                  formatted = formatted.replace("{" + arg + "}", arguments[arg]);
              }
              return formatted;
          };
        JS

        # TODO: Some of the functions need to be removed entirely since they make no sense.
        eval! ["const", "registeredModules", "=", registered_modules.to_json].join(" ")
      end

      def register_component(id : String, type : String, class_name : String, available_callbacks : Array(String))
        metadata = {id: id, type: type, className: class_name, availableCallbacks: available_callbacks}

        metadata.keys.each do |key|
          eval! [id, ".", key.to_s, "=", metadata[key].to_json].join
        end
      end

      def handle_event(id : String, event_name : String, arguments)
        eval! [id, ".", event_name, "(", arguments.to_json, ")"].join if arguments
        eval! [id, ".", event_name, "()"].join unless arguments
      end

      def eval!(source : String)
        # Translate code from any paradigm to ES2015 and evaluate it,
        # I do not know yet if double eval is an issue for performance.
        sandbox.eval! transform_to(source: source, preset: "es2015")
      rescue exception
        Log.error(exception: exception) { source }
      end

      private def transform_to(source : String, preset : String)
        ["eval(Babel.transform(", source.to_json, ", {presets: ['#{preset}']}).code)"].join
      end
    end
  end
end
