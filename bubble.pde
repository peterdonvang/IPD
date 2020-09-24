class Bubble
{
  PShape bubbleBody;
  // variables
  int xposInit;
  int yposInit;
  int xposFin;
  int yposFin;
  int diam;
  int rad;
  
  boolean conLeft;
  boolean conRight;
  boolean conTop;
  boolean conBottom;
  
  int animTime = 2000; // 2000 ms = 2 sekunder
  int startTime;
  int ellapsedTime;



  boolean isOver;
  
  Bubble(int _xposFin, int _yposFin, int _diam, int _rad)
  {

    //xposInit = button.xpos;
    //yposInit = button.ypos;
    
    xposFin = _xposFin;
    yposFin = _yposFin;
    diam = _diam;
    rad = _rad;
    
    noStroke();
    bubbleBody = createShape(ELLIPSE, xposFin, yposFin, diam, diam); // instantiate in starting position ("under" knappen)
    
    

  }

  void draw()
  {
    shape(bubbleBody);
    startTime = millis();
    ellapsedTime = millis() - startTime;
    
    conLeft = mouseX > this.xposFin - this.rad;
    conRight = mouseX < this.xposFin + this.rad;    
    conTop = mouseY > this.yposFin - this.rad;
    conBottom = mouseY < this.yposFin + this.rad;
    //while (ellapsedTime < animTime)
    //{
    //    this.xposInit --;
    //    this.yposInit --;
    //}
    
  }

}
  
