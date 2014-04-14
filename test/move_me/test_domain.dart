library test_domain;

//import 'dart:async' as async;
import 'package:unittest/unittest.dart';
import 'package:mock/mock.dart';
import '../../lib/src/domain.dart';

part 'domain/mocks.dart';

class StrictRandomMock implements FieldRandomizer{
  
  @override
  Field selectRandomFieldFrom(Iterable<Field> fields) {
    var field = fields.first;
    field.value = 4;
    return field;
  }

  @override
  void setRandomFieldValue(Field field) {
    
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
      var board = new Board.withRandomizer(randomMock);  
      expect(board, isNotNull);
    });
    
    test('columns',(){
      var board = new Board.withRandomizer(randomMock, 1);  
      var columns = board.columns;
      var pos = columns.first.first.position;
      expect(pos, new Position(0,0));
    });
    
    test('rows',(){
      var board = new Board.withRandomizer(randomMock, 4);  
      var rows = board.rows;
      expect(rows.length,4);
      var pos = rows.first.first.position;
      expect(pos, new Position(0,0));
      pos = rows.first.last.position;
      expect(pos, new Position(3,0));
      pos = rows.last.last.position;
      expect(pos, new Position(3,3));
    });
    
    
String expected =
'''
(0,3): -1||(1,3): -1||(2,3): -1||(3,3): -1
(0,2): -1||(1,2): -1||(2,2): -1||(3,2): -1
(0,1): -1||(1,1): -1||(2,1): -1||(3,1): -1
(0,0): -1||(1,0): -1||(2,0): -1||(3,0): -1''';
    test('toString',(){
      var board = new Board.withRandomizer(randomMock);
      var toString = board.toString();
      expect(toString, expected);
    });


    Field buildField(int value){
      var field = new Field(new Position(0,0));
      field.value = value;
      return field;
    }
    
    Iterable<Field> buildFields(List<int> values){
      return values.map((int value)=> buildField(value));
    };

    
    test('setNewValues',(){
      var board = new Board.withRandomizer(randomMock);
      var fields = buildFields([1,1,Field.emptyValue,2]).toList();
      board.setNewValues(fields);
      expect(fields[0].value,2);
      expect(fields[1].value,2);
      expect(fields[2].value,Field.emptyValue);
      expect(fields[3].value,Field.emptyValue);
    });

    test('setNewValues -2',(){
      var board = new Board.withRandomizer(randomMock);
      var fields = buildFields([2,Field.emptyValue,Field.emptyValue,2]).toList();
      board.setNewValues(fields);
      expect(fields[0].value,4);
      expect(fields[1].value,Field.emptyValue);
      expect(fields[2].value,Field.emptyValue);
      expect(fields[3].value,Field.emptyValue);
    });

    test('clear',(){
      var board = new Board.withRandomizer(randomMock);
      var field1 = board.fields.elementAt(0);
      var field2 = board.fields.elementAt(1);
      field1.value = 4;
      field2.value = 4;
      expect(board.fields.where((field)=>field.isSelected).length,2);      
      board.clear();
      board.rows.forEach((Iterable<Field> row)=>row.forEach((Field field)=>expect(true, !field.isSelected)));
    });
  });

  
  group('board move',(){
    var strictRandomMock = new StrictRandomMock();
    test('left',(){
      var board = new Board.withRandomizer(strictRandomMock);
      board.occupyTwoRandomFields();
      board.moveLeft();
      expect(board.fields.elementAt(0).value,8);
      expect(board.fields.elementAt(1).value,4);
      expect(board.freeFields.length,14);
    });

    test('right',(){
      var board = new Board.withRandomizer(strictRandomMock);
      board.occupyTwoRandomFields();
      board.moveRight();
      expect(board.fields.elementAt(3).value,8);
      expect(board.fields.elementAt(0).value,4);
      expect(board.freeFields.length,14);
    });

    test('occupyTwoRandomFields',(){
      var board = new Board.withRandomizer(strictRandomMock);
      board.occupyTwoRandomFields();
      expect(board.freeFields.length,14);
      expect(board.fields.elementAt(0).isSelected,isTrue);
      expect(board.fields.elementAt(1).isSelected,isTrue);
      expect(board.fields.elementAt(0).value,4);
      expect(board.fields.elementAt(1).value,4);
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