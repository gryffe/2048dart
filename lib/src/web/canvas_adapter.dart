part of move_me.web;

class CanvasAdapter {
  static const String font = "20pt Calibri";
  static const String black = '#000000';

  final Logger log = new Logger('CanvasAdapter');
  final int margin = 2;
  final int widthAndHeight = 4;
  final int withAndHeightFactor = 150;
  int widthAndHeightPx;
  int fieldWidthAndHeightPx;
  final int leftOfBoard = 10;
  final int topOfBoard = 10;

  CanvasRenderingContext2D _ctx;
  
  factory CanvasAdapter(CanvasElement canvas) {
    //var width = canvas.width;
    var ctx = canvas.context2D;
    var canvasAdapter = new CanvasAdapter._internal(ctx);
    return canvasAdapter;
  }

  String valueToColor(Field field){
    if(field.isSelected){
      var index = field.assignmentCount-1;
      return Colors.colorByIndex(index);
    }
    throw new StateError('field.isSelected');  
  }
  
  void update(Iterable<Field> fields){
    clear();
    fields.forEach((field)=>draw(field));
    _ctx.fillStyle = black;
    fields.forEach((field)=>drawText(field));
  }
  
  drawText(Field field) {
    var left = field.column * fieldWidthAndHeightPx + leftOfBoard;
    var top = field.row * fieldWidthAndHeightPx + topOfBoard;

    var text = "${field.value}";
    TextMetrics v = _ctx.measureText(text);

    var x = left + margin + fieldWidthAndHeightPx / 2 - v.width / 2;
    var y = top + margin + fieldWidthAndHeightPx / 2;

    _ctx.fillText(text, x, y);
  }
  
  draw(Field field) {
    var left = field.column * fieldWidthAndHeightPx + leftOfBoard;
    var top = field.row * fieldWidthAndHeightPx + topOfBoard;
    _ctx.fillStyle = valueToColor(field);
    _ctx.fillRect(left + margin, top + margin, fieldWidthAndHeightPx - 2 * margin, fieldWidthAndHeightPx - 2 * margin);
  }

  CanvasAdapter._internal(this._ctx) {
    widthAndHeightPx = widthAndHeight * withAndHeightFactor;
    fieldWidthAndHeightPx = (widthAndHeightPx / widthAndHeight).round();
  }

  void clear() {
    _ctx.clearRect(leftOfBoard - margin, topOfBoard - margin, widthAndHeightPx + 2 * margin, widthAndHeightPx + 2 * margin);
    _ctx.font = font;
  }

  void setupBoard() {
    _ctx.rect(leftOfBoard - margin, topOfBoard - margin, widthAndHeightPx + 2 * margin, widthAndHeightPx + 2 * margin);
    _ctx.lineWidth = 1;
    _ctx.strokeStyle = black;
    _ctx.stroke();
  }

}
