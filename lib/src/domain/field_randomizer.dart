part of move_me.domain;

class FieldRandomizer {

  Random _randomField;
  Random _randomValue;
  
  FieldRandomizer() {
    _randomField = new Random();
    _randomValue = new Random();
  }

  void setRandomFieldValue(Field field){
    var value = _randomValue.nextInt(16);
    field.value = value > 12 ? 4 : 2;
  }
  
  Field selectRandomFieldFrom(Iterable<Field> fields) {
    var idx = _randomField.nextInt(fields.length);
    var field = fields.elementAt(idx);
    setRandomFieldValue(field);
    return field;
  }
}
