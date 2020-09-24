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
  
  void draw(int _posy, float _alpha)
  {
    textSize(40);    
    fill(#2F6BC9, _alpha);
    text(lines, 0, _posy, width, height);
  }
}
  
