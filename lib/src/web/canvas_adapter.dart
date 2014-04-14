part of move_me.web;

class CanvasAdapter{
  final Logger log = new Logger('CanvasAdapter');
  final int margin = 2;
  final int widthAndHeight = 4;
  int widthAndHeightPx;
  int fieldPx;
  final int leftOfBoard = 10;
  final int topOfBoard = 10;
  CanvasRenderingContext2D ctx;

  factory CanvasAdapter(CanvasElement canvas){
    var ctx = canvas.context2D;
    var canvasAdapter = new CanvasAdapter._internal(ctx);
    return canvasAdapter;        
  }

  void _debug(Iterable<Iterable<Field>> rows){
    var countSelected =0;
    rows.forEach((row){
      row.forEach((field){
        if(field.isSelected){
          countSelected++;
          log.info('row: ${field.row}, column: ${field.column} value: ${field.value}');
        }
      });
    });
    log.info('Selected count $countSelected');
  }
  
  void update(Iterable<Iterable<Field>> rows){
    clear();
    //_debug(rows);
    rows.forEach((Iterable<Field> row){
      row.forEach((Field field){
        drawFieldAt(field);        
      });
    });
  }
  
  drawFieldAt(Field field) {
    var x = field.column * fieldPx + leftOfBoard;
    var y = field.row * fieldPx + topOfBoard;
    if(field.isSelected){
      _draw(x,y, field);      
    }else{
      //_clear(x,y);
    }
  }
  
  _draw(int left, int top, Field field) {
    ctx.fillStyle = field.color;
    ctx.fillRect(left + margin, top + margin, fieldPx-2*margin, fieldPx-2*margin);
    
    ctx.fillStyle = field.textColor;
    var text = "${field.value}";
    TextMetrics v = ctx.measureText(text);
    
    var x = left + margin + fieldPx/2 - v.width/2;
    var y = top + margin + fieldPx/2;     
    
    ctx.fillText(text, x, y);
    
  }
  
  _clear(int x, int y) {
    ctx.clearRect(x + margin, y + margin, fieldPx-2*margin, fieldPx-2*margin);
    ctx.font = "20pt Calibri";
  }
  
  CanvasAdapter._internal(this.ctx){
    widthAndHeightPx = widthAndHeight * 150;
    fieldPx = (widthAndHeightPx / widthAndHeight).round();
  }

  
  void clear(){
    ctx.clearRect(leftOfBoard - margin, topOfBoard - margin, widthAndHeightPx + 2*margin , widthAndHeightPx + 2*margin);
    ctx.font = "20pt Calibri";
  }
  
  void setupBoard(){
    ctx.rect(leftOfBoard - margin, topOfBoard - margin, widthAndHeightPx + 2*margin , widthAndHeightPx + 2*margin);
    ctx.lineWidth = 1;
    ctx.strokeStyle = '#000000';
    ctx.stroke();
  }
  
}