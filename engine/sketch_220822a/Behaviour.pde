abstract class Behaviour {

  abstract void apply(PhysicsBody b);
}

class Gravity extends Behaviour {
  PVector force = new PVector(0, g);
  void apply(PhysicsBody b) {
    b.applyLinearImpulse(force);
  }
}

class Friction extends Behaviour {

  float staticThreshold = 0; // velocityMag when the body will be considered motionless
  float coEff = 0.008;
  void apply(PhysicsBody b) {
    float velocityMag = b.velocity.mag();
    if(velocityMag <= staticThreshold)return;
    float strength = b.mass * coEff * velocityMag;
    PVector force = b.velocity.copy().mult(-1).setMag(strength);
    b.applyLinearImpulse(force);
  }
}

class Bounce extends Behaviour {
  AABB boundingBox;
  Bounce(AABB box) {
    boundingBox = box;
  }

  void apply(PhysicsBody b) {
    if (b.position.x + b.radius >= boundingBox.topRight.x) {
      b.velocity.x = -1*abs(b.velocity.x);
      b.position.x = boundingBox.topRight.x - b.radius;
    } else if ( b.position.x - b.radius <= boundingBox.topLeft.x) {
      b.velocity.x = abs(b.velocity.x);
      b.position.x = boundingBox.topLeft.x + b.radius;
    }
    if (b.position.y - b.radius  <= boundingBox.topLeft.y ) {
      b.velocity.y = abs(b.velocity.y);
      b.position.y = boundingBox.topLeft.y + b.radius ;
    } else if (b.position.y + b.radius >= boundingBox.bottomLeft.y) {
      b.velocity.y = -1*abs(b.velocity.y);
      b.position.y =  boundingBox.bottomLeft.y - b.radius;
    }
  }
}
