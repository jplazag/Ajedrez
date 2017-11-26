PImage[] i = new PImage[12];
ArrayList<PVector> posible;
String b;
int c = 0, a = -1;
Reader lee = new Reader();
Board board;
//Board elegido;
boolean selection = false;

String[] lines;
StringBuffer cadena = new StringBuffer();

PrintWriter output;
String partida = "";
int cambioPartida = 0;

String posicion_inicial() {

  lines = loadStrings("ejerciciosFEN.txt");
  cadena = cadena.append(lines[0]);
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
  //elegido = new Board(b, 90);
  //elegido.importFEN();

  size(1000, 1000);
  board.turnIntoFEN(0);
}

void mouseReleased() {
  board.mouseReleased();
}
void mouseClicked() {
  board.mouseClicked();
  println(board.turn);
}


void draw() {
  //if (board.board[(int)board.mousePosition().x][(int)board.mousePosition().y] != null) {
  //  println(board.board[(int)board.mousePosition().x][(int)board.mousePosition().y].getClass().getName());
  //}else {
  //  println("null");
  //}
  //if (board.board[(int)board.mousePosition().x][(int)board.mousePosition().y] != null) {
  //  println(board.board[(int)board.mousePosition().x][(int)board.mousePosition().y].getClass());
  //  println(board.board[(int)board.mousePosition().x][(int)board.mousePosition().y].getTeam());
  //} else {
  //  println("null");
  //}

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


  if (keyPressed && key == 'a') {
    cambioPartida++;
    key = 0;
    println(cambioPartida);
  }

  switch(cambioPartida%2) {
  case 0:
    partida = "Anderssen-Kieseritzky.pgn";
    break;
  case 1:
    partida = "Partida2.pgn";
    break;
  }
  if (keyPressed && key == ' ') {
    lee.setInput(loadStrings(partida));
    lee.lector();
    for (int x = 0; x <lee.plays.size(); x++) {
      println(x + " " + lee.plays.get(x));
    }
    key = 0;
  }


  if (keyPressed && key == 'd') {
    if (c < lee.plays.size()) {
      for (int x = 0; x < lee.plays.size(); x++) {
        lee.reproductor(x);
      }
      board.reset();
      board.importFEN();
      //println(lee.plays.get(c));
      for (int x = 0; x <lee.playsFEN.size(); x++) {
        println(x + " " + lee.playsFEN.get(x));
      }
    }
    c++;
    key = 0;
    // println("Negras Jaque: " + board.checkWhite());
    //println("Negras Jaque: " + board.checkBlack());
    println(c);
    print("\n");
  }
  if (keyPressed && key == 'c') {
    a++;
    if (a < lee.playsFEN.size() && a >= 0)
      board.setFEN(lee.playsFEN.get(a));
    board.reset();
    board.importFEN();
    board.turnIntoFEN(a);
    
    key = 0;
  }
  if (keyPressed && key == 'x') {
    a--;
    if (a < lee.playsFEN.size() && a >= 0)
      board.setFEN(lee.playsFEN.get(a));
    board.reset();
    board.importFEN();
    //turnIntoFEN(false, a);

    key = 0;
  }
  if (keyPressed && key == 'z') {
    for (int x = 0; x <board.matchPlayed.size(); x++) {
      println(x + " " + board.matchPlayed.get(x));
    }
    save(board.matchPlayed);
    key = 0;
  }
}