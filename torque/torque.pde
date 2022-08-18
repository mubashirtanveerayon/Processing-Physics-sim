PhysicsBody b;


void setup(){
  size(400,400);
  b = new PhysicsBody(190,new PVector(width/2,height/2));
  b.applyLinearImpulse(PVector.random2D().mult(300));
  b.applyTorque(PI/6,new PVector(50,10));
}

void draw(){
   
  background(255);
  b.collideWithWalls();
  b.update();
  b.draw();
 if(mousePressed){
   PVector r = PVector.sub(new PVector(mouseX,mouseY),b.position).normalize();
   if(mouseButton == LEFT)b.applyTorque(-PI/3,new PVector(map(mouseX,0,width,-50,50),0));//r.copy().mult(30)
   else b.applyLinearImpulse(r.copy().mult(30));
 }
  
}
