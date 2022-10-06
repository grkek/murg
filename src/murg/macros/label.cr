module Murg
  module Macros
    module Label
      macro build_callbacks
        available_callbacks = [] of String
        index = Engine.instance.sandbox.push_object

        get_current_uri = ->(argument : JSON::Any) { JSON::Any.new(widget.current_uri) }
        get_ellipsize = ->(argument : JSON::Any) { JSON::Any.new(widget.ellipsize.to_s) }
        get_justify = ->(argument : JSON::Any) { JSON::Any.new(widget.justify.to_s)  }
        get_label = ->(argument : JSON::Any) { JSON::Any.new(widget.label) }
        get_lines = ->(argument : JSON::Any) { JSON::Any.new(widget.lines.to_i64) }
        get_max_width_chars = ->(argument : JSON::Any) { JSON::Any.new(widget.max_width_chars.to_i64) }
        get_mnemonic_keyval = ->(argument : JSON::Any) { JSON::Any.new(widget.mnemonic_keyval.to_i64) }
        get_natural_wrap_mode = ->(argument : JSON::Any) { JSON::Any.new(widget.natural_wrap_mode.to_s) }
        is_selectable = ->(argument : JSON::Any) { JSON::Any.new(widget.selectable) }
        has_selection_bounds = ->(argument : JSON::Any) { JSON::Any.new(widget.selection_bounds) }
        is_single_line_mode = ->(argument : JSON::Any) { JSON::Any.new(widget.single_line_mode) }
        get_text = ->(argument : JSON::Any) { JSON::Any.new(widget.text) }
        get_use_markup = ->(argument : JSON::Any) { JSON::Any.new(widget.use_markup) }
        get_use_underline = ->(argument : JSON::Any) { JSON::Any.new(widget.use_underline) }
        get_width_chars = ->(argument : JSON::Any) { JSON::Any.new(widget.width_chars.to_i64) }
        get_wrap = ->(argument : JSON::Any) { JSON::Any.new(widget.wrap) }
        get_wrap_mode = ->(argument : JSON::Any) { JSON::Any.new(widget.wrap_mode.to_s) }
        get_xalign = ->(argument : JSON::Any) { JSON::Any.new(widget.xalign) }
        get_yalign = ->(argument : JSON::Any) { JSON::Any.new(widget.yalign) }

        # set_current_uri = ->(argument : JSON::Any) { widget.current_uri = argument.to_s; JSON::Any.new(widget.current_uri) }
        set_ellipsize = ->(argument : JSON::Any) { widget.ellipsize = Pango::EllipsizeMode.parse(argument.to_s); JSON::Any.new(widget.ellipsize.to_s) }
        set_justify = ->(argument : JSON::Any) { widget.justify = Gtk::Justification.parse(argument.to_s); JSON::Any.new(widget.justify.to_s)  }
        set_label = ->(argument : JSON::Any) { widget.label = argument.to_s; JSON::Any.new(widget.label) }
        set_lines = ->(argument : JSON::Any) { widget.lines = argument.as_i; JSON::Any.new(widget.lines.to_i64) }
        set_max_width_chars = ->(argument : JSON::Any) { widget.max_width_chars = argument.as_i; JSON::Any.new(widget.max_width_chars.to_i64) }
        # set_mnemonic_keyval = ->(argument : JSON::Any) { widget.mnemonic_keyval = argument.as_i; JSON::Any.new(widget.mnemonic_keyval.to_i64) }
        set_natural_wrap_mode = ->(argument : JSON::Any) { widget.natural_wrap_mode = Gtk::NaturalWrapMode.parse(argument.to_s); JSON::Any.new(widget.natural_wrap_mode.to_s) }
        set_is_selectable = ->(argument : JSON::Any) { widget.selectable = argument.as_bool; JSON::Any.new(widget.selectable) }
        # set_has_selection_bounds = ->(argument : JSON::Any) { widget.selection_bounds = argument.as_bool; JSON::Any.new(widget.selection_bounds) }
        set_is_single_line_mode = ->(argument : JSON::Any) { widget.single_line_mode = argument.as_bool; JSON::Any.new(widget.single_line_mode) }
        set_text = ->(argument : JSON::Any) { widget.text = argument.to_s; JSON::Any.new(widget.text) }
        set_use_markup = ->(argument : JSON::Any) { widget.use_markup = argument.as_bool; JSON::Any.new(widget.use_markup) }
        set_use_underline = ->(argument : JSON::Any) { widget.use_underline = argument.as_bool; JSON::Any.new(widget.use_underline) }
        set_width_chars = ->(argument : JSON::Any) { widget.width_chars = argument.as_i; JSON::Any.new(widget.width_chars.to_i64) }
        set_wrap = ->(argument : JSON::Any) { widget.wrap = argument.as_bool; JSON::Any.new(widget.wrap) }
        set_wrap_mode = ->(argument : JSON::Any) { widget.wrap_mode = Pango::WrapMode.parse(argument.to_s); JSON::Any.new(widget.wrap_mode.to_s) }
        set_xalign = ->(argument : JSON::Any) { widget.xalign = argument.as_f32; JSON::Any.new(widget.xalign) }
        set_yalign = ->(argument : JSON::Any) { widget.yalign = argument.as_f32; JSON::Any.new(widget.yalign) }

        build_callback("getCurrentUri", 0, get_current_uri)
        build_callback("getEllipsize", 0, get_ellipsize)
        build_callback("getJustify", 0, get_justify)
        build_callback("getLabel", 0, get_label)
        build_callback("getLines", 0, get_lines)
        build_callback("getMaxWidthChars", 0, get_max_width_chars)
        build_callback("getMnemonicKeyval", 0, get_mnemonic_keyval)
        build_callback("getNaturalWrapMode", 0, get_natural_wrap_mode)
        build_callback("isSelectable", 0, is_selectable)
        build_callback("hasSelectionBounds", 0, has_selection_bounds)
        build_callback("isSingleLineMode", 0, is_single_line_mode)
        build_callback("getText", 0, get_text)
        build_callback("getUseMarkup", 0, get_use_markup)
        build_callback("getUseUnderline", 0, get_use_underline)
        build_callback("getWidthChars", 0, get_width_chars)
        build_callback("getWrap", 0, get_wrap)
        build_callback("getWrapMode", 0, get_wrap_mode)
        build_callback("getXAlign", 0, get_xalign)
        build_callback("getYAlign", 0, get_yalign)

        build_callback("setEllipsize", 1, set_ellipsize)
        build_callback("setJustify", 1, set_justify)
        build_callback("setLabel", 1, set_label)
        build_callback("setLines", 1, set_lines)
        build_callback("setMaxWidthChars", 1, set_max_width_chars)
        build_callback("setNaturalWrapMode", 1, set_natural_wrap_mode)
        build_callback("setIsSelectable", 1, set_is_selectable)
        build_callback("setIsSingleLineMode", 1, set_is_single_line_mode)
        build_callback("setText", 1, set_text)
        build_callback("setUseMarkup", 1, set_use_markup)
        build_callback("setUseUnderline", 1, set_use_underline)
        build_callback("setWidthChars", 1, set_width_chars)
        build_callback("setWrap", 1, set_wrap)
        build_callback("setWrapMode", 1, set_wrap_mode)
        build_callback("setXAlign", 1, set_xalign)
        build_callback("setYAlign", 1, set_yalign)

        Engine.instance.sandbox.put_global_string(label.id)
        Engine.instance.register_component(id: label.id, type: kind, class_name: label.class_name, available_callbacks: available_callbacks)
      end
    end
  end
end
