class Button
{
    PShape buttonBody;
    int xpos;
    int ypos;
    int diam;
    int rad;
    
    
    boolean conLeft;
    boolean conRight;
    boolean conTop;
    boolean conBottom;
    
    //conditions for buttons and bubbles
    
    
    boolean isOver;
    int mouseOverDiam;
    
    Button(int _xpos, int _ypos, int _diam)
    {
        xpos = _xpos;
        ypos = _ypos;
        diam = _diam;
        rad = diam / 2;
        noStroke();
        buttonBody = createShape(ELLIPSE, xpos, ypos, diam, diam);
    }
    
    void draw()
    {
        shape(buttonBody);
        conLeft = mouseX > this.xpos - this.rad;
        conRight = mouseX < this.xpos + this.rad;
        conTop = mouseY > this.ypos - this.rad;
        conBottom = mouseY < this.ypos + this.rad;
    }
    void drawMouseOver() // only used for nav buttons.
    {
        noStroke();
        buttonBody = createShape(ELLIPSE, xpos, ypos, mouseOverDiam, mouseOverDiam);
        shape(buttonBody);
    
    }
    
    //void doubleclick()
    //{
    //    int firstclick = millis();
    //    int secondclick = millis()- firstclick;
        
    //    if (secondclick < 500)
    //    {
    //        bubbles = false;
    //    }
      
    //}
    
}
