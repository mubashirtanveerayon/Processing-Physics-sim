ArrayList<PhysicsBody> pBodys;
int num = 4;

int mouseRadius = 30;

void setup() {
  size(640, 480);
  pBodys = new ArrayList<PhysicsBody>();
  for (int i=0; i<num; i++) {
    PhysicsBody pb = new PhysicsBody(random(30, 60), new PVector(random(width), random(height)));
    pBodys.add(pb);
    pb.applyLinearImpulse(new PVector(300, random(-200, 200)));
  }
  //PhysicsBody f_elem = pBodys.get(0);
  //f_elem.mass = 100;
  //f_elem.c = color(255,0,0);
}

void draw() {
  background(255);
  fill(0);
  for (int i=0; i<pBodys.size(); i++) {
    PhysicsBody pb = pBodys.get(i);

    for (int j=0; j<pBodys.size(); j++) {
      if(j==i)continue;
      PhysicsBody pb2 = pBodys.get(j);
      pb.collide(pb2);
      //pb2.collideWithWalls();
      //pb2.update();
      //pb2.draw();
      //pb2.collide(pb);
    }

    pb.collideWithWalls();
    pb.update();
    pb.draw();
    
   if(dist(pb.position.x,pb.position.y,mouseX,mouseY)<= mouseRadius + pb.radius){
     PVector r = PVector.sub(pb.position, new PVector(mouseX,mouseY));
    float d = constrain(r.mag(), 10, 50);
    PVector force = r.normalize();
    force.mult(G * 20 * pb.mass/pow(d, 2));
    pb.applyLinearImpulse(force);
   }
    
  }
  
 noFill();
 strokeWeight(3);
 stroke(255,0,0);
 circle(mouseX,mouseY,mouseRadius*2);
 
 
  
}
