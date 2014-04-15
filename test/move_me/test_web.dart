library test_web;

import 'dart:html';
import 'package:logging/logging.dart';
import 'package:unittest/unittest.dart';
import 'package:mock/mock.dart';

import 'package:move_me/src/web.dart';
import 'package:move_me/src/domain.dart';
import 'dart:math';

part 'web/mocks.dart';


void main(){
  final Logger log = new Logger('test_web');
  
  group('canvas_adapter',(){
    test('create',(){
      var canvas = new CanvasAdapter(new CanvasElementMock());  
      expect(canvas, isNotNull);
    });
    
    test('valueToColor',(){
      var lastIndex = Colors.wellKnownColorCodesExceptWhiteAndBlack.length -1;
      var canvas = new CanvasAdapter(new CanvasElementMock());  
      var field = new Field(new Position(0,0));
      field.value = pow(2,1);
      var colorCode = canvas.valueToColor(field);
      expect(colorCode,Colors.colorByIndex(0));
      field.value = pow(2,lastIndex +1);
      colorCode = canvas.valueToColor(field);
      expect(colorCode,Colors.colorByIndex(lastIndex));
      field.value = pow(2,lastIndex +2);
      colorCode = canvas.valueToColor(field);
      expect(colorCode,Colors.colorByIndex(0));
    });
    
  });
}
