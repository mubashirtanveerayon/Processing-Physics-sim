float g=1, G=5, density=3.5;

class PhysicsBody {

  PVector position, velocity, acceleration;
  float radius, mass;

  color c;

  PhysicsBody collidingWith;

  PhysicsBody(float m, PVector pos) {
    radius = m/density; // not an actual formula, just to simplify the calculation
    mass = m;
    position = pos.copy();
    velocity = new PVector();
    acceleration = new PVector();
    c = color(random(255), random(255), random(255));
  }

  void draw() {
    fill(c);
    noStroke();
    circle(position.x, position.y, radius * 2);
  }

  void attract(PhysicsBody pBody) {
    PVector r = PVector.sub(position, pBody.position);
    float d = constrain(r.mag(), 10, 50);
    PVector force = r.normalize();
    force.mult(G * mass * pBody.mass/pow(d, 2));
    pBody.applyLinearImpulse(force);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);

    if (collidingWith != null) {
      if (dist(position.x, position.y, collidingWith.position.x, collidingWith.position.y) > collidingWith.radius+radius) {
        collidingWith = null;
      }
    }
  }

  void applyLinearImpulse(PVector force) {
    acceleration.add(force.div(mass));
  }

  // this will not cause the object to rotate on its own axis
  void applyLinearImpulse(PVector point, PVector force) {

    pushMatrix();
    translate(position.x, position.y);
    if (dist(position.x, position.y, point.x, point.y)>radius ) {
      return;
    }
    PVector f = PVector.fromAngle(atan(position.y-point.y/position.x-point.x));
    f.setMag(force.mag());
    popMatrix();
    print(f.mag());
    applyLinearImpulse(f);
  }

  void gravity() {

    applyLinearImpulse(new PVector(0, g));
  }

  void collideWithWalls() {
    if (position.x + radius >= width) {
      velocity.x *= -1;
      position.x = width - radius;
    } else if ( position.x - radius <= 0) {
      velocity.x *= -1;
      position.x = radius;
    }
    if (position.y - radius  <= 0 ) {
      velocity.y *= -1;
      position.y = radius ;
    } else if (position.y + radius >= height) {
      velocity.y *= -1;
      position.y = height - radius;
    }
  }

  void collide(PhysicsBody pb) {
    if (pb == collidingWith) return;
    else if (dist(position.x, position.y, pb.position.x, pb.position.y) > pb.radius+radius) {
      return;
    }

    PVector u = velocity.copy();
    PVector upb = pb.velocity.copy();
    velocity = (u.mult(mass-pb.mass).add(upb.mult(2 * pb.mass))).div((mass+pb.mass));
    pb.velocity = (upb.mult(-mass+pb.mass).add(u.mult(2 * mass))).div((mass+pb.mass));
    pb.collidingWith = this;
    collidingWith = pb;
    //pb.velocity = (upb.mult(-mass+pb.mass).add(u.mult(2 * mass))).div((mass+pb.mass));
  }
}
