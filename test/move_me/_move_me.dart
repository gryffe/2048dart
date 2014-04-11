library test_move_me;

//import 'dart:async' as async;
import 'package:unittest/unittest.dart';
import 'package:mock/mock.dart';
import '../../lib/src/domain.dart';

part 'mocks.dart';

void main(){
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
  });
  
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
  });

  var randomMock = new FieldRandomizerMock();
  group('board',(){
    test('create',(){
      var board = new Board(randomMock);  
      expect(board, isNotNull);
    });
    
    test('columns',(){
      var board = new Board(randomMock,1);  
      var columns = board.columns;
      var pos = columns.first.first.position;
      expect(pos, new Position(0,0));
    });
    
    test('rows',(){
      var board = new Board(randomMock,4);  
      var rows = board.rows;
      expect(rows.length,4);
      var pos = rows.first.first.position;
      expect(pos, new Position(0,0));
      pos = rows.first.last.position;
      expect(pos, new Position(3,0));
      pos = rows.last.last.position;
      expect(pos, new Position(3,3));
    });
  });

}