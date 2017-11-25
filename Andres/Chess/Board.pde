class Board {
  Piece[][] board = new Piece[8][8];
  int size;
  int turn = 1;
  String fenString;
  boolean verify = false;
  Board (String a, int s) {
    fenString = a;
    size = s;
  }

  public int getSize() {
    return size;
  }

  public void setFEN(String f) {
    fenString = f;
  }

  public void importFEN() {
    boolean whiteToMove;
    int charIndex = 0;
    int rowIndex = 0;
    int columnIndex = 0;
    while (fenString.charAt(charIndex) != ' ')
    {
      switch (fenString.charAt(charIndex++))
      {
      case 'P': 
        board[columnIndex%8][rowIndex%8] = new Pawn(new PVector(columnIndex%8, rowIndex%8), false, i[0]);
        columnIndex++;
        break;
      case 'p': 
        board[columnIndex%8][rowIndex%8] = new Pawn(new PVector(columnIndex%8, rowIndex%8), true, i[1]);
        columnIndex++;
        break;
      case 'N': 
        board[columnIndex%8][rowIndex%8] = new Knight(new PVector(columnIndex%8, rowIndex%8), false, i[4]);
        columnIndex++;
        break;
      case 'n': 
        board[columnIndex%8][rowIndex%8] = new Knight(new PVector(columnIndex%8, rowIndex%8), true, i[5]);
        columnIndex++;
        break;
      case 'B': 
        board[columnIndex%8][rowIndex%8] = new Bishop(new PVector(columnIndex%8, rowIndex%8), false, i[2]);
        columnIndex++;
        break;
      case 'b': 
        board[columnIndex%8][rowIndex%8] = new Bishop(new PVector(columnIndex%8, rowIndex%8), true, i[3]);
        columnIndex++;
        break;
      case 'R': 
        board[columnIndex%8][rowIndex%8] = new Rock(new PVector(columnIndex%8, rowIndex%8), false, i[6]);
        columnIndex++;
        break;
      case 'r': 
        board[columnIndex%8][rowIndex%8] = new Rock(new PVector(columnIndex%8, rowIndex%8), true, i[7]);
        columnIndex++;
        break;
      case 'Q': 
        board[columnIndex%8][rowIndex%8] = new Queen(new PVector(columnIndex%8, rowIndex%8), false, i[8]);
        columnIndex++;
        break;
      case 'q': 
        board[columnIndex%8][rowIndex%8] = new Queen(new PVector(columnIndex%8, rowIndex%8), true, i[9]);
        columnIndex++;
        break;
      case 'K': 
        board[columnIndex%8][rowIndex%8] = new King(new PVector(columnIndex%8, rowIndex%8), false, i[10]);
        columnIndex++;
        break;
      case 'k': 
        board[columnIndex%8][rowIndex%8] = new King(new PVector(columnIndex%8, rowIndex%8), true, i[11]);
        columnIndex++;
        break;
      case '/': 
        rowIndex++;
        columnIndex = 0;
        break;
      case '1': 
        columnIndex++;
        break;
      case '2': 
        columnIndex += 2;
        break;
      case '3': 
        columnIndex += 3;
        break;
      case '4': 
        columnIndex += 4;
        break;
      case '5': 
        columnIndex += 5;
        break;
      case '6': 
        columnIndex += 6;
        break;
      case '7': 
        columnIndex += 7;
        break;
      case '8': 
        columnIndex += 8;
        break;
      }
    }
    whiteToMove=(fenString.charAt(++charIndex) == 'w');
    charIndex += 2;
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

  public void cast() {
    if (pieceSelection().x < 8) {
      if (board[(int)pieceSelection().x][(int)pieceSelection().y].getClass().getName() == "Chess$King" && board[(int)pieceSelection().x][(int)pieceSelection().y].possibleMovements().indexOf(new PVector(6, 7)) != -1 && board[(int)pieceSelection().x][(int)pieceSelection().y].first) {
        
      }
      if (board[(int)pieceSelection().x][(int)pieceSelection().y].getClass().getName() == "Chess$King" && board[(int)pieceSelection().x][(int)pieceSelection().y].possibleMovements().indexOf(new PVector(2, 7)) != -1 && board[(int)pieceSelection().x][(int)pieceSelection().y].first) {
        board[0][7].setPosition(new PVector(3, 7));
        board[3][7] = board[0][7];
        board[0][7] = null;
      }
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
    cast();
    if ((board[(int)mousePosition().x][(int)mousePosition().y] == null) && (board[(int)pieceSelection().x][(int)pieceSelection().y].possibleMovements().indexOf(mousePosition()) != -1)) {
      board[(int)mousePosition().x][(int)mousePosition().y] = board[(int)pieceSelection().x][(int)pieceSelection().y];
      board[(int)pieceSelection().x][(int)pieceSelection().y] = null;
      board[(int)mousePosition().x][(int)mousePosition().y].setPosition(new PVector(mousePosition().x, mousePosition().y));
      verify = true;
      turn += 1;
      if (board[(int)pieceSelection().x][(int)pieceSelection().y].getClass().getName() == "Chess$King" || board[(int)pieceSelection().x][(int)pieceSelection().y].getClass().getName() == "Chess$Rock") {
        board[(int)pieceSelection().x][(int)pieceSelection().y].setFirst(false);
      }
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
          if (board[i/8][i%8].getClass().getName() != "Chess$Pawn") {
            p = board[i/8][i%8].possibleMovements();
            for (int c = 0; c < p.size(); c++) {
              PMB.add(p.get(c));
            }
          } else {
            PMB.add(new PVector((i/8)-1, (i%8)-1));
            PMB.add(new PVector((i/8)+1, (i%8)-1));
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
          if (board[i/8][i%8].getClass().getName() != "Chess$Pawn") {
            p = board[i/8][i%8].possibleMovements();
            for (int c = 0; c < p.size(); c++) {
              PMB.add(p.get(c));
            }
          } else {
            PMB.add(new PVector((i/8)-1, (i%8)+1));
            PMB.add(new PVector((i/8)+1, (i%8)+1));
          }
        }
      }
    }
    return PMB;
  }

  public boolean checkWhite() {
    boolean check = false;
    PVector kingPosition = new PVector();
    for (int i = 0; i<64; i++) {
      if (board[i/8][i%8] != null) {
        if (board[i/8][i%8].getClass().getName() == "Chess$King" && !board[i/8][i%8].getTeam()) {
          kingPosition = new PVector(i/8, i%8);
        }
      }
    }
    if (MovementsBlack().indexOf(kingPosition) != -1) {
      check = true;
    }
    //println("Blancas Jaque: " + check);
    return check;
  }

  public boolean checkBlack() {
    boolean check = false;
    PVector kingPosition = new PVector();
    for (int i = 0; i<64; i++) {
      if (board[i/8][i%8] != null) {
        if (board[i/8][i%8].getClass().getName() == "Chess$King" && board[i/8][i%8].getTeam()) {
          kingPosition = new PVector(i/8, i%8);
        }
      }
    }
    if (MovementsWhite().indexOf(kingPosition) != -1) {
      check = true;
    }
    //println("Negras Jaque: " + check);
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
    //  deselect();
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