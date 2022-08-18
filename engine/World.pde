class PhysicsWorld {

  private ArrayList<PhysicsBody> bodys;
  private ArrayList<Pair>possibleCollisions;
  boolean collideWithWalls, gravity;

  PhysicsWorld() {
    bodys = new ArrayList<PhysicsBody>();
    possibleCollisions = new ArrayList<Pair>();
  }

  void collideWithWalls() {
    collideWithWalls = !collideWithWalls;
  }

  void applyGravity() {
    gravity = !gravity;
  }

  void addObject(PhysicsBody b) {
    bodys.add(b);
  }

  void removeObject() {
    if (bodys.isEmpty())return;
    bodys.remove(bodys.size()-1);
  }

  void removeObject(int i) {
    if (bodys.isEmpty())return;
    bodys.remove(i);
  }

  void removeObject(PhysicsBody b) {
    bodys.remove(b);
  }


  void draw() {
    for (int i=0; i<bodys.size(); i++) {
      PhysicsBody b = bodys.get(i);
      b.draw();

      text(i, b.position.x, b.position.y);
    }
  }


  void update() {
    PhysicsBody possibleActiveCollision=null;
    for (int i=0; i<bodys.size(); i++) {
      PhysicsBody b = bodys.get(i);
      if (collideWithWalls)b.collideWithWalls();
      if (gravity)b.gravity();
      b.update();
      if (possibleActiveCollision != null) {
        // check if they intersect/overlap in x-axis, can be checked with y-axis too
        boolean itersects = abs(possibleActiveCollision.position.x-b.position.x) <= possibleActiveCollision.radius + b.radius;
        if (itersects)possibleCollisions.add(new Pair(possibleActiveCollision, b));
      }
      possibleActiveCollision = b;
    }

    if (possibleActiveCollision != null) {
      // check if they intersect/overlap in x-axis, can be checked with y-axis too
      for (PhysicsBody b : bodys) {
        if (b == possibleActiveCollision)continue;
         if (xIntersects(b,possibleActiveCollision))possibleCollisions.add(new Pair(possibleActiveCollision, b));
      }
    }

    



    resolveCollision();
  }


  void resolveCollision() {
    for (Pair p : possibleCollisions) {
      if (!p.yIntersects()) continue;// no need to check xIntersects() bcz that was already checked in update()
      PhysicsBody b1=p.b1, b2=p.b2;
      PVector b12b2 =  PVector.sub(b2.position, b1.position);
      float d = b12b2.mag();
      b12b2.normalize();
      float penetration = p.sum_radii-d;
      b1.applyLinearImpulse(b12b2.copy().mult(-penetration - p.b1_bouncyness));
      b2.applyLinearImpulse(b12b2.mult(penetration + p.b2_bouncyness));
    }
    possibleCollisions.clear();
  }
}
