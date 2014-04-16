part of move_me.web;

class GameEvent {
  int get score{
    return selectedFields.map((field)=>field.value).reduce((value, nextValue)=>value+nextValue);
  }
  Iterable<Field> selectedFields;
}

typedef void _Action();

class Game {
  void startEventLoop() {
  }

  void stopEventLoop() {
  }

  
  void raiseGameEvent(GameEvent evt) {
    if (_controller == null){
      return;
    }
    _controller.add(evt);
  }

  
  Stream<GameEvent> _getEventStream() {
    if (_controller != null) {
      throw new StateError("Should only create one streamcontroller - for now");
    }
    _controller = new StreamController<GameEvent>(onListen: startEventLoop, onPause: stopEventLoop, onResume: startEventLoop, onCancel: stopEventLoop);

    return _controller.stream.asBroadcastStream();
  }

  StreamController<GameEvent> _controller;

  final Logger log = new Logger('Game');
  Keyboard _keyboard;
  Board _board;

  Map<int, _Action> _actions;
  List<int> _keys = [KeyCode.CTRL, KeyCode.ALT, KeyCode.SHIFT];

  Game._create(this._keyboard, this._board) {
    _actions = new Map<int, _Action>();
    _actions[KeyCode.UP] = moveUp;
    _actions[KeyCode.DOWN] = moveDown;
    _actions[KeyCode.LEFT] = moveLeft;
    _actions[KeyCode.RIGHT] = moveRight;
  }

  factory Game() {
    var keyboard = new Keyboard.withWindow(window);
    var board = new Board();
    return new Game._create(keyboard, board);
  }

  Stream<GameEvent> get onGameStateChanged => _getEventStream();

  

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
    bool isCtrlZPressed = _keyboard.isPressed(KeyCode.CTRL)&&keyCode==KeyCode.Z;
    if(isCtrlZPressed){
      undo();
      return;
    }

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
    _board.moveUp();
    notify();
  }

  void moveDown() {
    log.info("moveDown");
    _board.moveDown();
    notify();
  }

  void moveLeft() {
    log.info("moveLeft");
    _board.moveLeft();
    notify();
  }

  void moveRight() {
    log.info("moveRight");
    _board.moveRight();
    notify();
  }
  
  void start(){
    log.info("board - random fields selected");
    _board.occupyTwoRandomFields();
    notify();
  }
  
  void undo(){
    log.info("undo");
    _board.undo();
    notify();    
  }
  
  void notify(){
    var gameEvent = new GameEvent();
    gameEvent.selectedFields = _board.selectedFields;
    raiseGameEvent(gameEvent);
  }
  
}
