PhysicsWorld pw;
int num_obj = 5;

void setup() {
  size(400, 400);
  pw = new PhysicsWorld();
  pw.collideWithWalls();
  for (int i=0; i<num_obj; i++) {
    PhysicsBody b = new PhysicsBody(random(50, 100), new PVector(random(50, width-50), random(50, height-50)),i);
    b.applyLinearImpulse(PVector.random2D().mult(200));
    pw.addObject(b);
  }
  strokeWeight(3);
  textSize(30);
}


void draw() {
  background(255);
  pw.update();
  pw.draw();
}
