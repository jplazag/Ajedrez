class Pawn extends Piece {

  public Pawn(PVector p, boolean t, PImage i) {
    super(p, t, i);
  }

  public PVector moviment(PVector c) {
    PVector newPosition = c;
    setPosition(c.x, c.y);
    return newPosition;
  }

  @Override
    public void eat() {
  }
  
    public ArrayList posibleMoviments(){
    ArrayList<PVector> PM = new ArrayList<PVector>();
    
    return PM;
}
}