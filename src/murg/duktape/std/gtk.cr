require "http/client"

module Murg
  module Duktape
    module Std
      module Gtk
        macro gtk
          # Append the module to the registered module list.
          registered_modules.push("gtk")

          sandbox.push_global_proc("__std__load_style_sheets__", 2) do |ptr|
            env = ::Duktape::Sandbox.new(ptr)
            folder = env.require_string(0)

            if env.is_array(1)
              length = env.get_length(1)

              length.times do |i|
                env.get_prop_index(1, i.to_u32)
                file = env.require_string(-1)

                css_provider = Gtk::CssProvider.new
                css_provider.load_from_path(Path[folder, file].to_s)
                display = Gdk::Display.default.not_nil!

                Gtk::StyleContext.add_provider_for_display(display, css_provider, Gtk::STYLE_PROVIDER_PRIORITY_APPLICATION.to_u32)
              end

              env.call_success
            else
              raise ::Duktape::Error.new("`__std__load_style_sheets__` function requires an array as a second argument.")
            end
          end

          sandbox.push_global_proc("__std__load_style_sheet__", 1) do |ptr|
            env = ::Duktape::Sandbox.new(ptr)
            file = env.require_string(0)

            css_provider = Gtk::CssProvider.new
            css_provider.load_from_path(file)
            display = Gdk::Display.default.not_nil!

            Gtk::StyleContext.add_provider_for_display(display, css_provider, Gtk::STYLE_PROVIDER_PRIORITY_APPLICATION.to_u32)
            env.call_success
          end

          eval! <<-JS
            const gtk = {
              loadStyleSheet: function(path) { __std__load_style_sheet__(path); },
              loadStyleSheets: function(path, sheets) { __std__load_style_sheets__(path, sheets); }
            };
          JS
        end
      end
    end
  end
end
