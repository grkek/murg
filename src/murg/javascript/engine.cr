module Murg
  module JavaScript
    class Engine
      @@instance = new

      server : UNIXServer

      getter sandbox : Duktape::Sandbox
      getter path : String = "/tmp/#{UUID.random}"

      def self.instance
        @@instance
      end

      def initialize
        @sandbox = Duktape::Sandbox.new
        @server = UNIXServer.new(path)

        # Evaluate CoreJS source code for a modern JavaScript interface.
        @sandbox.eval! Storage.get("core.js").gets_to_end

        # Evaluate Babel source code for a modern JavaScript interface.
        @sandbox.eval! Storage.get("babel.js").gets_to_end

        # Initialize the standard library for JavaScript.
        modules = [
          StandardLibrary::Document,
          StandardLibrary::Minuscule,
        ]

        modules.each do |library_module|
          instance = library_module.new(@sandbox)
          @sandbox.eval! ["const", instance.module_name, "=", instance.module_definition].join(" ")
        end

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

        # Handle incomming connections to the socket.
        spawn do
          loop do
            if client = @server.accept?
              spawn handle_client(client)
            end
          end
        end
      end

      private def handle_client(client : UNIXSocket)
        loop do
          request = Message::Request.from_json(client.gets || raise "Empty message provided to the JavaScript engine")

          if source_code = request.source_code
            begin
              eval source_code
            rescue exception
              response = Message::Response.new(request, exception)

              spawn do
                client.puts(response.to_json)
              end
            end
          end
        end
      end

      private def eval(source_code : String, preset : String = "es2015")
        @sandbox.eval! source_code
      rescue exception
        Log.error(exception: exception) { source_code }
      end

      def register_component(id : String, type : String, class_name : String, available_callbacks : Array(String))
        metadata = {id: id, type: type, className: class_name, availableCallbacks: available_callbacks}

        metadata.keys.each do |key|
          eval [id, ".", key.to_s, "=", metadata[key].to_json].join
        end
      end
    end
  end
end
