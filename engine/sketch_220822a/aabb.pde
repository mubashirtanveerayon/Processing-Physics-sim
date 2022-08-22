class AABB{
  
  PVector topLeft,dimension,topRight,bottomLeft,bottomRight;
  
  AABB(PVector tl,PVector dim){
      topLeft = tl.copy();
      dimension = dim.copy();
      topRight = new PVector(topLeft.x + dimension.x,topLeft.y);
      bottomLeft = new PVector(topLeft.x,topLeft.y+dimension.y);
      bottomRight = new PVector(topRight.x,topRight.y+dimension.y);
  }
      
}
