library my_test_web;

import 'package:logging/logging.dart';
//import 'package:unittest/unittest.dart';
import 'package:move_me/src/domain.dart';
import 'package:move_me/src/web.dart';
import 'dart:html';


void registerGameKeys(Game game){
  window.onKeyUp.listen((KeyboardEvent e) {
    game.move(e.keyCode);
  });
}

void main() {
  
  var ui = new Ui();
  ui.setUpLogging();
  
  final Logger log = new Logger('test_web');
  ui.preventScrollbarsFromScrolling();

  var game = new Game();
  registerGameKeys(game);

  CanvasElement canvasElement = querySelector("#board") as CanvasElement;
  var canvasAdapter = new CanvasAdapter(canvasElement);     
  canvasAdapter.setupBoard();
  
  game.onGameStateChanged.listen((GameEvent evt){
//    var div =querySelector('#scorediv') as DivElement;
//    div.text = 'High five';
    canvasAdapter.update(evt.rows);    
  });
  game.start();
}
