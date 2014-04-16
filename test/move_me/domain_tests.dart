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
}