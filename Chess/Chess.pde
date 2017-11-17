PImage[] i = new PImage[12];
ArrayList<PVector> posible;
Piece[][] w = new Piece[8][8];
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

  w[0][0] = new Rock(new PVector(0, 0), true, i[7]);
  w[1][0] = new Knight(new PVector(1, 0), true, i[5]);
  w[2][0] = new Bishop(new PVector(2, 0), true, i[3]);
  w[3][0] = new Queen(new PVector(3, 0), true, i[9]);
  w[4][0] = new King(new PVector(4, 0), true, i[11]);
  w[5][0] = new Bishop(new PVector(5, 0), true, i[3]);
  w[6][0] = new Knight(new PVector(6, 0), true, i[5]);
  w[7][0] = new Rock(new PVector(7, 0), true, i[7]);
  w[0][1] = new Pawn(new PVector(0, 1), true, i[1]);
  w[1][1] = new Pawn(new PVector(1, 1), true, i[1]);
  w[2][1] = new Pawn(new PVector(2, 1), true, i[1]);
  w[3][1] = new Pawn(new PVector(3, 1), true, i[1]);
  w[4][1] = new Pawn(new PVector(4, 1), true, i[1]);
  w[5][1] = new Pawn(new PVector(5, 1), true, i[1]);
  w[6][1] = new Pawn(new PVector(6, 1), true, i[1]);
  w[7][1] = new Pawn(new PVector(7, 1), true, i[1]);
  w[0][2] = null;
  w[1][2] = null;
  w[2][2] = null;
  w[3][2] = null;
  w[4][2] = null;
  w[5][2] = null;
  w[6][2] = null;
  w[7][2] = null;
  w[0][3] = null;
  w[1][3] = null;
  w[2][3] = null;
  w[3][3] = null;
  w[4][3] = null;
  w[5][3] = null;
  w[6][3] = null;
  w[7][3] = null;
  w[0][4] = null;
  w[1][4] = null;
  w[2][4] = null;
  w[3][4] = null;
  w[4][4] = null;
  w[5][4] = null;
  w[6][4] = null;
  w[7][4] = null;
  w[0][5] = null;
  w[1][5] = null;
  w[2][5] = null;
  w[3][5] = null;
  w[4][5] = null;
  w[5][5] = null;
  w[6][5] = null;
  w[7][5] = null;
  w[0][6] = new Pawn(new PVector(0, 6), false, i[0]);
  w[1][6] = new Pawn(new PVector(1, 6), false, i[0]);
  w[2][6] = new Pawn(new PVector(2, 6), false, i[0]);
  w[3][6] = new Pawn(new PVector(3, 6), false, i[0]);
  w[4][6] = new Pawn(new PVector(4, 6), false, i[0]);
  w[5][6] = new Pawn(new PVector(5, 6), false, i[0]);
  w[6][6] = new Pawn(new PVector(6, 6), false, i[0]);
  w[7][6] = new Pawn(new PVector(7, 6), false, i[0]);
  w[0][7] = new Rock(new PVector(0, 7), false, i[6]);
  w[1][7] = new Knight(new PVector(1, 7), false, i[4]);
  w[2][7] = new Bishop(new PVector(2, 7), false, i[2]);
  w[3][7] = new Queen(new PVector(3, 7), false, i[8]);
  w[4][7] = new King(new PVector(4, 7), false, i[10]);
  w[5][7] = new Bishop(new PVector(5, 7), false, i[2]);
  w[6][7] = new Knight(new PVector(6, 7), false, i[4]);
  w[7][7] = new Rock(new PVector(7, 7), false, i[6]);
  board = new Board(w, 90);
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
  if (w[(int)board.mousePosition().x][(int)board.mousePosition().y] != null) {
    board.PM(w[(int)board.mousePosition().x][(int)board.mousePosition().y].possibleMovements(), w[(int)board.mousePosition().x][(int)board.mousePosition().y].getSelection());
  }
  board.pieceSelection();
  board.display();
  board.mousePosition();
}