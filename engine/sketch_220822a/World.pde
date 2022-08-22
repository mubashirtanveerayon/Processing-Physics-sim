import java.util.TreeMap;
import java.util.Map;
class World {

  ArrayList<PhysicsBody> objects = new ArrayList<PhysicsBody>();
  ArrayList<Behaviour> behaviours = new ArrayList<Behaviour>();
  PVector dimension;

  World(PVector dim) {
    dimension = dim.copy();
  }

  void addObject(PhysicsBody b) {
    objects.add(b);
  }

  void addBehaviour(Behaviour b) {
    behaviours.add(b);
  }

  void createObject(float m, PVector pos) {
    addObject(new PhysicsBody(m, pos));
  }


  //really heavy computation, 
  void update() {
    for(PhysicsBody body:objects){
      for(PhysicsBody other:objects){
        if(body == other) continue;
        if(collides(body,other)){
          resolveCollision(body,other);  
        }
      }
      for(Behaviour b:behaviours){
        b.apply(body);  
      }
      body.update();
      body.draw();
    }
  }

  ArrayList<PhysicsBody> sort() {
    TreeMap<Float, PhysicsBody> sorted = new TreeMap<>();
    for (PhysicsBody b : objects) {
      sorted.put(b.position.x, b);
    }
    ArrayList<PhysicsBody> sortedList = new ArrayList<PhysicsBody>();
    for (Map.Entry<Float, PhysicsBody> entry : sorted.entrySet()) {
      sortedList.add(entry.getValue());
    }
    return sortedList;
  }
}
