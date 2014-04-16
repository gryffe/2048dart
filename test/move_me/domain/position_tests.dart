part of domain_tests;

void position_tests(){
  group('position',(){
    test('create',(){
      var e = new Position(0,0);
      expect(e.x, 0);
      expect(e.y,0);
    });
    test('toString', (){
      var e = new Position(1,1);
      expect(e.toString(), '(1,1)');
    });
    test('==', (){
      var e = new Position(1,1);
      var other = new Position(1,1);
      assert(e==other);
    });
    test('equals', (){
      var e = new Position(1,1);
      var other = new Position(1,1);
      assert(e.equals(other));
    });
    test('create throws',(){
      expect((){new Position(null,null);}, throws);
    });
    
    
  });
}