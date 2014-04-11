part of move_me.domain;

class Field {
  static const int emptyValue = -1;
  int value;
  Position _position;
  Position get position => _position;

  Field(this._position, [this.value = emptyValue]) {
    assert(_position != null);
  }

  bool get isSelected => value != emptyValue;
  int get column => position.x;
  int get row => position.y;

  Field clone(){
    return new Field(position, value);
  }
  
  bool areEqual(Field other) {
    if (other == null) {
      return false;
    }
    return other.position == position && other.value == value;
  }
}

