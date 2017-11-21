class Board {
  Piece[][] board = new Piece[8][8];
  int size;
  int turn = 1;
  boolean verify = false;
  Board (Piece[][] a, int s) {
    board = a;
    size = s;
  }

  public int getSize() {
    return size;
  }

  public void display () {
    for (int i = 0; i < 64; i ++) {
      if (board[i/8][i%8] != null) {
        board[i/8][i%8].drawPiece(size);
      }
    }
  }

  public void cuadricula () {
    pushMatrix();
    for (int i = 0; i < 64; i += 2) {
      fill(255, 200, 100);
      rect(((i%8)+(i/8)%2)*size, (i/8)*size, size, size);
      fill(150, 50, 20);
      rect(((i+1)%8-((i+1)/8)%2)*size, (i/8)*size, size, size);
    }
    popMatrix();
  }

  public void deselect() {
    if ((board[(int)pieceSelection().x][(int)pieceSelection().y].possibleMovements().indexOf(mousePosition()) == -1)) {
      board[(int)pieceSelection().x][(int)pieceSelection().y].setSelection(false);
    }
  }

  public void onlySelection() {
    for (int i = 0; i<64; i++) {
      if (((i/8) != (int)mousePosition().x  || (i%8) !=(int)mousePosition().y) && board[i/8][i%8] != null) {
        board[i/8][i%8].setSelection(false);
      }
    }
  }

  public void turnManager() {
    if (turn % 2 != 0) {
      if (!board[(int)mousePosition().x][(int)mousePosition().y].getTeam()) {
        board[(int)mousePosition().x][(int)mousePosition().y].setSelection(true);
      }
    } else {
      if (board[(int)mousePosition().x][(int)mousePosition().y].getTeam()) {
        board[(int)mousePosition().x][(int)mousePosition().y].setSelection(true);
      }
    }
  }

  public void move() {
    if ((board[(int)mousePosition().x][(int)mousePosition().y] == null) && (board[(int)pieceSelection().x][(int)pieceSelection().y].possibleMovements().indexOf(mousePosition()) != -1)) {
      board[(int)mousePosition().x][(int)mousePosition().y] = board[(int)pieceSelection().x][(int)pieceSelection().y];
      board[(int)pieceSelection().x][(int)pieceSelection().y] = null;
      board[(int)mousePosition().x][(int)mousePosition().y].setPosition(new PVector(mousePosition().x, mousePosition().y));
      verify = true;
      turn += 1;
    }
  }

  public void eat() {
    if ((board[(int)mousePosition().x][(int)mousePosition().y] != null) && (board[(int)pieceSelection().x][(int)pieceSelection().y].possibleMovements().indexOf(mousePosition()) != -1)) {
      if (board[(int)mousePosition().x][(int)mousePosition().y] != null) {
        if ((board[(int)pieceSelection().x][(int)pieceSelection().y].getTeam() != board[(int)mousePosition().x][(int)mousePosition().y].getTeam()) && (board[(int)pieceSelection().x][(int)pieceSelection().y].possibleMovements().indexOf(mousePosition()) != -1)) {
          board[(int)mousePosition().x][(int)mousePosition().y] = board[(int)pieceSelection().x][(int)pieceSelection().y];
          board[(int)pieceSelection().x][(int)pieceSelection().y] = null;
          board[(int)mousePosition().x][(int)mousePosition().y].setPosition(new PVector(mousePosition().x, mousePosition().y));
          verify = true;
          turn += 1;
        }
      }
      deselect();
    }
  }
  public PVector mousePosition() {
    PVector p = new PVector(0, 0);
    for (int i = 0; i < 64; i ++) {
      if ((mouseX>=(i/8)*size) && (mouseX<=(i/8+1)*size) && (mouseY>=(i%8)*size) && (mouseY<=((i%8)+1)*size)) {
        p.x=i/8;
        p.y=i%8;
      }
    }
    return p;
  }

  public ArrayList MovementsWhite() {
    ArrayList<PVector> PMB = new ArrayList<PVector>();
    ArrayList<PVector> p = new ArrayList<PVector>();
    for (int i = 0; i<64; i++) {
      if (board[i/8][i%8] != null) {
        if (!board[i/8][i%8].getTeam()) {
          p = board[i/8][i%8].possibleMovements();
          for (int c = 0; c < p.size(); c++) {
            PMB.add(p.get(c));
          }
        }
      }
    }
    return PMB;
  }

  public ArrayList MovementsBlack() {
    ArrayList<PVector> PMB = new ArrayList<PVector>();
    ArrayList<PVector> p = new ArrayList<PVector>();
    for (int i = 0; i<64; i++) {
      if (board[i/8][i%8] != null) {
        if (board[i/8][i%8].getTeam()) {
          p = board[i/8][i%8].possibleMovements();
          for (int c = 0; c < p.size(); c++) {
            PMB.add(p.get(c));
          }
        }
      }
    }
    return PMB;
  }

  public boolean check() {
    boolean check = false;

    return check;
  }

  public boolean selectPiece() {
    boolean select = false;
    return select;
  }

  public void PM(ArrayList p, boolean b) {
    ArrayList<PVector> posible = p;
    if (b) {
      for (int i = 0; i<64; i++) {
        for (int c = 0; c < posible.size(); c++) {
          if ((((i/8)  == posible.get(c).x) && ((i%8) == posible.get(c).y))) {
            fill(255, (c*10)%255, 0);
            rect((i/8)*size, (i%8)*size, size, size);
            fill(0);
            //textSize(50);
            //text(c, (i)/8*size, (i)%8*size);
          }
        }
      }
    }
  }

  public PVector pieceSelection() {
    PVector p = new PVector(8, 8);
    for (int i = 0; i<64; i++) {
      if (board[i/8][i%8] != null) {
        if (board[i/8][i%8].getSelection() == true) {
          p = new PVector(board[i/8][i%8].getPosition().x, board[i/8][i%8].getPosition().y);
          fill(0, 255, 0);
          rect((i/8)*size, (i%8)*size, size, size);
        }
      }
    }
    return p;
  }

  public void mouseReleased() {
  }

  public void mouseClicked() {
    if (pieceSelection().x < 8 && pieceSelection().y < 8) {
      move();
      eat();
    }
    if (board[(int)mousePosition().x][(int)mousePosition().y] != null) {
      onlySelection();
      if (mouseX < size*8 && mouseY < size*8) { 
        turnManager();
      } 
      if (verify) {
        board[(int)mousePosition().x][(int)mousePosition().y].setSelection(false);
        verify=false;
      }
    }
  }
}