class Rock extends Piece {

  public Rock(PVector p, boolean t, PImage i) {
    super(p, t, i);
  }

  public ArrayList possibleMovements() {
    int up =1;
    int down =1;
    int left = 1;
    int right =1;
    ArrayList<PVector> PM = new ArrayList<PVector>();
    for (int i = 0; i<64; i++) {
      if (board.board[i/8][i%8] == null) {
        if (((this.position.x==i/8)||(this.position.y==i%8))&&(this.position.x != i/8 || this.position.y != i%8)) {
          PM.add(new PVector(i/8, i%8));
        }
      } else if (team != board.board[i/8][i%8].getTeam()) {
        if (((this.position.x==i/8)||(this.position.y==i%8))&&(this.position.x != i/8 || this.position.y != i%8)) {
          PM.add(new PVector(i/8, i%8));
        }
      }
    }

    while (right < 7-this.position.x && board.board[(int)this.position.x+right][(int)this.position.y] ==null ) {
      right++;
    }   
    for (int i = right+1; i<8; i++) {
      if (PM.indexOf(new PVector(this.position.x+i, this.position.y)) != -1) {
        int indice = PM.indexOf(new PVector(this.position.x+i, this.position.y));
        PM.remove(indice);
      }
    }
    while (left <= this.position.x && left > 0 && board.board[(int)this.position.x-left][(int)this.position.y] ==null ) {
      left++;
    }   
    for (int i = left+1; i<8; i++) {
      if (PM.indexOf(new PVector(this.position.x-i, this.position.y)) != -1) {
        int indice = PM.indexOf(new PVector(this.position.x-i, this.position.y));
        PM.remove(indice);
      }
    }
    while (up <= this.position.y && left > 0 && board.board[(int)this.position.x][(int)this.position.y-up] ==null ) {
      up++;
    }   
    for (int i = up+1; i<8; i++) {
      if (PM.indexOf(new PVector(this.position.x, this.position.y-i)) != -1) {
        int indice = PM.indexOf(new PVector(this.position.x, this.position.y-i));
        PM.remove(indice);
      }
    }
    while (down < 7-this.position.y && board.board[(int)this.position.x][(int)this.position.y+down] ==null ) {
      down++;
    }   
    for (int i = down+1; i<8; i++) {
      if (PM.indexOf(new PVector(this.position.x, this.position.y+i)) != -1) {
        int indice = PM.indexOf(new PVector(this.position.x, this.position.y+i));
        PM.remove(indice);
      }
    }

    if (this.selection) {
      for (int i = 0; i< 64; i++) {
        if (board.movementsUnderCheck().size() != 0) {
          if ((board.movementsUnderCheck().indexOf(new PVector(i/8, i%8)) == -1)) {
            if (PM.indexOf(new PVector(i/8, i%8)) != -1) {
              PM.remove(PM.indexOf(new PVector(i/8, i%8)));
            }
          }
        }
      }
    }
    return PM;
  }
}