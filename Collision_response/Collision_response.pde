PhysicsBody b1,b2;
Collider2D c2d;
void setup(){
  size(300,300);
    b1 = new PhysicsBody(100,new PVector(width/2-100,height/2));
    b2 = new PhysicsBody(50,new PVector(270,height/2+20));
    c2d = new Collider2D(b1,b2);
    //b1.applyLinearImpulse(new PVector(450,0));
    b2.applyLinearImpulse(new PVector(-250,00));
}

void draw(){
  background(255);
  b1.collideWithWalls();
  b2.collideWithWalls();
  //b1.gravity();
  //b2.gravity();
  b1.update();
  b2.update();
  c2d.update();
  
  //println(b1.velocity.mag()+"     "+b2.velocity.mag());
  
 if(mousePressed){
    b1.gravity();
  b2.gravity();
 }
  
  b1.draw();
  b2.draw();
  
  
  
}
