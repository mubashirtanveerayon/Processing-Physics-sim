class Collider2D {

  PhysicsBody b1, b2;

  Collider2D(PhysicsBody b1,PhysicsBody b2) {
    this.b1 = b1;
    this.b2 = b2;
  }


  void resolve() {
    PVector b12b2 =  PVector.sub(b2.position, b1.position);
    float d = b12b2.mag();
    if (d>b1.radius+b2.radius) return;   
    b12b2.normalize().mult(b1.radius + b2.radius-d);
    
  }
}

enum ColliderType {
  CIRCLE
}
