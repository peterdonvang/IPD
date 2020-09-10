void setup()
{
    size(595 , 842); // size is A0 dimensions
    background(#354450); // color gotten from aau.dk
}


void draw()
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
