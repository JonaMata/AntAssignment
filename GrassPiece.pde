/* A class for one piece of a grass consisting of a rotational mass spring damper system.
 * Based on Algorithms Assignment 6.3 By Jesse Visser & Jonathan Matarazzi
*/

class GrassPiece {
  float stickLength;
  float speed;

  float dampConst = 0.05;
  float springConst = 200;
  float mass = 10;

  float rotation = 0.1;
  float velocity = 0;
  float acceleration = 0;
  
  float force = 0;
  
  float lowerWidth;
  float higherWidth;
  
  float forceToAdd = 0;
  
  
  GrassPiece(float stickLength, float maxRot, float speed, float lowerWidth, float higherWidth) {
    this.stickLength = stickLength;
    rotation = random(0,maxRot);
    this.speed = speed;
    speed = 1;
    this.lowerWidth = lowerWidth;
    this.higherWidth = higherWidth;
  }
  
  //Calculate the new rotation using the current state and the force and velocity of its neigbours
  void update(float velNeighbour, float forceNeighbour) {
   
    float torque = 1/springConst*rotation;
    float friction = dampConst*velocity;
    
    force = torque+friction;
    
    float realForce = forceNeighbour-force+forceToAdd;
    forceToAdd = 0;
    acceleration = realForce/mass;
    velocity+=speed*acceleration;
    rotation+=velocity-velNeighbour;
    
    
  }
  
  //Display the grass piece
  void display() {
    colorMode(RGB);
    fill(0,255,0);
    strokeWeight(0);
    stroke(0,255,0);
    beginShape();
    vertex(-lowerWidth/2,0);
    vertex(lowerWidth/2,0);
    PVector higherPoint = new PVector(0,stickLength).rotate(rotation);
    PVector highLeft = higherPoint.copy().add(new PVector(0,-higherWidth/2,0).rotate(rotation-HALF_PI));
    PVector highRight = higherPoint.copy().add(new PVector(0,higherWidth/2).rotate(rotation-HALF_PI));
    vertex(highRight.x,highRight.y);
    vertex(highLeft.x,highLeft.y);
    endShape(CLOSE);
    
    rotate(rotation);
    translate(0,stickLength);
  }
  
  //Get the current force
  float getForce() {
    return force;
  }
  
  //Get the current velocity
  float getVel() {
    return velocity;
  }
  
  //Apply force to this piece
  void addForce(float _force) {
    forceToAdd = _force;
  }
}
