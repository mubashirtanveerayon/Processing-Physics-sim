class Segment {

  float slope, mx1,reactionStrength;
  color c;
  final PVector p1, p2;
  
  final PVector p12p2, p22p1;

  Segment(PVector p1, PVector p2) {
    this.p1=p1.copy();
    this.p2=p2.copy();
    p12p2 = PVector.sub(p2, p1);
    p22p1 = PVector.sub(p1, p2);
    slope = (p1.y-p2.y)/(p1.x-p2.x);
    mx1 = slope * p1.x;
    reactionStrength = 200;
    c = color(random(255), random(255), random(255));
  }

  float f(float x, float y) {
    return slope*x - y - mx1 + p1.y;
  }

  float dist(PVector point) {

    return abs(f(point.x, point.y))/sqrt(pow(slope, 2)+1);
  }

  // thanks to Honkadaloonga#8808(the coding train discord server)
  PVector getVectorFromClosestPoint(PVector point) {
    return PVector.sub(point, getClosestPoint(point));
  }

  PVector getClosestPoint(PVector point) {
    float l2 = PVector.sub(p1, p2).magSq();
    float t = constrain(PVector.dot(PVector.sub(point, p1), PVector.sub(p2, p1))/l2, 0, 1);
    return PVector.lerp(p1, p2, t);
  }

  /*
 PVector shortestVector(PVector point) {
   PVector p12point = PVector.sub(p1, point);
   PVector p22point = PVector.sub(p2, point);
   if (p12point.dot(p12p2.copy().normalize())<0) {
   return p12point;
   } else if (p22point.dot(p22p1.copy().normalize())<0) {
   return p22point;
   }
   
   PVector p12p2Normalized = p12p2.copy().normalize();
   PVector projectionOfp12pointOnp12p2 = p12p2Normalized.mult(p12p2Normalized.dot(p12point));
   return p12point.sub(projectionOfp12pointOnp12p2);
 }
   
   */


  void draw() {
    stroke(c);
    line(p1.x, p1.y, p2.x, p2.y);
  }
}
