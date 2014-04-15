part of move_me.web;


class Keyboard {

  Window _window;
  
  void _initialize(){
    _keys = new Map<int, int>();
    _window.onKeyDown.listen((KeyboardEvent e) {
      if (!_keys.containsKey(e.keyCode))
        _keys[e.keyCode] = e.timeStamp;
     });

    _window.onKeyUp.listen((KeyboardEvent e) {
      _keys.remove(e.keyCode);
    });
    
    _window.onFocus.listen((onData){
      _keys.clear();
    });    
  }
  
  factory Keyboard.withWindow(Window aWindow){
    var keyboard = new Keyboard();
    keyboard._window=aWindow;
    keyboard._initialize();
    return keyboard;
  }
  
  Keyboard(){
    
  }
  
  Map<int, int> _keys;


  /**
   * Check if the given key code is pressed. You should use the [KeyCode] class.
   */
  isPressed(int keyCode) => _keys.containsKey(keyCode);
}