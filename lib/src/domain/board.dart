part of move_me.domain;

class Board {
  List<Field> _fields;
  List<Field> _snapshot;
  Map<Position, int> _positionToIndex;
  int _size;
  int get size => _size;
  FieldRandomizer _randomizer;
  FieldValueUpdater _fieldvalueupdater;
  
  factory Board._withDefaultParameters(FieldRandomizer fieldrandomizer, FieldValueUpdater fieldvalueupdater, [size=4]){
    assert(fieldrandomizer!=null);
    var board = new Board(fieldrandomizer,size);
    board._fieldvalueupdater = fieldvalueupdater;
    return board;
  }
  
   Board(this._randomizer, [this._size=4])  {
    assert(_randomizer != null);
    _fields = new List<Field>();
    _snapshot = new List<Field>();
    _positionToIndex = new Map<Position, int>();
    _resolvePositions();
    takeSnapshot();
  }
  
  takeSnapshot() {
    _snapshot.clear();
    _snapshot.addAll(_fields.map((field)=>field.clone()));
  }
  
  _resolvePositions()
  {
      for (var y = 0; y < size; y++)
      {
          for (var x = 0; x < size; x++)
          {
              var position = new Position(x, y);
              _positionToIndex[position]=_fields.length;
              _fields.add(new Field(position));
          }
      }
  }
  
  Iterable<Iterable<Field>> _getFields(bool isSearchedField(Field element,int index)){
    List<Iterable<Field>> result = new List<Iterable<Field>>();    
    for(int i =0;i< _size; i++){
      result.add(_fields.where((field)=>isSearchedField(field,i)));
    }
    return result;
  }
  
  Iterable<Iterable<Field>> get columns => _getFields((field,column)=>field.column==column); 

  Iterable<Iterable<Field>> get rows => _getFields((field,row)=>field.row==row);

  Iterable<Field> get freeFields => _fields.where((field)=>!field.isSelected);
  
   _move(Iterable<Iterable<Field>> rowsOrColumns)
  {
      takeSnapshot();
      rowsOrColumns.forEach((rowOrColumn)=> setNewValues(rowOrColumn));
      if (isChanged(_snapshot,_fields))
      {
          _getSelectedRandomField(freeFields);
      }
  }
  
  setNewValues(Iterable<Field> fields) {
    var values = fields.where((field)=>field.value>Field.emptyValue).map((field)=>field.value);
    if(values.length==0){
      return;
    }
    var e = doubleFirstDuplicateElement(values).iterator;
    fields.forEach((field){
      field.value = e.moveNext() ? e.current : 0;
    });
    
  }
  
  moveLeft()
  {
      _move(rows);
  }

  moveRight()
  {
      _move(rows.map((row)=>row.toList().reversed));
  }

  moveUp()
  {
    _move(columns.map((column)=>column.toList().reversed));
  }

  moveDown()
  {
    _move(columns);
  }
  
  static Iterable<int> doubleFirstDuplicateElement(Iterable<int> values) {
    assert(values.length>=1);
    var result = new List<int>();
    result.add(values.first);
    var e = values.skip(1).iterator;
    while(e.moveNext()){
      if(e.current==result.last){
        result[result.length-1] = 2*e.current;
        break;
      }
      result.add(e.current);
    }
    while(e.moveNext()){
      result.add(e.current);
    }
    return result;
  }
  
  Field _getSelectedRandomField(Iterable<Field> fields) {
    return _randomizer.selectRandomFieldFrom(fields);
  }

  static bool isChanged(List<Field> left, List<Field> right) {
    for(int i = 0; i < left.length;i++){
      if(left[i]!=right[i]){
        return false;
      }
    }
    return true;
  }
  
}

class FieldValueUpdater{
  void setNewFieldValues(Iterable<Field> fields){
    var values = fields.where((field)=>field.value>Field.emptyValue).map((field)=>field.value);
    if(values.length==0){
      return;
    }
    var e = doubleFirstDuplicateElement(values).iterator;
    fields.forEach((field){
      field.value = e.moveNext() ? e.current : 0;
    });
  }
  
  static Iterable<int> doubleFirstDuplicateElement(Iterable<int> values) {
    assert(values.length>=1);
    var result = new List<int>();
    result.add(values.first);
    var e = values.skip(1).iterator;
    while(e.moveNext()){
      if(e.current==result.last){
        result[result.length-1] = 2*e.current;
        break;
      }
      result.add(e.current);
    }
    while(e.moveNext()){
      result.add(e.current);
    }
    return result;
  }

}

