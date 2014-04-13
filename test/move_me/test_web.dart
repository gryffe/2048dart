library test_web;

import 'dart:html';
import 'package:logging/logging.dart';
import 'package:unittest/unittest.dart';
import 'package:mock/mock.dart';

import 'package:move_me/src/web.dart';

class CanvasElementMock extends Mock implements CanvasElement{}

void main(){
  final Logger log = new Logger('test_web');
  
  group('board',(){
    test('create',(){
      var board = new CanvasAdapter(new CanvasElementMock());  
      expect(board, isNotNull);
    });
  });
}
