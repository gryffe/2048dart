part of domain_tests;

void field_tests(){
  group('field',(){
    test('create',(){
      var e = new Field(new Position(0,0));
      expect(e.column, 0);
      expect(e.row,0);
      expect(e.value, Field.emptyValue);
      var other = new Field(new Position(0,0),42);
      expect(other.value, 42);
    });
    test('throws',() {
      expect(()=> new Field(null),throws);
    });
    
    test('assignments',() {
      var field = new Field(new Position(0,0));
      expect(field.assignmentCount,0);
      field.value = pow(2,1);
      expect(field.assignmentCount,1);
      field.value = pow(2,15);
      expect(field.assignmentCount,15);
      field.value = 1024;
      expect(field.assignmentCount,10);
    });
    
  });

}