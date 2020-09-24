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

// global variables
static int screenwidth = 595;
static int screenheight = 842;
static int inset = 130;
static int buttonDiam = IPD.screenwidth / 3;

Button button;
// study life -------------------------------------------------------
TextBox cantinaBox;
TextBox smallCafeBox;
TextBox libraryBox;
TextBox bridgeBox;
TextBox mirrorBox;
TextBox studyHallBox;

//nav buttons
Button navButtonL1;
Button navButtonL2;
Button navButtonL3;
Button navButtonR1;
Button navButtonR2;
Button navButtonR3;
boolean navButtons;

int navButtonSpacing = 30;

// containers for description arrays
String[] cantinaArray;
String[] bridgeArray;
String[] libraryArray;
String[] mirrorArray;
String[] smallCafeArray;
String[] studyHallArray;
    
// containers for descriptions
String smallCafeText;
String mirrorText;
String libraryText;
String bridgeText;
String cantinaText;
String studyHallText;

// places on map
static int cantinaX = 381, cantinaY = 299;
static int smallCafeX = 271, smallCafeY = 427;
static int libraryX = 335, libraryY = 303;
static int bridgeX = 301, bridgeY = 362;
static int mirrorX = 375, mirrorY = 499;
static int studyHallX = 325, studyHallY = 504;
static int noOfPlaces = 6;

boolean mapCantina;
boolean mapSmallCafe;
boolean mapLibrary;
boolean mapBridge;
boolean mapMirror;
boolean mapStudyHall;


// jobs ---------------------------------------------------------------
String[] jobStrings;
Job[] jobs;


int baseColor = color(255);
int mouseOverColor = color(0xff2F6BC9);

//int texty = inset;
//float textAlpha = 255;

//pages
boolean mainPage;
boolean studyPage;
boolean whatIsPage;
boolean jobsPage;

// container for current page
// String currentPage;

// backgrounds
PImage mainBackground;
PImage studyBackground;
PImage whatIsBackground;
PImage jobsBackground;


boolean bubbles;

Bubble studyBubble;
Bubble whatIsBubble;
Bubble jobsBubble;
ScrollingBox scrollingBox;

public void settings() // lets us use variables for size()
{
    size(screenwidth, screenheight); // size is A0 dimensions
}

public void setup()
{
    // instantiate
    mainBackground = loadImage("PHmainBackground.png");
    button = new Button(screenwidth - inset, screenheight - inset, buttonDiam);
    
    // study Page-------------------------------------------
    studyBackground = loadImage("placeholderMap.png");
    
    // load all descriptions into text arrays
    cantinaArray = loadStrings("theCantina.txt");
    bridgeArray = loadStrings("theBridge.txt");
    libraryArray = loadStrings("theLibrary.txt");
    mirrorArray = loadStrings("theMirror.txt");
    smallCafeArray = loadStrings("theSmallCafe.txt");
    studyHallArray = loadStrings("theStudyHall.txt");
    
    // join all text arrays into single string
    smallCafeText = join(smallCafeArray, "\n");
    mirrorText = join(mirrorArray, "\n");
    libraryText = join(libraryArray, "\n");
    bridgeText = join(bridgeArray, "\n");
    cantinaText = join(cantinaArray, "\n");
    studyHallText = join (studyHallArray, "\n");
    cantinaBox = new TextBox(cantinaText, 10, button.ypos - button.rad, cantinaX, cantinaY); // xpos, ypos, lineEndX, lineEndY
    smallCafeBox = new TextBox(smallCafeText, 10, button.ypos - button.rad, smallCafeX, smallCafeY);
    libraryBox = new TextBox(libraryText, 10, button.ypos - button.rad, libraryX, libraryY);
    bridgeBox = new TextBox(bridgeText, 10, button.ypos - button.rad, bridgeX, bridgeY);
    mirrorBox = new TextBox(mirrorText, 10, button.ypos - button.rad, mirrorX, mirrorY);
    studyHallBox = new TextBox(studyHallText, 10, button.ypos - button.rad, studyHallX, studyHallY);
    
    // make nav buttons and put in array
    navButtonL1 = new Button(width/2 -navButtonSpacing/2, height-30, 20);
    navButtonL2 = new Button(width/2 -3*navButtonSpacing/2, height-30, 20);
    navButtonL3 = new Button(width/2 -5*navButtonSpacing/2, height-30, 20);
    navButtonR1 = new Button(width/2 +navButtonSpacing/2, height-30, 20);
    navButtonR2 = new Button(width/2 +3*navButtonSpacing/2, height-30, 20);
    navButtonR3 = new Button(width/2 +5*navButtonSpacing/2, height-30, 20);
    Button[] navButtons = new Button[noOfPlaces];
    
    navButtons[0] = navButtonL1;
    navButtons[1] = navButtonL2;
    navButtons[2] = navButtonL3;
    navButtons[3] = navButtonR1;
    navButtons[4] = navButtonR2;
    navButtons[5] = navButtonR3;

    // jobs page----------------------------------------------
    jobsBackground = loadImage("PHjobsBackground.png");
    jobStrings = loadStrings("jobs.txt");
    jobs = new Job[jobStrings.length];
    
    for (int i = 0; i<jobStrings.length;i++) //populate jobs array
    {
      jobs[i] = new Job();
      jobs[i].title = jobStrings[i]; // give each job a title
      jobs[i].ypos = i*jobs[i].spacing; // set each jobs position on screen
      jobs[i].alpha = 255; //set each jobs alpha value
    }
    // what is page ------------------------------------------
    whatIsBackground = loadImage("PHwhatIsBackground.png");
  
    studyBubble = new Bubble(inset, button.ypos, button.diam - 15, button.diam - 15);
    whatIsBubble = new Bubble(screenwidth / 3, screenheight / 2, button.diam - 15, button.diam - 15);
    jobsBubble = new Bubble(button.xpos, screenheight/2, button.diam - 15, button.diam - 15);
    scrollingBox = new ScrollingBox();
    
    
    switchPage(mainBackground);
}

