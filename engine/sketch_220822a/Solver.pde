class Solver{
   
  PhysicsBody b1,b2;
 float b1_bouncyness,b2_bouncyness; 
  
  Solver(PhysicsBody b1,PhysicsBody b2){
    this.b1 = b1;
    this.b2 = b2;
    b1_bouncyness=200;
    b2_bouncyness=200;
  }
  
  void resolve(){
    if(dist(b1.position.x,b1.position.y,b2.position.x,b2.position.y)>b1.radius+b2.radius)return;
    PVector b12b2 =  PVector.sub(b2.position, b1.position);
    float d = b12b2.mag();
    float sum_radii = b1.radius+b2.radius;
    b12b2.normalize();
    float penetration = sum_radii-d;
    b1.applyLinearImpulse(b12b2.copy().mult(-penetration - b1_bouncyness));
    b2.applyLinearImpulse(b12b2.mult(penetration + b2_bouncyness));
  }
    
}

//b1 and b2 must be passed in an order such that b1 comes sooner than b2 in the x-axis
boolean xIntersects(PhysicsBody b1,PhysicsBody b2){
 return b1.position.x + b1.radius >= b2.position.x - b2.radius;
}

boolean collides(PhysicsBody b1,PhysicsBody b2){
  return dist(b1.position.x,b1.position.y,b2.position.x,b2.position.y)<=b1.radius+b2.radius;  
}


void resolveCollision(PhysicsBody b1,PhysicsBody b2){
    PVector b12b2 =  PVector.sub(b2.position, b1.position);
    float d = b12b2.mag();
    float sum_radii = b1.radius+b2.radius;
    b12b2.normalize();
    float penetration = sum_radii-d;
    b1.applyLinearImpulse(b12b2.copy().mult(-penetration - b1.bouncyness));
    b2.applyLinearImpulse(b12b2.mult(penetration + b2.bouncyness));  
}
