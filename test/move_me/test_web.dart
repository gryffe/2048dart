library test_web;

import 'dart:html';
import 'package:logging/logging.dart';
import 'package:unittest/unittest.dart';
import 'package:mock/mock.dart';

import 'package:move_me/src/web.dart';

part 'web/mocks.dart';


void main(){
  final Logger log = new Logger('test_web');
  
  group('board',(){
    test('create',(){
      var canvas = new CanvasAdapter(new CanvasElementMock());  
      expect(canvas, isNotNull);
    });
  });
}
