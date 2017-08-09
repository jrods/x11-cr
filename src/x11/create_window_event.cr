require "./c/Xlib"
require "./event"

module X11
  # Wrapper from `X11::C::X::CreateWindowEvent` structure.
  class CreateWindowEvent < Event
    def initialize
      @event = X11::C::X::CreateWindowEvent.new
    end

    def initialize(event : X11::C::X::PCreateWindowEvent)
      raise BadAllocException.new if event.null?
      @event = event.value
    end

    def initialize(@event : X11::C::X::CreateWindowEvent)
    end

    def to_unsafe : X11::C::X::PCreateWindowEvent
      return pointerof(@event)
    end

    def to_x : X11::C::X::CreateWindowEvent
      @event
    end

    def type : Int32
      @event.type
    end

    def type=(type : Int32)
      @event.type = type
    end

    def serial : UInt64
      @event.serial
    end

    def serial=(serial : UInt64)
      @event.serial = serial
    end

    def send_event : Bool
      @event.send_event ? true : false
    end

    def send_event=(send_event : Bool)
      @event.send_event = send_event ? 1 : 0
    end

    def display : Display
      Display.new @event.display
    end

    def display=(display : Display)
      @event.display = display.to_unsafe
    end

    def window : X11::C::Window
      @event.window
    end

    def window=(window : X11::C::Window)
      @event.window = window
    end

    def x : Int32
      @event.x
    end

    def x=(x : Int32)
      @event.x = x
    end

    def y : Int32
      @event.y
    end

    def y=(y : Int32)
      @event.y = y
    end

    def width : Int32
      @event.width
    end

    def width=(width : Int32)
      @event.width = width
    end

    def height : Int32
      @event.height
    end

    def height=(height : Int32)
      @event.height = height
    end

    def border_width : Int32
      @event.border_width
    end

    def border_width=(border_width : Int32)
      @event.border_width = border_width
    end

    def override_redirect : Bool
      @event.override_redirect ? true : false
    end

    def override_redirect=(override_redirect : Bool)
      @event.override_redirect = override_redirect ? 1 : 0
    end
  end
end
