class Pawn extends Piece {

  public Pawn(PVector p, boolean t, PImage i) {
    super(p, t, i);
  }


  @Override
    public void eat() {
  }

  public ArrayList possibleMovements() {
    ArrayList<PVector> PM = new ArrayList<PVector>();
    if (this.team) {
      if (this.position.y==1) {
        PM.add(new PVector(this.position.x, this.position.y + 1));
        PM.add(new PVector(this.position.x, this.position.y + 2));
      } else {
        PM.add(new PVector(this.position.x, this.position.y + 1));
      }
    } else {
      if (this.position.y==6) {
        PM.add(new PVector(this.position.x, this.position.y - 1));
        PM.add(new PVector(this.position.x, this.position.y - 2));
      } else {
        PM.add(new PVector(this.position.x, this.position.y - 1));
      }
    }
    return PM;
  }
}