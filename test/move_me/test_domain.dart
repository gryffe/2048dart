library test_domain;

//import 'dart:async' as async;
import 'package:unittest/unittest.dart';
import 'package:mock/mock.dart';
import '../../lib/src/domain.dart';

part 'mocks.dart';

class WithFactory{
  factory WithFactory(){
    
  }
}

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
  
  group('board, static',(){
    test('removeFirstDuplicateElement with one element',(){
      var items = [1];
      var result =Board.doubleFirstDuplicateElement(items);
      expect(result,items);
    });  
    test('removeFirstDuplicateElement with no duplicates',(){
      var items = [1,2,3,4];
      var result =Board.doubleFirstDuplicateElement(items);
      expect(result,items);
    });  
    test('removeFirstDuplicateElement with one duplicate, last',(){
      var items = [1,2,3,3];
      var result =Board.doubleFirstDuplicateElement(items);
      expect(result,[1,2,6]);
    });  
    test('removeFirstDuplicateElement with one duplicate, first',(){
      var items = [1,1,3,4];
      var result =Board.doubleFirstDuplicateElement(items);
      expect(result,[2,3,4]);
    });  
    test('removeFirstDuplicateElement with two duplicates',(){
      var items = [2,2,2,2];
      var result =Board.doubleFirstDuplicateElement(items);
      expect(result,[4,2,2]);
    });  
  });
}