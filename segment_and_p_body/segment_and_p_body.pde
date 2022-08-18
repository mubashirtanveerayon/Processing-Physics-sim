PhysicsBody b;
ArrayList<Segment> walls;

void setup(){
  size(300,300);
  walls = new ArrayList<Segment>();
  b = new PhysicsBody(90,new PVector(width/2-100,height/2-100));
  b.applyLinearImpulse(new PVector(500,50));
  walls.add(new Segment(new PVector(0,0),new PVector(0,height)));
  walls.add(new Segment(new PVector(0,height),new PVector(width,height)));
  walls.add(new Segment(new PVector(width,0),new PVector(width,height)));
  walls.add(new Segment(new PVector(),new PVector(width,0)));
  //walls.add(new Segment(new PVector(100,50),new PVector(200,250)));
}

void draw(){
  
  background(255);
  for(Segment s:walls){
    b.collideWithSegment(s);
    s.draw();
  }
  //b.gravity();
  b.update();
  b.draw();
}
