PImage[] i = new PImage[12];
ArrayList<PVector> posible;
String b;
int c = 0;
Reader lee = new Reader();
Board board;
boolean selection = false;

String[] lines;
StringBuffer cadena = new StringBuffer();

String posicion_inicial() {

  lines = loadStrings("ejerciciosFEN.txt");
  //for (int x=0;x<lines.length;x++){
  cadena = cadena.append(lines[0]);
  //} 
  return cadena.toString();
}

void setup() {
  b = posicion_inicial();
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

  board = new Board(b, 90);
  board.importFEN();
  lee.setInput(loadStrings("Anderssen-Kieseritzky.pgn"));
  lee.lector();
  //size(1000, 1000);
  fullScreen();
}

void mouseReleased() {
  board.mouseReleased();
}
void mouseClicked() {
  board.mouseClicked();
}


void draw() {
  //println(board.mousePosition());
  //if// (board.board[(int)board.mousePosition().x][(int)board.mousePosition().y] != null) {
  //  //println(board.board[(int)board.mousePosition().x][(int)board.mousePosition().y].getClass());
  //  //println(board.board[(int)board.mousePosition().x][(int)board.mousePosition().y].getTeam());
  //} //else {
  //  //println("null");
  //}
  //  
  board.cuadricula();
  board.pieceSelection();
  //if (board.board[(int)board.mousePosition().x][(int)board.mousePosition().y] != null) {
  //  board.PM(/*board.board[(int)board.mousePosition().x][(int)board.mousePosition().y].possibleMovements()*/ board.MovementsWhite(), !board.board[(int)board.mousePosition().x][(int)board.mousePosition().y].getTeam());
  //}
  if (board.board[(int)board.mousePosition().x][(int)board.mousePosition().y] != null) {
    board.PM(board.board[(int)board.mousePosition().x][(int)board.mousePosition().y].possibleMovements() /*board.MovementsBlack()*/, board.board[(int)board.mousePosition().x][(int)board.mousePosition().y].getSelection());
  }
  board.checkBlack();
  board.checkWhite();
  board.display();
  board.mousePosition();

  if (keyPressed && key == 'd') {
    lee.reproductor(c);
    println(lee.plays.get(c));
    c++;
    for (int j = 0; j<board.board.length; j++) {
      for (int i = 0; i<board.board.length; i++) {
        if (board.board[i][j] != null) {
          if (!board.board[i][j].getTeam()) {
            switch(board.board[i][j].getClass().getName()) {   
            case  "Chess$Rock":
              print("R");
              break;
            case "Chess$Knight":
              print("C");
              break;
            case "Chess$Bishop":
              print("B");
              break;
            case "Chess$Queen":
              print("Q");
              break;
            case "Chess$King":
              print("K");
              break;
            case "Chess$Pawn":
              print("P");
              break;
            }
          } else {
            switch(board.board[i][j].getClass().getName()) {  
            case  "Chess$Rock":
              print("r");
              break;
            case "Chess$Knight":
              print("c");
              break;
            case "Chess$Bishop":
              print("b");
              break;
            case "Chess$Queen":
              print("q");
              break;
            case "Chess$King":
              print("k");
              break;
            case "Chess$Pawn":
              print("p");
              break;
            }
          }
        } else {
          print("O");
        }
        print("\r");
      }   
      print("\n");
    }
    key = 0;
    println(c);
    print("\n");
  }
}