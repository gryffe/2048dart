part of move_me.domain;

class Utils{
  static Iterable<Field> except(Iterable<Field> fields, Field field){
    return fields.where((test)=>!test.areEqual(field));
  }
}

class Debug{
  static final Logger log = new Logger('Debug');
  static void writeLogInfo(Iterable<Iterable<Field>> rows) {
    var countSelected = 0;
    rows.forEach((row) {
      row.forEach((field) {
        if (field.isSelected) {
          countSelected++;
          log.info('row: ${field.row}, column: ${field.column} value: ${field.value}');
        }
      });
    });
    log.info('Selected count $countSelected');
  }
  
}

