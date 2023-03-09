require "./module"

module Murg
  module JavaScript
    module StandardLibrary
      class Minuscule < Module
        property sandbox : Duktape::Sandbox

        def initialize(@sandbox : Duktape::Sandbox)
          register_print
        end

        def name : String
          "Minuscule"
        end

        def module_name : String
          "minuscule"
        end

        def description : String
          "Minuscule functionality to help with development."
        end

        private def register_print
          sandbox.push_global_proc("_print", LibDUK::VARARGS) do |ptr|
            env = ::Duktape::Sandbox.new ptr
            nargs = env.get_top
            output = String.build do |str|
              nargs.times do |index|
                str << " " unless index == 0
                str << env.safe_to_string index
              end
            end

            puts output

            env.return_undefined
          end
        end

        def module_definition : String
          <<-JS
            {};
          JS
        end
      end
    end
  end
end
