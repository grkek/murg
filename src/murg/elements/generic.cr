require "./node"

module Murg
  module Elements
    class Generic < Node
      include JSON::Serializable

      alias Engine = Duktape::Engine

      getter kind : String
      getter attributes : Hash(String, JSON::Any)

      def initialize(@kind, @attributes, @children = [] of Node)
        attributes.merge!({"id" => JSON::Any.new(Helpers::Randomizer.random_string)}) unless attributes["id"]?
      end

      macro register_component
      end

      macro build_callback(function_name, argument_size, callback)
        Engine.instance.sandbox.push_string({{function_name}})
        LibDUK.push_c_function(Engine.instance.sandbox.ctx, build_c_function({{function_name}}, {{argument_size}}), {{argument_size}})

        Engine.instance.sandbox.push_pointer(::Box.box({{callback}}))
        Engine.instance.sandbox.put_prop_string(-2, {{function_name}})

        available_callbacks.push({{function_name}})
        Engine.instance.sandbox.put_prop(index)
      end

      macro build_c_function(function_name, argument_size)
        ->(pointer : Pointer(Void)) {
          env = ::Duktape::Sandbox.new(pointer)

          # Get the closure to call the crystal code form JS
          env.push_current_function()
          env.get_prop_string(-1, {{function_name}})
          callable = ::Box(Proc(JSON::Any, JSON::Any)).unbox(env.get_pointer(-1))

          argument_size = {{argument_size}}

          encoded_data = env.json_encode(0) if argument_size != 0
          argument = JSON.parse(encoded_data) if encoded_data

          begin
            if argument
              return_value = callable.call(argument)
            else
              return_value = callable.call(JSON::Any.new(nil))
            end

            case return_value
            when return_value.as_a?
              # TODO: Add the Array push for array return types.
              env.call_success
            when return_value.as_bool?
              env.push_boolean(return_value.as_bool)
              env.call_success
            when return_value.as_f?
              env.push_number(return_value.as_f)
              env.call_success
            when return_value.as_h?
              # TODO: Add the Hash push for hash return types.
              env.call_success
            when return_value.as_i?
              env.push_int(return_value.as_i)
              env.call_success
            when return_value.as_s?
              env.push_string(return_value.as_s)
              env.call_success
            else
              env.push_null
              env.call_success
            end
          rescue exception
            Log.debug(exception: exception) { }

            env.call_failure
          end
        }
      end

      private def register_events(widget : Gtk::Widget)
        event_controller = Gtk::EventControllerLegacy.new
        generic_attributes = Murg::Attributes::Generic.from_json(attributes.to_json)

        event_controller.event_signal.connect(after: true) do |event|
          case event.event_type
          when Gdk::EventType::KeyPress, Gdk::EventType::KeyRelease
          else
            Engine.instance.handle_event(generic_attributes.id, event.event_type.to_s.camelcase(lower: true), nil)
          end

          false
        end

        widget.add_controller(event_controller)

        event_controller = Gtk::EventControllerKey.new
        event_controller.key_pressed_signal.connect(->(key_value : UInt32, _key_code : UInt32, _modifier_type : Gdk::ModifierType) {
          Engine.instance.handle_event(generic_attributes.id, "keyPressed", key_value)

          true
        })

        widget.add_controller(event_controller)
      end

      private def register_widget(widget : Gtk::Widget)
        generic_attributes = Murg::Attributes::Generic.from_json(attributes.to_json)
        Registry.instance.register(generic_attributes.id, widget)
      end

      # TODO: Substitution can be done in a different way, currently this does not work.
      # def substitution
      #   attributes.each do |key, value|
      #     matches = value.to_s.scan(/\${(.*?)}/)

      #     case matches.size
      #     when 0
      #       attributes[key] = value
      #     else
      #       matches.each do |match|
      #         hash = match.to_h

      #         begin
      #           attributes[key] = JSON::Any.new(value.to_s.gsub(hash[0].not_nil!, Engine.instance.eval!("__std__value_of__(#{hash[1].not_nil!})").to_s))
      #         rescue ex : Exception
      #           raise Exceptions::RuntimeException.new("An exception occured while evaluating a variable format routine: #{ex}")
      #         end
      #       end
      #     end
      #   end
      # end

      private def add_class_to_css(widget, class_name)
        if class_name
          context = widget.style_context
          context.add_class(class_name.not_nil!)
        end
      end

      private def containerize(parent, component, container_attributes)
        case parent
        when Gtk::Notebook
          if container_attributes.container_label
            parent.append_page(component, Gtk::Label.new(label: container_attributes.container_label))
          else
            parent.append_page(component, nil)
          end
        when Gtk::Box
          component.hexpand = container_attributes.expand
          component.vexpand = container_attributes.expand

          margin = container_attributes.padding
          component.margin_top = margin
          component.margin_bottom = margin
          component.margin_start = margin
          component.margin_end = margin

          parent.append(component)
        when Gtk::ScrolledWindow, Gtk::Frame
          parent.child = component
        when Gtk::ListBox
          parent.insert(component, 1_000_000)
        when Gtk::ApplicationWindow
          parent.child = component
        end
      end
    end
  end
end
