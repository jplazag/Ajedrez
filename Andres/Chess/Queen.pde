class Queen extends Piece {

  public Queen(PVector p, boolean t, PImage i) {
    super(p, t, i);
  }

  public PVector moviment(PVector c) {
    PVector newPosition = c;
    setPosition(c.x, c.y);
    return newPosition;
  }

  public ArrayList posibleMoviments() {
    ArrayList<PVector> PM = new ArrayList<PVector>();
    for (int i = 1; i<=8;i++){
      for(int j = 1; j<=8;j++){
        if(((this.position.x==i)||(this.position.y==j))||(abs(this.position.x - i)==abs(this.position.y -j))){
           PM.add(new PVector(i,j)); 
        }
      }
    }
    return PM;
  }
}