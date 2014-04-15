import 'dart:html';
import 'package:logging/logging.dart';
import 'package:move_me/move_me.dart';

void registerGameKeys(Game game){
  window.onKeyUp.listen((KeyboardEvent e) {
    game.move(e.keyCode);
  });
}

void setUpLogging(){
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    var text = '${rec.level.name}: ${rec.time}: ${rec.message}'; 
    print(text);
  });
}

void preventScrollbarsFromScrolling(){
  window.onKeyDown.listen((KeyboardEvent e) {
    if([KeyCode.UP ,KeyCode.DOWN,KeyCode.LEFT,KeyCode.RIGHT].contains(e.keyCode)){
      e.preventDefault();
    }
  });
}


void main() {
  setUpLogging();
  
  //final Logger log = new Logger('move_me.dart');
  preventScrollbarsFromScrolling();

  Game game = new Game();
  registerGameKeys(game);

  CanvasElement canvasElement = querySelector("#board") as CanvasElement;
  var canvasAdapter = new CanvasAdapter(canvasElement);     
  canvasAdapter.setupBoard();
  
  game.onGameStateChanged.listen((GameEvent evt){
    canvasAdapter.update(evt.rows);
    var div =querySelector('#score') as DivElement;
    div.text = 'Score: ${evt.score}';
  });
  game.start();
}
