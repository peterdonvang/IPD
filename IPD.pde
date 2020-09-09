string[] jobtitles = ["Software developer", "UX designer", "Game developer", "Web developer"];

void setup()
{

}

void draw()
{
    for (int i = 0; i < jobtitles.length; i++)
    {
        text(width/2, height/2, jobtitles[i]);
    }

}
