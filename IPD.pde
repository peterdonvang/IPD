// global variables
static int screenwidth = 595;
static int screenheight = 842;
static int inset = 130;
static int buttonDiam = IPD.screenwidth / 3;
static int screenMiddle = screenwidth / 2;

// for swipe function
int clickDown;
int clickUp;

Button button;
// study life -------------------------------------------------------
TextBox cantinaBox;
TextBox smallCafeBox;
TextBox libraryBox;
TextBox bridgeBox;
TextBox mirrorBox;
TextBox studyHallBox;
TextBox[] textBoxes;

//nav buttons
Button navButtonL1;
Button navButtonL2;
Button navButtonL3;
Button navButtonR1;
Button navButtonR2;
Button navButtonR3;

boolean navButtons;

//Button[] navButtons;


//int navButtonSpacing = 30;

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


color baseColor = color(255);
color mouseOverColor = color(#2F6BC9);

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

void settings() // lets us use variables for size()
{
    size(screenwidth, screenheight); // size is A0 dimensions
}

void setup()
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
    
    // put text boxes into array 
    textBoxes = new TextBox[noOfPlaces];
    textBoxes[0] = cantinaBox;
    textBoxes[1] = smallCafeBox;
    textBoxes[2] = libraryBox;
    textBoxes[3] = bridgeBox;
    textBoxes[4] = mirrorBox;
    textBoxes[5] = studyHallBox;
    
    //// set each text box x position
    //for (int i= 0; i < textBoxes.length; i++)
    //{
    //  textBoxes[i].xpos += i*2;
    //  textBoxes[i].initPos = textBoxes[i].xpos;
    //  println(textBoxes[i].xpos);
    //}
    
    // make nav buttons and put in array
    //navButtonL1 = new Button(width/2 -navButtonSpacing/2, height-30, 20);
    //navButtonL2 = new Button(width/2 -3*navButtonSpacing/2, height-30, 20);
    //navButtonL3 = new Button(width/2 -5*navButtonSpacing/2, height-30, 20);
    //navButtonR1 = new Button(width/2 +navButtonSpacing/2, height-30, 20);
    //navButtonR2 = new Button(width/2 +3*navButtonSpacing/2, height-30, 20);
    //navButtonR3 = new Button(width/2 +5*navButtonSpacing/2, height-30, 20);
    //navButtons = new Button[noOfPlaces];
    
    //navButtons[0] = navButtonL1;
    //navButtons[1] = navButtonL2;
    //navButtons[2] = navButtonL3;
    //navButtons[3] = navButtonR1;
    //navButtons[4] = navButtonR2;
    //navButtons[5] = navButtonR3;

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
    // rulletexter
    scrollingBox = new ScrollingBox();
    
    
    switchPage(mainBackground);
}

void draw()
{
    if (mainPage)
    {
        background(mainBackground);
        button.draw();
    }
    
    else if (studyPage)
    {
        background(studyBackground);
        
        for (int i = 0; i < textBoxes.length; i++)
        {
          if (textBoxes[i].isActive)
          {
            textBoxes[i].draw();
          }
        }


        
        //navButtonL1.isOver = false;
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
        println("is over buton");
    }   
    
    else
    {
        button.isOver = false;
    }
    if (studyPage)
    {
      
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
void printBools()
{
  //println("bubbles:", bubbles);
  //println("study page:", studyPage);
  //println("What is Page:", whatIsPage);
  //println("jobs page", jobsPage);
  //println("___________________");
}

void mousePressed() // mouse down
{
  if (studyPage)
  {
    clickDown = mouseX;
    //isLeft = mouseX < screenwidth / 2;
    //isRight = mouseX > screenwidth / 2;
    println("clickdown: ", clickDown);
    //for (int i = 0; i< textBoxes.length ; i++)
    //{
    //  //if (textBoxes[i].leftSide)
    //  //{
        
    //  //}
    //}
  }
 

}

void mouseDragged() // while mouse is down and dragging
{    
     //// textbox follows mouse position
     for (int i = 0; i < textBoxes.length; i++)
     {
         textBoxes[i].xpos += mouseX+textBoxes[i].initPos;
     }
}

void mouseReleased()
{
  if (studyPage)
  {  
    for (int i = 0; i< textBoxes.length; i++)
    {
      //if (textBoxes[i].xpos > screenMiddle)
      //{
      //  textBoxes[i+1].isActive = true;
      //}
    }
    //clickUp = mouseX;
    //if (clickDown
    //int mouseTraveled = clickUp-clickDown;
  //  for (int i = 0; i< textBoxes.length ; i++)
  //  {
  //    textBoxes[i].xpos += mouseTraveled;
  //    println(textBoxes[i].xpos);
  //  }
  //}
  }  
}

void switchPlace(TextBox _textBox)
{
  for (int i = 0; i < textBoxes.length ; i++)
  {
    textBoxes[i].isActive = false; // set all booleans to false;
    if (textBoxes[i] == _textBox) // find the one we want;
    {
      textBoxes[i].isActive = true; // set that to true;
      // textBoxes[i].draw();
    }
  }
}

void mouseClicked() // calls when mouse goes up AND down
{
  if (studyPage)
  {
     
  }
    //toggle bubbles
    if (button.isOver && !bubbles)
    {
        bubbles = true;
        // *****************************animation goes here***********************
        println("bubbles out");
    }   
    else if (button.isOver && bubbles)
    {
          // *****************************animation goes here*********************** 
        bubbles = false;
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

//void switchplace(

void switchPage(PImage _background)
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
