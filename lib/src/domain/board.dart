part of domain.model;

class Board {
  List<Field> _fields;
  List<Field> _snapshot;
  Map<Position, int> _positionToIndex;
  int _size;
  int get size => _size;
  FieldRandomizer _randomizer;
  Board(this._randomizer, [this._size=4]) {
    assert(_randomizer != null);
    _fields = new List<Field>();
    _snapshot = new List<Field>();
    _positionToIndex = new HashMap<Position, int>();
    _resolvePositions();
    takeSnapshot();
  }
  
  takeSnapshot() {
    _snapshot.clear();
    _snapshot.addAll(_fields.map((field)=>field.clone()));
  }
  
  void _resolvePositions()
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
  
}
