part of move_me.domain;

class Field {
  final String green = '#669966';
  final String blue = '#2BB8FF';
  final String orange = '#FFC02B';
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
  
  String _valueToColor(){
    String color = orange;
    if(value==emptyValue){
      return '';
    }
    return orange;
    
  }
  
  String toString(){
    return '${position.toString()}: $value';
  }
  
  String get color => _valueToColor();
  
  void clear() {
    value = emptyValue;
  }
}

