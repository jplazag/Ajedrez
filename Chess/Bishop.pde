class Bishop extends Piece {

  public Bishop(PVector p, boolean t, PImage i) {
    super(p, t, i);
  }

  public ArrayList possibleMovements() {
    int upLeft =1;
    int upRight =1;
    int downLeft =1;
    int downRight =1;
    ArrayList<PVector> PM = new ArrayList<PVector>();
    for (int i = 0; i<64; i++) {
      if ((abs(this.position.x - i/8)==abs(this.position.y -i%8))&&(this.position.x != i/8 || this.position.y != i%8)) {
        if (board.board[i/8][i%8] == null) {
          PM.add(new PVector(i/8, i%8));
        } else {
          if (board.board[i/8][i%8].getTeam() != team) {
            PM.add(new PVector(i/8, i%8));
          }
        }
      }
    }

    while (downRight < 7-this.position.y && downRight < 7-this.position.x && board.board[(int)this.position.x+downRight][(int)this.position.y+downRight] ==null ) {
      downRight++;
    }   
    for (int i = downRight+1; i<8; i++) {
      if (PM.indexOf(new PVector(this.position.x+i, this.position.y+i)) != -1) {
        int indice = PM.indexOf(new PVector(this.position.x+i, this.position.y+i));
        PM.remove(indice);
      }
    }
    while (upRight <= this.position.y && upRight < 7-this.position.x && board.board[(int)this.position.x+upRight][(int)this.position.y-upRight] ==null ) {
      upRight++;
    }   
    for (int i = upRight+1; i<8; i++) {
      if (PM.indexOf(new PVector(this.position.x+i, this.position.y-i)) != -1) {
        int indice = PM.indexOf(new PVector(this.position.x+i, this.position.y-i));
        PM.remove(indice);
      }
    }
    while (upLeft < this.position.y && upLeft <= this.position.x && upLeft > 0 && board.board[(int)this.position.x-upLeft][(int)this.position.y-upLeft] ==null ) {
      upLeft++;
    }   
    for (int i = upLeft+1; i<8; i++) {
      if (PM.indexOf(new PVector(this.position.x-i, this.position.y-i)) != -1) {
        int indice = PM.indexOf(new PVector(this.position.x-i, this.position.y-i));
        PM.remove(indice);
      }
    }
    while (downLeft < 7-this.position.y && downLeft <= this.position.x && downLeft > 0 && board.board[(int)this.position.x-downLeft][(int)this.position.y+downLeft] ==null ) {
      downLeft++;
    }   
    for (int i = downLeft+1; i<8; i++) {
      if (PM.indexOf(new PVector(this.position.x-i, this.position.y+i)) != -1) {
        int indice = PM.indexOf(new PVector(this.position.x-i, this.position.y+i));
        PM.remove(indice);
      }
    }
    if (this.selection) {
      boolean algo = false;
      for (int i = 0; i < board.movementsUnderCheck().size() && i<PM.size(); i++) {
        if (PM.indexOf(board.movementsUnderCheck().get(i)) != -1) {  
          PVector mierda = PM.remove(PM.indexOf(board.movementsUnderCheck().get(i)));
          PM = new ArrayList<PVector>();
          PM.add(mierda);
          algo = true;
        }
      }

      if (!algo && board.pieceCheck != null) {
        PM = new ArrayList<PVector>();
      }
    }

    return PM;
  }
}