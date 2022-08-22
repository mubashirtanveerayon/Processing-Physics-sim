World w;
int numObjects = 23;
void setup(){
  size(500,500);
  
  w = new World(new PVector(width,height));
  w.addBehaviour(new Friction());
  w.addBehaviour(new Bounce(new AABB(new PVector(0,0),new PVector(width,height))));
  for(int i=0;i<numObjects;i++){
    PhysicsBody b = new PhysicsBody(random(50),new PVector(random(width),random(height)));
    w.addObject(b);
    b.applyLinearImpulse(new PVector(random(-1000,1000),random(-500,500)));
  }
}


void draw(){
 background(255);
 w.update();
 //println("gg");
}