public void draw()
{
    if (mainPage)
    {
        background(mainBackground);
        button.draw();
    }
    
    else if (studyPage)
    {
        background(studyBackground);
        //image(studyBackground, mouseX-screenwidth/2, 0); image you can drag with mouse
        //button.draw();
        mapCantina = true;
        println("cantina box");

        if ( key == '2')
        {
            smallCafeBox.draw();
            println("small cafe box");
        }
        else if ( key == '3')
        {
            libraryBox.draw();
            println("library box");
        }
        else if ( key == '4')
        {
            bridgeBox.draw();
            println("bridge box");
        }
        else if ( key == '5')
        {
            mirrorBox.draw();
            println("mirror box");
        }
        else if ( key == '6')
        {
            studyHallBox.draw();
            println("study hall box");
        }  
        
        if (cantinaBox.conLeft && cantinaBox.conRight && cantinaBox.conTop && cantinaBox.conBottom)
        {
            cantinaBox.isOver = true;
        }
        else 
        {
            cantinaBox.isOver = false;
        }
    
            
            

        navButtonL1.isOver = false;
        
        // // check if over navigation buttons
        // if (navButtonL1.conLeft && navButtonL1.conRight && navButtonL1.conTop && navButtonL1.conBottom)
        // {
        //    navButtonL1.isOver = true;
        //    navButtonL1.drawMouseOver();
        //    navButtonL1.draw();
        //    navButtonL2.draw();
        //    navButtonL3.draw();
        //    navButtonR1.draw();
        //    navButtonR2.draw();
        //    navButtonR3.draw();
        // } 
        // else if (navButtonL2.conLeft && navButtonL2.conRight && navButtonL2.conTop && navButtonL2.conBottom)
        // {
        //    navButtonL2.isOver = true;
        //    navButtonL1.draw();
        //    navButtonL2.drawMouseOver();
        //    navButtonL3.draw();
        //    navButtonR1.draw();
        //    navButtonR2.draw();
        //    navButtonR3.draw();
        // } 
        // else if (navButtonL3.conLeft && navButtonL3.conRight && navButtonL3.conTop && navButtonL3.conBottom)
        // {
        //    navButtonL3.isOver = true;
        //    navButtonL1.draw();
        //    navButtonL2.draw();
        //    navButtonL3.drawMouseOver();
        //    navButtonR1.draw();
        //    navButtonR2.draw();
        //    navButtonR3.draw();
        // }
        // else if (navButtonR1.conLeft && navButtonR1.conRight && navButtonR1.conTop && navButtonR1.conBottom)
        // {
        //    navButtonR1.isOver = true;
            
        //    navButtonL1.draw();
        //    navButtonL2.draw();
        //    navButtonL3.draw();
        //    navButtonR1.drawMouseOver();
        //    navButtonR2.draw();
        //    navButtonR3.draw();
    
        // }
        // else if (navButtonR2.conLeft && navButtonR2.conRight && navButtonR2.conTop && navButtonR2.conBottom)
        // {
        //    navButtonR2.isOver = true;
        //    navButtonL1.draw();
        //    navButtonL2.draw();
        //    navButtonL3.draw();
        //    navButtonR1.draw();
        //    navButtonR2.drawMouseOver();
        //    navButtonR3.draw();
        // }
        // else if (navButtonR3.conLeft && navButtonR3.conRight && navButtonR3.conTop && navButtonR3.conBottom)
        // {
        //    navButtonR3.isOver = true;
        //    navButtonL1.draw();
        //    navButtonL2.draw();
        //    navButtonL3.draw();
        //    navButtonR1.draw();
        //    navButtonR2.draw();
        //    navButtonR3.drawMouseOver();
        // }
        // else
        // {
        //    navButtonL1.draw();
        //    navButtonL2.draw();
        //    navButtonL3.draw();
        //    navButtonR1.draw();
        //    navButtonR2.draw();
        //    navButtonR3.draw();
        // }
    
    } // end of study page
        

    else if (whatIsPage)
    {
        mainPage = false;
        studyPage = false;
        jobsPage = false;
        
        
        background(whatIsBackground);
        button.draw();
    }
    else if (jobsPage)
    {
        mainPage = false;
        studyPage = false;
        whatIsPage = false;
        
        background(jobsBackground);
        //scrollingBox.draw(texty, textAlpha);
    
    
    
        for (int i = 0; i < jobs.length ; i++)
        {
            text(jobs[i].title, inset, jobs[i].ypos, width-inset*2, height);
        }
  
        // scroll lines
        for (int i = 0; i < jobs.length; i++)
        {
            fill(255, 255, 255, jobs[i].alpha);
            jobs[i].ypos--;
            if (jobs[i].ypos < inset) // fade lines
            {
               //fadeout(jobs[i]); 
               jobs[i].alpha = jobs[i].ypos;
               //println(jobs[i].title);
            }
        
            if (jobs[i].ypos <=-40) // reset line position
            {
                jobs[i].ypos = height;
                jobs[i].alpha = 255;
            }
        }

        button.draw();
    } // end of jobs page
    
    
    //check if mouse is over button
    if (button.conLeft && button.conRight && button.conTop && button.conBottom)
    {
        button.isOver = true;
    }     
    
    else
    {
        button.isOver = false;
    }

    if (bubbles)
    {
        studyBubble.draw();
        jobsBubble.draw();
        whatIsBubble.draw();
      
        // check if mouse is over study bubble
        if (studyBubble.conLeft && studyBubble.conRight && studyBubble.conTop && studyBubble.conBottom)
        {
            studyBubble.isOver = true;
        }   else
        {
            studyBubble.isOver = false;
        }
        
        // check if mouse is over what is bubble
        if (whatIsBubble.conLeft && whatIsBubble.conRight && whatIsBubble.conTop && whatIsBubble.conBottom)
        {
            whatIsBubble.isOver = true;
        }   else
        {
            whatIsBubble.isOver = false;
        }
      
        // check if mouse is over jobs bubble
        if (jobsBubble.conLeft && jobsBubble.conRight && jobsBubble.conTop && jobsBubble.conBottom)
        {
            jobsBubble.isOver = true;
        }   else
        {
            jobsBubble.isOver = false;
        }
    } else 
    {
        button.draw();
    }
} // end of void draw


