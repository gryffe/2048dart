part of move_me.domain;

class Field {
  final String red = '#FA5858';
  final String yellow = '#F3F781';
  final String reddish = '#FA5858';
  final String green = '#669966';
  final String blue = '#2BB8FF';
  final String orange = '#FFC02B';
  final String black = '#000000';
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
    switch(value){
      case 2:
       return orange;
      case 4:
        return green;
      case 8:
        return red;
      case 16:
        return yellow;
      case 32:
        return reddish;
      case 64:
        return blue;
      default:
        return orange;        
    }
  }
  
  String toString(){
    return '${position.toString()}: $value';
  }
  
  String get color => _valueToColor();
  String get textColor => black;
  
  void clear() {
    value = emptyValue;
  }
}

