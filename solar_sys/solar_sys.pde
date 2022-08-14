Planet sun;
ArrayList<Planet> planets;
int mouseRadius = 30, numPlanets=5;

void setup() {
  size(1000, 600);
  sun = new Planet(150, new PVector(width/2, height/2), 0);
  planets = new ArrayList<Planet>();
  for (int i=0; i<numPlanets; i++) {
    Planet p = new Planet(random(sun.mass), sun.generatePositionForMoon(), (int)random(2));
    p.applyLinearImpulse(new PVector(25,00));
    planets.add(p);
  }
}

void draw() {
  background(255);
  sun.update();
  sun.draw();
  for (Planet p : planets) {
    sun.attract(p);
    p.update();
    p.draw();
  }
  noFill();
  stroke(255, 0, 0);
  circle(mouseX, mouseY, mouseRadius*2);
}