// methods
public void printBools()
{
  //println("bubbles:", bubbles);
  //println("study page:", studyPage);
  //println("What is Page:", whatIsPage);
  //println("jobs page", jobsPage);
  //println("___________________");
}

public void mouseClicked() // calls when mouse is pressed.
{
    //toggle bubbles
    if (button.isOver && !bubbles)
    {
        bubbles = true;
        // *****************************animation goes here***********************
        println("bubbles out");
    }   else if (button.isOver && bubbles)
    {
          // *****************************animation goes here*********************** 
        bubbles = false;
    }

    if (cantinaBox.isOver)
    {
        cantinaBox.xpos = mouseX;
    }
  
  
    // switch pages
    if (studyBubble.isOver)
    {
        if (!studyPage)
        {
            switchPage(studyBackground);
        }
        else 
        {

        }
        
        //studyPage = true;
        //whatIsPage = false;
        //jobsPage = false;
        //bubbles = false;
    }
    if (whatIsBubble.isOver)
    {
        if (!whatIsPage)
        {
            switchPage(whatIsBackground);
        }
        else
        {
        }
    }
    
    if (jobsBubble.isOver)
    {
        if (!jobsPage)
        {
            switchPage(jobsBackground);
        }
        else 
        {
            //println("stay on jobs page");
        }
    }
    printBools(); 
}

