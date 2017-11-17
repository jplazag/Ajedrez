class Queen extends Piece {

  public Queen(PVector p, boolean t, PImage i) {
    super(p, t, i);
  }

  public ArrayList possibleMovements() {
    ArrayList<PVector> PM = new ArrayList<PVector>();
    for (int i = 0; i<8; i++) {
      for (int j = 0; j<8; j++) {
        if ((((this.position.x==i)||(this.position.y==j))||(abs(this.position.x - i)==abs(this.position.y -j)))&&(this.position.x != i || this.position.y != j)) {
          PM.add(new PVector(i, j));
        }
      }
    }
    return PM;
  }
}