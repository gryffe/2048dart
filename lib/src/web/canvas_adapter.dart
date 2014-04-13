part of move_me.web;

class CanvasAdapter{
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
  
  CanvasAdapter._internal(this.ctx){
    widthAndHeightPx = widthAndHeight * 150;
    fieldPx = (widthAndHeightPx / widthAndHeight).round();
  }

  void _fillRect(int left, int top){
    final String blue = '#2BB8FF';
    final String orange = '#FFC02B';;
    ctx.fillStyle= orange;
    ctx.fillRect(left + margin, top + margin, fieldPx-2*margin, fieldPx-2*margin);
    ctx.fillStyle = blue;
    ctx.font = "20pt Calibri";
    
    var text = "($left,$top)";
    TextMetrics v = ctx.measureText(text);
    
    var x = left + margin + fieldPx/2 - v.width/2;
    var y = top + margin + fieldPx/2;     
    
    ctx.fillText(text, x, y);
  }
  
  void setupBoard(){
    final String green = '#669966';
    ctx.rect(leftOfBoard - margin, topOfBoard - margin, widthAndHeightPx + 2*margin , widthAndHeightPx + 2*margin);
    ctx.lineWidth = 1;
    ctx.strokeStyle = green;
    ctx.stroke();
    
    for (var i = 0; i < widthAndHeight; i++) {
      for (var j = 0; j < widthAndHeight; j++) {
        var x = j * fieldPx + leftOfBoard;
        var y = i * fieldPx + topOfBoard;
        _fillRect(x, y);        
      }
    }
    
  }
  
}