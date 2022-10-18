module Murg
  module Duktape
    module Std
      module FileSystem
        macro fs
          # Append the module to the registered module list.
          registered_modules.push("fs")

          sandbox.push_global_proc("__std__read_file__", 1) do |ptr|
            env = ::Duktape::Sandbox.new(ptr)

            path = env.require_string 0

            File.open(path) do |fd|
              env.push_string(fd.gets_to_end)
            end

            env.call_success
          end

          sandbox.push_global_proc("__std__file_exists__", 1) do |ptr|
            env = ::Duktape::Sandbox.new(ptr)

            path = env.require_string 0

            env.push_boolean File.exists?(path)

            env.call_success
          end

          sandbox.push_global_proc("__std__write_file__", 2) do |ptr|
            env = ::Duktape::Sandbox.new(ptr)

            path = env.require_string 0
            content = env.require_string 1

            File.write(path, content)

            env.call_success
          end

          sandbox.eval! <<-JS
            const fs = {
              sprintf : function(args) { __std__print__(JSON.stringify(args)) },
              readFile : function (filePath) {
                return __std__read_file__(filePath);
              },
              writeFile : function (filePath, fileContent) {
                if(__std__write_file__(filePath, fileContent)){
                  return true;
                } else {
                  return false;
                }
              },
              fileExists : function (filePath) {
                return __std__file_exists__(filePath);
              }
            };
          JS
        end
      end
    end
  end
end
