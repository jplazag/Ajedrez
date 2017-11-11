class King extends Piece {

  public King(PVector p, boolean t, PImage i) {
    super(p, t, i);
  }

  public PVector moviment(PVector c) {
    PVector newPosition = c;
    setPosition(c.x, c.y);
    return newPosition;
  }
  
  public ArrayList posibleMoviments(){
    ArrayList<PVector> PM = new ArrayList<PVector>();
    for (int i = 1; i<=8;i++){
      for(int j = 1; j<=8;j++){
        if((abs(this.position.x-i)<=1)&&(abs(this.position.y-j)<=1)){
           PM.add(new PVector(i,j)); 
        }
      }
    }
    return PM;
}
}