import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class IPD extends PApplet {

public void setup()
{
     // size is A0 dimensions
    background(0xff354450); // color gotten from aau.dk
}


public void draw()
{
    // splitting the window into a grid of some size
    int gridX = width / 10;
    int gridY = height / 15; 
   
    // mainButton
    int ellipseX = gridX * 8;
    int ellipseY = gridY * 12;
    int ellipseDiam = width / 3;
    int ellipseRad = ellipseDiam / 2;
    

    // guidelines
    line(ellipseX, 0, ellipseX, height);
    line(0, ellipseY, width, ellipseY);
    
    ellipse(ellipseX, ellipseY, ellipseDiam, ellipseDiam);
    
    if (mouseX > ellipseX - ellipseRad && mouseX < ellipseX + ellipseRad)
    {
        if (mouseY > ellipseY - ellipseRad && mouseY < ellipseY + ellipseRad)
        {
            background(0);
        }
        else
        {

        }
    }
}
  public void settings() {  size(595 , 842); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "IPD" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
