part of move_me.domain;

class Board {
  List<Field> _fields;
  List<Field> _snapshot;
  int _size;
  FieldRandomizer _randomizer;
  FieldValueUpdater _fieldvalueupdater;
  
  factory Board.withRandomizer(FieldRandomizer fieldrandomizer, [size = 4]) {
    var fieldvalueupdater = new FieldValueUpdater();
    return new Board._withDefaultParameters(fieldrandomizer, fieldvalueupdater, size);
  }

  factory Board._withDefaultParameters(FieldRandomizer fieldrandomizer, FieldValueUpdater fieldvalueupdater, [size = 4]) {
    assert(fieldrandomizer != null);
    var board = new Board._create(fieldrandomizer, size);
    board._fieldvalueupdater = fieldvalueupdater;
    return board;
  }


  Board._create(this._randomizer, [this._size = 4]) {
    _fields = new List<Field>();
    _snapshot = new List<Field>();
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
    for (var y = 0; y < _size; y++) {
      for (var x = 0; x < _size; x++) {
        var position = new Position(x, y);
        _fields.add(new Field(position));
      }
    }
  }

  void undo() {
    _fields.clear();
    _fields.addAll(_snapshot);
  }

  String toString() {
    var lines = rows.map((Iterable<Field> row) => row.join("||"));
    return lines.toList().reversed.join('\n');
  }

  Iterable<Iterable<Field>> _getFields(bool columnOrRowPredicate(Field element, int index)) {
    return new Iterable.generate(_size).map((idx) => _fields.where((field) => columnOrRowPredicate(field, idx)));
  }

  Iterable<Iterable<Field>> get columns => _getFields((field, column) => field.column == column);

  Iterable<Iterable<Field>> get rows => _getFields((field, row) => field.row == row);

  Iterable<Field> get freeFields => _fields.where((field) => !field.isSelected);

  Iterable<Field> get selectedFields => _fields.where((field) => field.isSelected);

  Iterable<Field> get fields => _fields;

  void _move(Iterable<Iterable<Field>> rowsOrColumns) {
    takeSnapshot();
    rowsOrColumns.forEach((rowOrColumn) => moveFieldValues(rowOrColumn));
    if (_isFieldsChanged) {
      _selectOneRandomField(freeFields);
    }
  }

  bool get _isFieldsChanged => isChanged(_snapshot, _fields); 
  
  void clear() {
    _fields.forEach((Field field) => field.clear());
  }

  static void moveFieldValues(Iterable<Field> rowOrColumn) {
    var values = rowOrColumn.where((field) => field.isSelected).map((field) => field.value);
    if (values.isEmpty) {
      return;
    }
    var e = squareFirstDuplicate(values).iterator;
    rowOrColumn.forEach((field) {
      field.value = e.moveNext() ? e.current : Field.emptyValue;
    });
  }

  void moveLeft() {
    _move(rows);
  }

  void moveRight() {
    _move(rows.map((row) => row.toList().reversed));
  }

  void moveUp() {
    _move(columns);
  }

  void moveDown() {
    _move(columns.map((column) => column.toList().reversed));
  }

  static Iterable<int> squareFirstDuplicate(Iterable<int> values) {
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

  void occupyTwoRandomFields() {
    var first = _getSelectedRandomField(_fields);
    var res = new List<Field>();
    //_fields.
    var restOfFields = _fields.where((Field test) {
      bool areEqual = test.areEqual(first);
      return !areEqual;
    }).toList();

    _selectOneRandomField(restOfFields);
  }

  void _selectOneRandomField(Iterable<Field> fields) {
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
