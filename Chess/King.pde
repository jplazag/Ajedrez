class King extends Piece {

  public King(PVector p, boolean t, PImage i) {
    super(p, t, i);
  }

  public ArrayList possibleMovements() {
    ArrayList<PVector> PM = new ArrayList<PVector>();
    for (int i = 0; i<64; i++) {
      if (board.board[i/8][i%8] == null) {
        if (((abs(this.position.x-i/8)<=1)&&(abs(this.position.y-i%8)<=1))&&(this.position.x != i/8 || this.position.y != i%8)) {
          PM.add(new PVector(i/8, i%8));
        }
      } else if (team != board.board[i/8][i%8].getTeam()) {
        if (((abs(this.position.x-i/8)<=1)&&(abs(this.position.y-i%8)<=1))&&(this.position.x != i/8 || this.position.y != i%8)) {
          PM.add(new PVector(i/8, i%8));
        }
      }
    }
    if (board.board[7][7] != null) {
      if (this.first && board.board[7][7].getFirst() && board.board[5][7] == null && board.board[6][7] == null && !this.team) {
        PM.add(new PVector(6, 7));
      }
    }

    if (board.board[0][7] != null) {
      if (this.first && board.board[0][7].getFirst() && board.board[3][7] == null && board.board[2][7] == null && board.board[1][7] == null && !this.team) {
        PM.add(new PVector(2, 7));
        //board.board[0][7].setPosition(new PVector(3, 7));
      }
    }

    return PM;
  }
}