public void switchPage(PImage _background)
{
    if (_background == mainBackground)
    {
     mainPage = true;
     studyPage = false;
     whatIsPage = false;
     jobsPage = false;
     println("switch to mainPage");
    }
    if (_background == studyBackground)
    {
      mainPage = false;
      studyPage = true;
      whatIsPage = false;
      jobsPage = false;
      println("switch to studyPage");
      bubbles = false;
    }
    else if (_background == whatIsBackground)
    {
      mainPage = false;
      studyPage = false;
      whatIsPage = true;
      jobsPage = false;
      println("switch to what is page");
      bubbles = false;
    }
    else if (_background == jobsBackground)
    {
      mainPage = false;
      studyPage = false;
      whatIsPage = false;
      jobsPage = true;
      println("switch to jobs page");
      bubbles = false;
    }
}
class Job
{
  String title;
  int ypos;
  int alpha;
  int spacing = 50;
  
  Job()
  {
  }
}
class ScrollingBox
{  
  String[] jobs;
  String lines;
  int posy;
  float alpha;
  
  ScrollingBox()
  {
    jobs = loadStrings("jobs.txt");
    lines = join(jobs, "\n");

    textAlign(CENTER);
     
  }
  
  public void draw(int _posy, float _alpha)
  {
    textSize(40);    
    fill(0xff2F6BC9, _alpha);
    text(lines, 0, _posy, width, height);
  }
}
  
class TextBox
{
  PShape boundingBox;
  PShape arrow;
  PShape arrowHead;
  String theText;
  int boxColor;
  int textColor;
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
  boolean isOver;

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
    boxColor = color(0xff485F83);
    fill(boxColor);
    rectMode(CORNER);
    boundingBox = createShape(RECT, xpos, ypos, tWidth, tHeight);
    
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
    conLeft = mouseX > this.xpos;
    conRight = mouseX < this.xpos + tWidth;
    conTop = mouseY > this.ypos;
    conBottom = mouseY < this.ypos + tHeight;

  }
  
  public void draw()
  {
    shape(boundingBox);
    shape(arrow);
    shape(arrowHead);
    textSize(20);
    fill(textColor);
    text(theText, 0, button.ypos - button.rad, tWidth, tHeight);
  }
  
  public void clicked()
  {
    
  }
}
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

  public void draw()
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
  
class Button
{
    PShape buttonBody;
    int xpos;
    int ypos;
    int diam;
    int rad;
    int buttonColor = color(0xff485F83);
    
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
        fill(buttonColor);
        buttonBody = createShape(ELLIPSE, xpos, ypos, diam, diam);
    }
    
    public void draw()
    {
        shape(buttonBody);
        conLeft = mouseX > this.xpos - this.rad;
        conRight = mouseX < this.xpos + this.rad;
        conTop = mouseY > this.ypos - this.rad;
        conBottom = mouseY < this.ypos + this.rad;
    }
    public void drawMouseOver() // only used for nav buttons.
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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "IPD" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
