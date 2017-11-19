PImage[] i = new PImage[12];
ArrayList<PVector> posible;
Piece[][] b = new Piece[8][8];
Board board;
boolean selection = false;

void setup() {
  i[0] = loadImage("PeonB.png");
  i[1] = loadImage("PeonN.png");
  i[2] = loadImage("AlfilB.png");
  i[3] = loadImage("AlfilN.png");
  i[4] = loadImage("CaballoB.png");
  i[5] = loadImage("CaballoN.png");
  i[6] = loadImage("TorreB.png");
  i[7] = loadImage("TorreN.png");
  i[8] = loadImage("ReinaB.png");
  i[9] = loadImage("ReinaN.png");
  i[10] = loadImage("ReyB.png");
  i[11] = loadImage("ReyN.png");

  b[0][0] = new Rock(new PVector(0, 0), true, i[7]);
  b[1][0] = new Knight(new PVector(1, 0), true, i[5]);
  b[2][0] = new Bishop(new PVector(2, 0), true, i[3]);
  b[3][0] = new Queen(new PVector(3, 0), true, i[9]);
  b[4][0] = new King(new PVector(4, 0), true, i[11]);
  b[5][0] = new Bishop(new PVector(5, 0), true, i[3]);
  b[6][0] = new Knight(new PVector(6, 0), true, i[5]);
  b[7][0] = new Rock(new PVector(7, 0), true, i[7]);
  b[0][1] = new Pawn(new PVector(0, 1), true, i[1]);
  b[1][1] = new Pawn(new PVector(1, 1), true, i[1]);
  b[2][1] = new Pawn(new PVector(2, 1), true, i[1]);
  b[3][1] = new Pawn(new PVector(3, 1), true, i[1]);
  b[4][1] = new Pawn(new PVector(4, 1), true, i[1]);
  b[5][1] = new Pawn(new PVector(5, 1), true, i[1]);
  b[6][1] = new Pawn(new PVector(6, 1), true, i[1]);
  b[7][1] = new Pawn(new PVector(7, 1), true, i[1]);
  b[0][2] = null;
  b[1][2] = null;
  b[2][2] = null;
  b[3][2] = null;
  b[4][2] = null;
  b[5][2] = null;
  b[6][2] = null;
  b[7][2] = null;
  b[0][3] = null;
  b[1][3] = null;
  b[2][3] = null;
  b[3][3] = null;
  b[4][3] = null;
  b[5][3] = null;
  b[6][3] = null;
  b[7][3] = null;
  b[0][4] = null;
  b[1][4] = null;
  b[2][4] = null;
  b[3][4] = null;
  b[4][4] = null;
  b[5][4] = null;
  b[6][4] = null;
  b[7][4] = null;
  b[0][5] = null;
  b[1][5] = null;
  b[2][5] = null;
  b[3][5] = null;
  b[4][5] = null;
  b[5][5] = null;
  b[6][5] = null;
  b[7][5] = null;
  b[0][6] = new Pawn(new PVector(0, 6), false, i[0]);
  b[1][6] = new Pawn(new PVector(1, 6), false, i[0]);
  b[2][6] = new Pawn(new PVector(2, 6), false, i[0]);
  b[3][6] = new Pawn(new PVector(3, 6), false, i[0]);
  b[4][6] = new Pawn(new PVector(4, 6), false, i[0]);
  b[5][6] = new Pawn(new PVector(5, 6), false, i[0]);
  b[6][6] = new Pawn(new PVector(6, 6), false, i[0]);
  b[7][6] = new Pawn(new PVector(7, 6), false, i[0]);
  b[0][7] = new Rock(new PVector(0, 7), false, i[6]);
  b[1][7] = new Knight(new PVector(1, 7), false, i[4]);
  b[2][7] = new Bishop(new PVector(2, 7), false, i[2]);
  b[3][7] = new Queen(new PVector(3, 7), false, i[8]);
  b[4][7] = new King(new PVector(4, 7), false, i[10]);
  b[5][7] = new Bishop(new PVector(5, 7), false, i[2]);
  b[6][7] = new Knight(new PVector(6, 7), false, i[4]);
  b[7][7] = new Rock(new PVector(7, 7), false, i[6]);
  board = new Board(b, 90);
  size(1000, 1000);
}

void mouseReleased() {
  board.mouseReleased();
}
void mouseClicked() {
  board.mouseClicked();
}


void draw() {
  board.cuadricula();
  board.pieceSelection();
  if (board.board[(int)board.mousePosition().x][(int)board.mousePosition().y] != null) {
    board.PM(board.board[(int)board.mousePosition().x][(int)board.mousePosition().y].possibleMovements(), board.board[(int)board.mousePosition().x][(int)board.mousePosition().y].getSelection());
  }
  board.display();
  board.mousePosition();
}