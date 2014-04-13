part of move_me.web;

class Ui{
  void setUpLogging(){
    Logger.root.level = Level.ALL;
    var debug = querySelector("#debug") as DivElement;
    debug.text ="";
    Logger.root.onRecord.listen((LogRecord rec) {
      var text = '${rec.level.name}: ${rec.time}: ${rec.message}'; 
      //print(text);
      text = HTML_ESCAPE.convert(text) + "<br/>" + debug.innerHtml;
      //debug.appendHtml(HTML_ESCAPE.convert(text) + "<br/>");
      debug.innerHtml = text;
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
