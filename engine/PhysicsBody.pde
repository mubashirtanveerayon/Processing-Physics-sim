float g=5.5, G=5, density=4,constrainMin=10,constrainMax=60,maxVel=18;

class PhysicsBody {

  PVector position, velocity, acceleration;
  float radius, mass;

  color c;
  
  int id;

  PhysicsBody(float m, PVector pos,int i) {
    id = i;
    radius = m/density; // not an actual formula, just to simplify the calculation & relating the two values
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
    stroke(0);
    fill(0);
    text(id,position.x,position.y);
  }

  void attract(PhysicsBody pBody) {
    PVector r = PVector.sub(position, pBody.position);
    float d = constrain(r.mag(),constrainMin,constrainMax);
    PVector force = r.normalize();
    force.mult(G * mass * pBody.mass/pow(d, 2));
    pBody.applyLinearImpulse(force);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
    velocity.setMag(min(velocity.mag(),maxVel));
}

  void applyLinearImpulse(PVector force) {
    acceleration.add(force.div(mass));
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
