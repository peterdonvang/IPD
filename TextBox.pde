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
  int finalXpos = 10;
  int initPos;
  
  boolean isActive;

  
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
    
    
    // arrow
    lEndX = _lEndX;
    lEndY = _lEndY;
    lStartX = xpos + tWidth;
    lStartY = ypos;
    headDiam = 10;
    stroke(boxColor);
  }
  
  void draw()
  {
    fill(boxColor);
    
    rectMode(CORNER);
    boundingBox = createShape(RECT, xpos, ypos, tWidth, tHeight);
    shape(boundingBox);
    
    textSize(20);
    fill(textColor);
    text(theText, xpos, button.ypos - button.rad, tWidth, tHeight);
    if (isActive)
    {
      drawArrow();
    }
    
  }
  void drawArrow()
  {
    arrow = createShape(LINE, lStartX, lStartY, lEndX, lEndY);
    shape(arrow);

    arrowHead = createShape(ELLIPSE, lEndX, lEndY, headDiam, headDiam);
    shape(arrowHead);
  }
  
}
