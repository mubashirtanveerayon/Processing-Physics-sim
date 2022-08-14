class Planet extends PhysicsBody {

  ArrayList<PhysicsBody> moons;
  ArrayList<PVector> trails;

  Planet(float m, PVector pos, int num_moons) {
    super(m, pos);
    moons = new ArrayList<PhysicsBody>();
    trails = new ArrayList<PVector>();
    for (int i=0; i<num_moons; i++) {
      PhysicsBody pb = new PhysicsBody(random(5, mass), generatePositionForMoon());
      pb.applyLinearImpulse(new PVector(random(-25, 25), random(-25, 25)));
      moons.add(pb);
      trails.add(pb.position);
    }
  }


  PVector generatePositionForMoon() {
    pushMatrix();
    PVector pos=new PVector();
    translate(position.x, position.y);
    while (!isValidPos(pos.x) || !isValidPos(pos.y)) {
      if (  !isValidPos(pos.x)) {
        pos.x = random(position.x-radius-250, position.x+radius+250);
      }
      if (!isValidPos(pos.y)) {
        pos.y =  random(position.y-radius-250, position.y+radius+250);
      }
    }
    popMatrix();
    return pos;
  }

  boolean isValidPos(float pos) {
    return pos<-radius || pos>radius;
  }

  @Override
    void update() {
    super.update();

    for (PhysicsBody pb : moons) {
      pb.update();
      attract(pb);
    }
  }

  void drawMoons() {
    for (PhysicsBody pb : moons) {
      pb.draw();
    }
  }

  void drawMoonTrails() {
    for (int i=0; i<moons.size(); i++) {
      PhysicsBody pb = moons.get(i);
      strokeWeight(2);
      stroke(pb.c);
      point(trails.get(i).x, trails.get(i).y);
      
      //not related to the class
      //if (dist(pb.position.x, pb.position.y, mouseX, mouseY)<= mouseRadius + pb.radius) {
      //  PVector r = PVector.sub(pb.position, new PVector(mouseX, mouseY));
      //  float d = constrain(r.mag(), 10, 50);
      //  PVector force = r.normalize();
      //  force.mult(G * 30 * pb.mass/pow(d, 2));
      //  pb.applyLinearImpulse(force);
      //}
    }
  }
}
