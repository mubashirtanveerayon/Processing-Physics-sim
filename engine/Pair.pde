class Pair {

  PhysicsBody b1, b2;
  float sum_radii, b1_bouncyness, b2_bouncyness;
  Pair(PhysicsBody b1, PhysicsBody b2) {
    this.b1 = b1;
    this.b2 = b2;
    sum_radii = b1.radius+b2.radius;
    b1_bouncyness=200;
    b2_bouncyness=200;
  }

  boolean xIntersects() {
    return abs(b1.position.x-b2.position.x) <= sum_radii;
  }

  boolean yIntersects() {
    return abs(b1.position.y-b2.position.y) <= sum_radii;
  }

  boolean collides() {
    return dist(b1.position.x, b1.position.y, b2.position.x, b2.position.y)<=sum_radii;
  }
}

boolean xIntersects(PhysicsBody b1, PhysicsBody b2) {
  return abs(b1.position.x-b2.position.x) <= b1.radius+b2.radius;
}

boolean yIntersects(PhysicsBody b1, PhysicsBody b2) {
  return abs(b1.position.y-b2.position.y) <= b1.radius+b2.radius;
}
