float g=5, G=5, density=4, maxVel=18;

class PhysicsBody {

  PVector position, velocity, acceleration,angularAcceleration,angularVelocity;
  float radius, mass, angle,inertia;

  color c;

  PhysicsBody(float m, PVector pos) {
    radius = m/density; // not an actual formula, just to simplify the calculation
    mass = m;
    position = pos.copy();
    velocity = new PVector();
    acceleration = new PVector();
    angularVelocity = new PVector();
    angularAcceleration = new PVector();
    inertia = 0.5 * mass * pow(radius, 2);
    c = color(random(255), random(255), random(255));
  }

  void draw() {
   push();
   translate(position.x,position.y);
   rotate(angle);
    fill(c);
    circle(0, 0, radius * 2);
    line(-radius, 0, radius, 0);
    pop();
    //line(0, -radius, 0, radius);
  }

  void attract(PhysicsBody pBody) {
    PVector r = PVector.sub(position, pBody.position);
    float d = constrain(r.mag(), 10, 60);
    PVector force = r.normalize();
    force.mult(G * mass * pBody.mass/pow(d, 2));
    pBody.applyLinearImpulse(force);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    angle += angularVelocity.z;
    angularVelocity.add(angularAcceleration);
    angularAcceleration.mult(0);
    acceleration.mult(0);
    velocity.setMag(min(velocity.mag(), maxVel));
  }

  void applyLinearImpulse(PVector force) {
    acceleration.add(force.div(mass));
  }

  void applyTorque(float angle, PVector force) {
    push();
    translate(position.x,position.y);
    PVector r = PVector.fromAngle(angle).mult(radius);
    PVector torque = r.cross(force); // eikhane kisu limitation ase, karon 2D te sphere bole to kisu nai, eita ekta 
    // disk, ejonno torque ta apply hobe shobshomoy disk er outer most edge e, angle ta oitai define kore
    angularAcceleration.add(torque.div(inertia));
    pop();
 }

  void gravity() {
    applyLinearImpulse(new PVector(0, g));
  }

  void collideWithWalls() {
    if (position.x + radius >= width) {
      velocity.x = -1*abs(velocity.x);
      position.x = width - radius;
    } else if ( position.x - radius <= 0) {
      velocity.x = abs(velocity.x);
      position.x = radius;
    }
    if (position.y - radius  <= 0 ) {
      velocity.y = abs(velocity.y);
      position.y = radius ;
    } else if (position.y + radius >= height) {
      velocity.y = -1*abs(velocity.y);
      position.y = height - radius;
    }
  }
}
