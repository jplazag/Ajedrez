class Bishop extends Piece {

  public Bishop(PVector p, boolean t, PImage i) {
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
        if(abs(this.position.x - i)==abs(this.position.y -j)){
           PM.add(new PVector(i,j)); 
        }
      }
    }
    /*for(int i = 1; i <=7;i++){
      PM[i-1] = new PVector(this.position.x+i,this.position.y+i);
    }
    for(int i = 1; i <=7;i++){
      PM[i+6] = new PVector(this.position.x-i,this.position.y+i);
    }
    for(int i = 1; i <=7;i++){
      PM[i+13] = new PVector(this.position.x-i,this.position.y-i);
    }
    for(int i = 1; i <=7;i++){
      PM[i+20] = new PVector(this.position.x+i,this.position.y-i);
    }*/
    return PM;
}
}