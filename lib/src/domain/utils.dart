part of move_me.domain;

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

class Util{
  static Iterable<Field> getSelected(Iterable<Iterable<Field>> rows){
    var fields = new List<Field>();
    rows.forEach((Iterable<Field> row) {
      row.forEach((Field field) {
        if(field.isSelected){
          fields.add(field);  
        }
      });
    });
    return fields;    
  }
  
}