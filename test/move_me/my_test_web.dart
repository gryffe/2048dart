library my_test_web;

import 'package:logging/logging.dart';
//import 'package:unittest/unittest.dart';
import '../../lib/src/web.dart';
import 'dart:html';


typedef void _Action();

class Game {
  final Logger log = new Logger('Game');
  Keyboard _keyboard;

  Map<int, _Action> _actions;
  List<int> _keys = [KeyCode.CTRL, KeyCode.ALT, KeyCode.SHIFT];


  Game(this._keyboard) {
    _actions = new Map<int, _Action>();
    _actions[KeyCode.UP] = moveUp;
    _actions[KeyCode.DOWN] = moveDown;
    _actions[KeyCode.LEFT] = moveLeft;
    _actions[KeyCode.RIGHT] = moveRight;

  }

  bool isAnyControlOrAltOrShiftKeyPressed() {
    bool isPressed = false;
    for (int key in _keys) {
      if (_keyboard.isPressed(key)) {
        isPressed = true;
        break;
      }
    }
    return isPressed;
  }

  void move(int keyCode) {
    if (isAnyControlOrAltOrShiftKeyPressed()) {
      return;
    }
    if (!_actions.keys.contains(keyCode)) {
      return;
    }
    _actions[keyCode]();
  }

  void moveUp() {
    log.info("moveUp");
  }

  void moveDown() {
    log.info("moveDown");
  }

  void moveLeft() {
    log.info("moveLeft");
  }

  void moveRight() {
    log.info("moveRight");
  }

}

void registerGameKeys(Game game){
  window.onKeyUp.listen((KeyboardEvent e) {
    game.move(e.keyCode);
  });
}

void buildBoard() {
  final int widthAndHeight = 4;
  final int widthAndHeightPx = widthAndHeight * 100;
  final int fieldPx = (widthAndHeightPx / widthAndHeight).round();
  final int leftOfBoard = 0;
  final int topOfBoard = 0;
  
  CanvasElement board = querySelector("#board") as CanvasElement;
  var ctx = board.context2D;
  
  var e = new CanvasAdapter(board);     
  e.setupBoard();
}

void main() {
  
  var ui = new Ui();
  ui.setUpLogging();
  
  final Logger log = new Logger('test_web');
  ui.preventScrollbarsFromScrolling();

  var kv = new Keyboard.withWindow(window);
  var game = new Game(kv);
  registerGameKeys(game);

  buildBoard();
}
