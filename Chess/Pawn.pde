class Pawn extends Piece {

  public Pawn(PVector p, boolean t, PImage i) {
    super(p, t, i);
  }

  public ArrayList possibleMovements() {
    ArrayList<PVector> PM = new ArrayList<PVector>();
    if (this.team) {
      if (this.position.x != 7) {
        if (board.board[(int)this.position.x +1][(int)this.position.y+1] != null) {
          if (team != board.board[(int)this.position.x +1][(int)this.position.y+1].getTeam()) {
            PM.add(new PVector(this.position.x+1, this.position.y +1));
          }
        }
      }
      if (this.position.x != 0) {
        if (board.board[(int)this.position.x -1][(int)this.position.y+1] != null) {
          if (team != board.board[(int)this.position.x -1][(int)this.position.y+1].getTeam()) {
            PM.add(new PVector(this.position.x-1, this.position.y +1));
          }
        }
      }
      if (this.position.y==1) {
        if (board.board[(int)this.position.x][(int)this.position.y + 1] == null) {
          PM.add(new PVector(this.position.x, this.position.y + 1));
          if (board.board[(int)this.position.x][(int)this.position.y + 2] == null) {
            PM.add(new PVector(this.position.x, this.position.y + 2));
          }
        }
      } else {
        if (board.board[(int)this.position.x][(int)this.position.y + 1] == null) {
          PM.add(new PVector(this.position.x, this.position.y + 1));
        }
      }
    } else {
      if (this.position.x != 7) {
        if (board.board[(int)this.position.x +1][(int)this.position.y-1] != null) {
          if (team != board.board[(int)this.position.x +1][(int)this.position.y-1].getTeam()) {
            PM.add(new PVector(this.position.x+1, this.position.y -1));
          }
        }
      }
      if (this.position.x != 0) {
        if (board.board[(int)this.position.x -1][(int)this.position.y-1] != null) {
          if (team != board.board[(int)this.position.x -1][(int)this.position.y-1].getTeam()) {
            PM.add(new PVector(this.position.x-1, this.position.y -1));
          }
        }
      }
      if (this.position.y==6) {
        if (board.board[(int)this.position.x][(int)this.position.y - 1] == null) {
          PM.add(new PVector(this.position.x, this.position.y - 1));
          if (board.board[(int)this.position.x][(int)this.position.y - 2] == null) {
            PM.add(new PVector(this.position.x, this.position.y - 2));
          }
        }
      } else {
        if (board.board[(int)this.position.x][(int)this.position.y - 1] == null) {
          PM.add(new PVector(this.position.x, this.position.y - 1));
        }
      }
    }
    
    //if(){}

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