part of move_me.domain;


class GameEvent {
  int get score{
    return Util.getSelected(rows).map((field)=>field.value).reduce((value, nextValue)=>value+nextValue);
  }
  
  Iterable<Iterable<Field>> rows;
}

class Board {
  List<Field> _fields;
  List<Field> _snapshot;
  Map<Position, int> _positionToIndex;
  int _size;
  int get size => _size;
  FieldRandomizer _randomizer;
  FieldValueUpdater _fieldvalueupdater;

  factory Board.withRandomizer(FieldRandomizer fieldrandomizer, [size = 4]){
    var fieldvalueupdater = new FieldValueUpdater();
    return new Board._withDefaultParameters(fieldrandomizer, fieldvalueupdater,size);
  }
  
  factory Board._withDefaultParameters(FieldRandomizer fieldrandomizer, FieldValueUpdater fieldvalueupdater, [size = 4]) {
    assert(fieldrandomizer != null);
    var board = new Board._create(fieldrandomizer, size);
    board._fieldvalueupdater = fieldvalueupdater;
    return board;
  }

  Iterable<Field> get fields=> _fields;
  
  Board._create(this._randomizer, [this._size = 4]) {
    _fields = new List<Field>();
    _snapshot = new List<Field>();
    _positionToIndex = new Map<Position, int>();
    _resolvePositions();
    takeSnapshot();
  }

  factory Board() {
    var fieldrandomizer = new FieldRandomizer();
    return new Board.withRandomizer(fieldrandomizer);
  }

  takeSnapshot() {
    _snapshot.clear();
    _snapshot.addAll(_fields.map((field) => field.clone()));
  }

  _resolvePositions() {
    for (var y = 0; y < size; y++) {
      for (var x = 0; x < size; x++) {
        var position = new Position(x, y);
        _positionToIndex[position] = _fields.length;
        _fields.add(new Field(position));
      }
    }
  }

  void undo(){
    _fields.clear();
    _fields.addAll(_snapshot);
  }
  
  String toString(){
    var lines = rows.map((Iterable<Field> row){
      var line = row.join("||");
      return line;
    });
    return lines.toList().reversed.join('\n');
  }
  
  Iterable<Iterable<Field>> _getFields(bool isSearchedField(Field element, int index)) {
    List<Iterable<Field>> result = new List<Iterable<Field>>();
    for (int i = 0; i < _size; i++) {
      result.add(_fields.where((field) => isSearchedField(field, i)));
    }
    return result;
  }

  Iterable<Iterable<Field>> get columns => _getFields((field, column) => field.column == column);

  Iterable<Iterable<Field>> get rows => _getFields((field, row) => field.row == row);

  Iterable<Field> get freeFields => _fields.where((field) => !field.isSelected);


  GameEvent createGameEvent(){
    var gameEvent = new GameEvent();
    gameEvent.rows = rows;
    return gameEvent;
  }
  
  GameEvent _move(Iterable<Iterable<Field>> rowsOrColumns) {
    var items = rowsOrColumns.toList();
    takeSnapshot();
    rowsOrColumns.forEach((rowOrColumn) => setNewValues(rowOrColumn));
    if (isChanged(_snapshot, _fields)) {
      _selectRandomField(freeFields);
    }
    return createGameEvent();
  }

  void clear(){
    _fields.forEach((Field field)=>field.clear());
  }
  
  setNewValues(Iterable<Field> fields) {
    var values = fields.where((field) => field.isSelected).map((field) => field.value).toList();
    if (values.length == 0) {
      return;
    }
    var e = doubleFirstDuplicateElement(values).iterator;
    fields.forEach((field) {
      field.value = e.moveNext() ? e.current : Field.emptyValue;
    });
  }

  GameEvent moveLeft() {
    return _move(rows);
  }

  GameEvent moveRight() {
    return _move(rows.map((row) => row.toList().reversed));
  }

  GameEvent moveUp() {
    return _move(columns);
  }

  GameEvent moveDown() {
    return _move(columns.map((column) => column.toList().reversed));
  }

  static Iterable<int> doubleFirstDuplicateElement(Iterable<int> values) {
    assert(values.length >= 1);
    var result = new List<int>();
    result.add(values.first);
    var e = values.skip(1).iterator;
    while (e.moveNext()) {
      if (e.current == result.last) {
        result[result.length - 1] = 2 * e.current;
        break;
      }
      result.add(e.current);
    }
    while (e.moveNext()) {
      result.add(e.current);
    }
    return result;
  }

  void occupyTwoRandomFields()
   {
       var first = _getSelectedRandomField(_fields);
       var res = new List<Field>();
       //_fields.
       var restOfFields = _fields.where((Field test){
         bool areEqual = test.areEqual(first);
         return !areEqual;
       }).toList();
          
       _selectRandomField(restOfFields);
   }
  
  void _selectRandomField(Iterable<Field> fields) {
    _getSelectedRandomField(fields);
  }
  
  Field _getSelectedRandomField(Iterable<Field> fields) {
    return _randomizer.selectRandomFieldFrom(fields);
  }

  static bool isChanged(List<Field> left, List<Field> right) {
    for (int i = 0; i < left.length; i++) {
      var areEqual = left[i].areEqual(right[i]);
      if (!areEqual) {
        return true;
      }
    }
    return false;
  }

}

class FieldValueUpdater {
  void setNewFieldValues(Iterable<Field> fields) {
    var values = fields.where((field) => field.value > Field.emptyValue).map((field) => field.value);
    if (values.length == 0) {
      return;
    }
    var e = doubleFirstDuplicateElement(values).iterator;
    fields.forEach((field) {
      field.value = e.moveNext() ? e.current : 0;
    });
  }

  static Iterable<int> doubleFirstDuplicateElement(Iterable<int> values) {
    assert(values.length >= 1);
    var result = new List<int>();
    result.add(values.first);
    var e = values.skip(1).iterator;
    while (e.moveNext()) {
      if (e.current == result.last) {
        result[result.length - 1] = 2 * e.current;
        break;
      }
      result.add(e.current);
    }
    while (e.moveNext()) {
      result.add(e.current);
    }
    return result;
  }

}
