class Grass {
  ArrayList<GrassPiece> grassPieces;
  PVector pos;
  float grassWidth;
  

  Grass(int parts, float grassHeight, float grassWidth) {
    this.grassWidth = grassWidth;
    grassPieces = new ArrayList<GrassPiece>();
    float widthModifier = grassWidth/parts;
    //create the individual mass sprig dampers systems and calculate the correct width and height for them
    for (int i = 0; i< parts; i++) {
      float lowerWidth = grassWidth-i*widthModifier;
      float higherWidth = grassWidth-(i+1)*widthModifier;
      grassPieces.add(new GrassPiece(grassHeight/parts, PI/parts, parts, lowerWidth, higherWidth));
    }
  }

  void update() {
    //Update all mass spring damper systems and give them the force and velocity of their neighbours
    grassPieces.get(0).update(0, grassPieces.get(1).getForce());
    for (int i = 1; i < grassPieces.size()-1; i++) {
      grassPieces.get(i).update(grassPieces.get(i-1).getVel(), grassPieces.get(i+1).getForce());
    }
    grassPieces.get(grassPieces.size()-1).update(grassPieces.get(grassPieces.size()-2).getVel(), 0);
  }

  void display(PVector pos) {
    //display all individual pieces of grass
    strokeWeight(0);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(PI);
    for (GrassPiece subSystem : grassPieces) {
      subSystem.display();
    }
    popMatrix();
  }
  
  //Apply a force to the top piece of grass
  void addForce(float force) {
    grassPieces.get(grassPieces.size()-1).addForce(force);
  }
}
