class Knight extends Piece {

  public Knight(PVector p, boolean t, PImage i) {
    super(p, t, i);
  }

  public ArrayList possibleMovements() {
    ArrayList<PVector> PM = new ArrayList<PVector>();
    for (int i = 0; i<8; i++) {
      for (int j = 0; j<8; j++) {
        if (((this.position.x - i)*(this.position.x - i) + (this.position.y - j)*(this.position.y - j) ==5)&&(this.position.x != i || this.position.y != j)) {
          PM.add(new PVector(i, j));
        }
      }
    } 
    return PM;
  }
}