part of move_me.web;

class Ui{
  void setUpLogging(){
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });
  }
  
  void preventScrollbarsFromScrolling(){
    window.onKeyDown.listen((KeyboardEvent e) {
      if([KeyCode.UP ,KeyCode.DOWN,KeyCode.LEFT,KeyCode.RIGHT].contains(e.keyCode)){
        e.preventDefault();
      }
    });
  }
  
}
