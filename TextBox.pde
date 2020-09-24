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
    fill(boxColor);
    boundingBox = createShape(RECT, xpos, ypos, tWidth, tHeight);
    rectMode(CORNER);
    
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
    // conLeft = mouseX >
  }
  
  void draw()
  {
    shape(boundingBox);
    shape(arrow);
    shape(arrowHead);
    textSize(20);
    fill(textColor);
    text(theText, 0, button.ypos - button.rad, tWidth, tHeight);
  }
  
  void clicked()
  {
    
  }
}
