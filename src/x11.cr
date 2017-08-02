require "./x11/c/*"
require "./x11/*"

module X11
  # Returns the string representation of a given *keysym*.
  #
  # ###Arguments
  # - **keysym** Specifies the `X::C::KeySym` that is to be converted.
  #
  # ###Description
  # The returned string is in a static area and must not be modified.
  # The returned string is in the Host Portable Character Encoding.
  # If the specified `KeySym` is not defined, returns an empty `String`.
  #
  # ###See also
  # `Display::keycode_to_keysym`, `KeyEvent::lookup_keysym`.
  def self.keysym_to_string(keysym : X11::C::KeySym) : String
    pstr = X.keysym_to_string keysym
    return "" if pstr.null?
    str = String.new pstr
    X.free pstr
    str
  end

  # Returns the KeySym representation of a given *string*.
  #
  # ###Arguments
  # - **string** Specifies the name of the KeySym that is to be converted.
  #
  # ###Description
  # Standard KeySym names are obtained from `x11/c/keysymdef.cr` by removing the
  # XK_ prefix from each name. KeySyms that are not part of the Xlib standard also
  # may be obtained with this function. The set of KeySyms that are available in
  # this manner and the mechanisms by which Xlib obtains them is implementation dependent.
  #
  # If the KeySym name is not in the Host Portable Character Encoding, the
  # result is implementation dependent. If the specified string does not match
  # a valid KeySym, `string_to_keysym` returns `NoSymbol`.
  #
  # ###See also
  # `convert_case`, `Display::keycode_to_keysym`, `keysym_to_string`, `KeyEvent::lookup_keysym`.
  def self.string_to_keysym(string : String) : X11::C::KeySym
    X.string_to_keysym string.to_unsafe
  end

  # Returns GC-context from GC.
  #
  # ###Arguments
  # - **gc** Specifies the GC for which you want the resource ID.
  #
  # ###See also
  # `Display::all_planes`, `Display::change_gc`, `Display::copy_area`,
  # `Display::copy_gc`, `Display::create_gc`, `Display::draw_arc`,
  # `Display::draw line`, `Display::draw_rectangle`, `Display::draw_text`,
  # `Display::fill_rectangle`, `Display::free_gc`, `Display::gc_values`,
  # `Display::query_best_size`, `Display::set_arc_mode`, `Display::set_clip_origin`.
  def self.g_context_from_gc(gc : X11::C::X::GC) : X11::C::GContext
    X.g_context_from_gc gc
  end

  # Initializes Xlib support for concurrent threads.
  #
  # ###Description
  # The `init_threads` function initializes Xlib support for concurrent threads.
  # This function must be the first Xlib function a multi-threaded program calls,
  # and it must complete before any other Xlib call is made. This function
  # returns a nonzero status if initialization was successful; otherwise, it returns zero.
  # On systems that do not support threads, this function always returns zero.
  # It is only necessary to call this function if multiple threads might use Xlib
  # concurrently. If all calls to Xlib functions are protected by some other access
  # mechanism (for example, a mutual exclusion lock in a toolkit or through explicit
  # client programming), Xlib thread initialization is not required. It is recommended
  # that single-threaded programs not call this function.
  #
  # ###See also
  # `Display::lock`, `Display::unlock`.
  def self.init_threads : X11::C::Status
    X.init_threads
  end

  # Returns the first extension data structure for the extension numbered number.
  #
  # ###Arguments
  # - **structure** Specifies the extension list.
  # - **number** Specifies the extension number from `Display::init_extension`.
  #
  # ###Description
  # The `find_on_extension_list` function returns the first extension data
  # structure for the extension numbered number. It is expected that an extension
  # will add at most one extension data structure to any single data structure's
  # extension data list. There is no way to find additional structures.
  def self.find_on_extension_list(structure : X11::C::X::PExtData*, number : Int32) : ExtData?
    pdata = X.find_on_extension_list structure, number
    return nil if pdata.null?
    ExtData.new pdata
  end

  # Returns a value with all bits set to 1 suitable for use in a plane argument to a procedure.
  def self.all_planes : UInt64
    X.all_planes
  end

  # Sets the error handler.
  #
  # ###Arguments
  # - **handler** Specifies the program's supplied error handler.
  #
  # ###Description
  # Xlib generally calls the program's supplied error handler whenever an error
  # is received. It is not called on **BadName** errors from **OpenFont**,
  # **LookupColor**, or **AllocNamedColor** protocol requests or on **BadFont**
  # errors from a **QueryFont** protocol request. These errors generally are
  # reflected back to the program through the procedural interface. Because this
  # condition is not assumed to be fatal, it is acceptable for your error handler
  # to return; the returned value is ignored. However, the error handler should
  # not call any functions (directly or indirectly) on the display that will generate
  # protocol requests or that will look for input events. The previous error handler is returned.
  #
  # ###See also
  # `display_name`, `Display::error_database_text`, `Display::error_text`,
  # `Display::new`, `set_io_error_handler`, `Display::synchronize`.
  def self.set_error_handler(handler : X11::C::X::ErrorHandler) : X11::C::X::ErrorHandler
    X.set_error_handler handler
  end

  # Sets the I/O error handler.
  #
  # ###Arguments
  # - **handler** Specifies the program's supplied error handler.
  #
  # ###Description
  # The `set_io_error_handler` sets the fatal I/O error handler. Xlib calls the
  # program's supplied error handler if any sort of system call error occurs
  # (for example, the connection to the server was lost). This is assumed to be
  # a fatal condition, and the called routine should not return. If the I/O error
  # handler does return, the client process exits.
  #
  # Note that the previous error handler is returned.
  #
  # ###See also
  # `display_name`, `Display::error_database_text`, `Display::error_text`,
  # `Display::new`, `set_error_handler`, `Display::synchronize`.
  def self.set_io_error_handler(handler : X11::C::X::IOErrorHandler) : X11::C::X::IOErrorHandler
    X.set_io_error_handler handler
  end

  # Releases memory.
  #
  # ###Arguments
  # - **list** Specifies the list of strings to be freed.
  #
  # ###Description
  # The `free_string_list` function releases memory allocated by
  # `Display::mb_text_property_to_text_list` and `TextProperty::to_string_list`
  # and the missing charset list allocated by `Display::create_font_set`.
  #
  # ###See also
  # `X11::alloc_class_hint`, `X11::alloc_icon_size`, `X11::alloc_size_hints`,
  # `X11::alloc_wm_hints`, `X11::free`, `Display::set_command`,
  # `Display::set_transient_for_hint`, `Display::set_text_property`,
  # `Display::set_wm_client_machine`, `Display::set_wm_colormap_windows`,
  # `Display::set_wm_icon_name`, `Display::set_wm_name`, `Display::set_wm_properties`,
  # `Display::set_wm_protocols`, `string_list_to_text_property`, `TextProperty::to_string_list`.
  @[AlwaysInline]
  def self.free_string_list(list : PPChar)
    X.free_string_list list
  end
end
