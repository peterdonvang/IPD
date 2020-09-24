class TextBox
{
  PShape boundingBox;
  PShape arrow;
  PShape arrowHead;
  String theText;
  color boxColor;
  color textColor;
  int xpos;
  int ypos;
  int tWidth;
  int tHeight;
  int lStartX, lStartY;
  int lEndX, lEndY;
  int headDiam;
  boolean conLeft;
  boolean conRight;
  boolean conTop;
  boolean conBottom;
  
  TextBox(String _text, int _xpos, int _ypos, int _lEndX, int _lEndY)
  {
    // text
    theText = _text;
    tWidth = width-(2*inset);
    tHeight = height/4;
    textColor = color(255);    
    
    // box
    xpos = _xpos;
    ypos = _ypos;
    boxColor = color(#485F83);
    
    rectMode(CORNER);
    boundingBox = createShape(RECT, ypos, xpos, tWidth, tHeight);
    
    // arrow
    lEndX = _lEndX;
    lEndY = _lEndY;
    lStartX = xpos + tWidth;
    lStartY = ypos;
    headDiam = 10;
    stroke(boxColor);
    arrow = createShape(LINE, lStartX, lStartY, lEndX, lEndY);
    arrowHead = createShape(ELLIPSE, lEndX, lEndY, headDiam, headDiam);
    
    // conditions
  }
  
  void draw()
  {
    fill(boxColor);
    shape(boundingBox);
    shape(arrow);
    shape(arrowHead);
    fill(textColor);
    textSize(20);
    text(theText, 0, button.ypos - button.rad, tWidth, tHeight);
  }
  
  void clicked()
  {
    
  }
}
