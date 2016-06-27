import CX11.Xlib
import CX11.X

var d: _XPrivDisplay
var w: Window
var e = UnsafeMutablePointer<_XEvent>.alloc(1)
var msg = "Hello Swift World"
var s: UnsafeMutablePointer<Screen>

d = XOpenDisplay(nil)
if d == nil {
	fatalError("cannot open display")
}

s = XDefaultScreenOfDisplay(d)

let rootWindow = s.memory.root

w = XCreateSimpleWindow(d, rootWindow, 10, 10, 200, 100, 1, s.memory.black_pixel, s.memory.white_pixel)

XSelectInput(d, w, ExposureMask | KeyPressMask)
XMapWindow(d, w)

loop: while true {
  XNextEvent(d, e)

  switch e.memory.type {
    case Expose:
    XFillRectangle(d, w, s.memory.default_gc, 20, 20, 10, 10) // draw a small black rectangle
    XDrawString(d, w, s.memory.default_gc, 10, 70, msg, Int32(msg.characters.count)) // draw the text

    case KeyPress:
    break loop

    default: fatalError("Unknown Event")
  }
}

