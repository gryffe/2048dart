library domain_tests;

//import 'dart:async' as async;
import 'dart:math';
import 'package:unittest/unittest.dart';
import 'package:mock/mock.dart';
import 'package:move_me/src/domain.dart';

part 'domain/mocks.dart';

part 'domain/color_tests.dart';
part 'domain/math_tests.dart';
part 'domain/position_tests.dart';
part 'domain/field_tests.dart';
part 'domain/board_tests.dart';



void main(){
  math_tests();
  position_tests();
  field_tests();
  board_tests();  
  colorTests();
  utilsTests();
}

void utilsTests() {
  test('except',(){
    var fields = [1,2,3,4].map((value){
      var field = new Field(new Position(value,0));
      field.value = value;
      return field;
    });  

    var tests = {fields.first : [2,3,4],fields.last:[1,2,3],fields.elementAt(1):[1,3,4]};
    tests.forEach((field, expected){
      var except = Utils.except(fields, field);
      expect(except.map((field)=>field.value),expected);
    });
    
  });
}