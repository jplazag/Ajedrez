class Knight extends Piece {

  public Knight(PVector p, boolean t, PImage i) {
    super(p, t, i);
  }

  public ArrayList possibleMovements() {
    ArrayList<PVector> PM = new ArrayList<PVector>();
    for (int i = 0; i<64; i++) {
      if (board.board[i/8][i%8] == null) {
        if (((this.position.x - i/8)*(this.position.x - i/8) + (this.position.y - i%8)*(this.position.y - i%8) ==5)&&(this.position.x != i/8 || this.position.y != i%8)) {
          PM.add(new PVector(i/8, i%8));
        }
      } else if (this.team != board.board[i/8][i%8].getTeam()) {
        if (((this.position.x - i/8)*(this.position.x - i/8) + (this.position.y - i%8)*(this.position.y - i%8) ==5)&&(this.position.x != i/8 || this.position.y != i%8)) {
          PM.add(new PVector(i/8, i%8));
        }
      }
    } 
    return PM;
  }
}