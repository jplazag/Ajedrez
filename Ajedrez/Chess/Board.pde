class Board {
  Piece[][] board = new Piece[8][8];
  int size, numJugada;
  Piece pieceCheck;
  boolean turn = true;
  String fenString;
  boolean verify = false;
  ArrayList<String> matchPlayed = new ArrayList<String>();

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

  public void reset() {
    for (int x = 0; x< 64; x++) {
      board[x/8][x%8] = null;
    }
  }

  public void importFEN() {
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
    switch(fenString.charAt(++charIndex)) {
    case 'w':
      turn = true;
      break;
    case 'a':
      turn = false;
      break;
    }
  }

  public String turnIntoFEN(int turno) {
    int contCol = 0;
    String memoria = "";
    for (int j = 0; j < 8; j++) {
      for (int i = 0; i < 8; i++) {        
        if (board[i][j] != null) {
          if (contCol != 0)
            memoria += (char)(contCol + 48);
          if (!board[i][j].getTeam()) {
            switch(board[i][j].getClass().getName()) {
            case "Chess$Rock":
              memoria += "R";
              break;
            case "Chess$Knight":
              memoria += "N";
              break;
            case "Chess$Bishop":
              memoria += "B";
              break;
            case "Chess$King":
              memoria += "K";
              break;
            case "Chess$Queen":
              memoria += "Q";
              break;
            case "Chess$Pawn":
              memoria += "P";
              break;
            }
          } else {
            switch(board[i][j].getClass().getName()) {
            case "Chess$Rock":
              memoria += "r";
              break;
            case "Chess$Knight":
              memoria += "n";
              break;
            case "Chess$Bishop":
              memoria += "b";
              break;
            case "Chess$King":
              memoria += "k";
              break;
            case "Chess$Queen":
              memoria += "q";
              break;
            case "Chess$Pawn":
              memoria += "p";
              break;
            }
          }
          contCol = 0;
        } else {
          contCol++;
        }
      }
      if (contCol != 0)
        memoria += (char)(contCol + 48);
      if (j < 7)
        memoria += "/";
      if (j == 7) {
        memoria += " ";
        if (turno % 2 == 0) {
          memoria += "a";
        } else if (turno % 2 == 1) {
          memoria += "w";
        }
      }
      contCol = 0;
    }

    return memoria;
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
    translate(width/2-size*4, (height/2-size*4));
    for (int i = 0; i < 64; i += 2) {
      fill(255, 200, 100);
      image(whiteSq, ((i%8)+(i/8)%2)*size, (i/8)*size);
      fill(150, 50, 20);
      image(blackSq, ((i+1)%8-((i+1)/8)%2)*size, (i/8)*size);
    }
    popMatrix();
  }
  public void deselect() {
    if (pieceSelection().x < 8 && pieceSelection().y < 8) {
      if ((board[(int)pieceSelection().x][(int)pieceSelection().y].possibleMovements().indexOf(mousePosition()) == -1)) {
        board[(int)pieceSelection().x][(int)pieceSelection().y].setSelection(false);
      }
    }
  }

  public void cast() {
    if (board[6][7] != null) {
      if (board[6][7].getClass().getName() == "Chess$King" && board[6][7].getFirst()) {
        board[5][7] = board[7][7];
        board[7][7] = null;
        board[5][7].setPosition(new PVector(5, 7));
      }
    }
    if (board[2][7] != null) {
      if (board[2][7].getClass().getName() == "Chess$King" && board[2][7].getFirst()) {
        board[3][7] = board[0][7];
        board[0][7] = null;
        board[3][7].setPosition(new PVector(3, 7));
      }
    }
    if (board[2][0] != null) {
      if (board[2][0].getClass().getName() == "Chess$King" && board[2][0].getFirst()) {
        board[3][0] = board[0][0];
        board[0][0] = null;
        board[3][0].setPosition(new PVector(3, 0));
      }
    }
    if (board[6][0] != null) {
      if (board[6][0].getClass().getName() == "Chess$King" && board[6][0].getFirst()) {
        board[5][0] = board[7][0];
        board[7][0] = null;
        board[5][0].setPosition(new PVector(5, 0));
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
    if (turn) {
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
    if (numJugada == 0) {
      matchPlayed.add(turnIntoFEN(numJugada));
    }
    if ((board[(int)mousePosition().x][(int)mousePosition().y] == null) && (board[(int)pieceSelection().x][(int)pieceSelection().y].possibleMovements().indexOf(mousePosition()) != -1)) {
      board[(int)mousePosition().x][(int)mousePosition().y] = board[(int)pieceSelection().x][(int)pieceSelection().y];
      board[(int)pieceSelection().x][(int)pieceSelection().y] = null;
      board[(int)mousePosition().x][(int)mousePosition().y].setPosition(new PVector(mousePosition().x, mousePosition().y));
      verify = true;
      turn = !turn;
      numJugada++;
      matchPlayed.add(turnIntoFEN(numJugada));
      save(matchPlayed);
      cast();
      if (board[(int)pieceSelection().x][(int)pieceSelection().y].getClass().getName() == "Chess$King" || board[(int)pieceSelection().x][(int)pieceSelection().y].getClass().getName() == "Chess$Rock") {
        board[(int)pieceSelection().x][(int)pieceSelection().y].setFirst(false);
      }
    }
  }

  public PVector promotion() {
    PVector posPromotion = null;
    for (int i = 0; i < 8; i++) {
      if (board[i][0] != null) {
        if (board[i][0].getClass().getName() == "Chess$Pawn") {
          posPromotion = new PVector(i, 0);
          prom = true;
        }
      }
      if (board[i][7] != null) {
        if (board[i][7].getClass().getName() == "Chess$Pawn") {
          posPromotion = new PVector(i, 7);
            prom = true;
        }
      }
      if (posPromotion != null) {
        
        if (!board[(int)posPromotion.x][(int)posPromotion.y].getTeam()) {
          if (promo == 1) {
            board[(int)posPromotion.x][(int)posPromotion.y] = new Queen(new PVector((int)posPromotion.x, (int)posPromotion.y), false, loadImage("ReinaB.png"));
            promo=0;
          }
          if (promo == 2) {
            board[(int)posPromotion.x][(int)posPromotion.y] = new Knight(new PVector((int)posPromotion.x, (int)posPromotion.y), false, loadImage("CaballoB.png"));
            promo=0;
          }
          if (promo == 3) {
            board[(int)posPromotion.x][(int)posPromotion.y] = new Bishop(new PVector((int)posPromotion.x, (int)posPromotion.y), false, loadImage("AlfilB.png"));
            promo=0;
          }
          if (promo == 4) {
            board[(int)posPromotion.x][(int)posPromotion.y] = new Rock(new PVector((int)posPromotion.x, (int)posPromotion.y), false, loadImage("TorreB.png"));
            promo=0;
          }
        } else if (board[(int)posPromotion.x][(int)posPromotion.y].getTeam()) {
          if (promo == 1) {
            board[(int)posPromotion.x][(int)posPromotion.y] = new Queen(new PVector((int)posPromotion.x, (int)posPromotion.y), true, loadImage("ReinaN.png"));
            promo=0;
          }
          if (promo == 2) {
            board[(int)posPromotion.x][(int)posPromotion.y] = new Knight(new PVector((int)posPromotion.x, (int)posPromotion.y), true, loadImage("CaballoN.png"));
            promo=0;
          }
          if (promo == 3) {
            board[(int)posPromotion.x][(int)posPromotion.y] = new Bishop(new PVector((int)posPromotion.x, (int)posPromotion.y), true, loadImage("AlfilN.png"));
            promo=0;
          }
          if (promo == 4) {
            board[(int)posPromotion.x][(int)posPromotion.y] = new Rock(new PVector((int)posPromotion.x, (int)posPromotion.y), true, loadImage("TorreN.png"));
            promo=0;
          }
        }
      }
    }
    return posPromotion;
  }

  public void eat() {
    if (pieceSelection().x < 8 && pieceSelection().y < 8) {
      if ((board[(int)mousePosition().x][(int)mousePosition().y] != null) && (board[(int)pieceSelection().x][(int)pieceSelection().y].possibleMovements().indexOf(mousePosition()) != -1)) {
        if (board[(int)mousePosition().x][(int)mousePosition().y] != null) {
          if ((board[(int)pieceSelection().x][(int)pieceSelection().y].getTeam() != board[(int)mousePosition().x][(int)mousePosition().y].getTeam()) && (board[(int)pieceSelection().x][(int)pieceSelection().y].possibleMovements().indexOf(mousePosition()) != -1)) {
            board[(int)mousePosition().x][(int)mousePosition().y] = board[(int)pieceSelection().x][(int)pieceSelection().y];
            board[(int)pieceSelection().x][(int)pieceSelection().y] = null;
            board[(int)mousePosition().x][(int)mousePosition().y].setPosition(new PVector(mousePosition().x, mousePosition().y));
            verify = true;
            turn = !turn;
            matchPlayed.add(turnIntoFEN(numJugada));
            save(matchPlayed);
          }
        }
        deselect();
      }
    }
  }
  public PVector mousePosition() {
    PVector p = new PVector(0, 0);
    for (int i = 0; i < 64; i ++) {
      if ((mouseX>=(i/8)*size + width/2-size*4) && (mouseX<=(i/8+1)*size + width/2-size*4) && (mouseY>=(i%8)*size + height/2-size*4) && (mouseY<=((i%8)+1)*size + height/2-size*4)) {
        p.x=i/8;
        p.y=i%8;
      }
    }
    //println(p);
    return p;
  }

  public ArrayList movementsUnderCheck() {
    boolean verifyB = true;
    boolean verifyN = true;
    ArrayList<PVector> MUC = new ArrayList<PVector>();
    if (pieceCheck != null) {
      if (pieceCheck.getTeam()) {
        if (pieceSelection().x < 8 && pieceSelection().y < 8) {
          if (board[(int)pieceSelection().x][(int)pieceSelection().y].getClass().getName() == "Chess$King") {
            MUC = board[(int)kingPositionWhite().x][(int)kingPositionWhite().y].possibleMovements();
          } else {
            MUC.add(pieceCheck.getPosition());
            if (pieceCheck.getClass().getName() == "Chess$Bishop" || pieceCheck.getClass().getName() == "Chess$Queen") {
              if (pieceCheck.getPosition().x < kingPositionWhite().x && pieceCheck.getPosition().y < kingPositionWhite().y) {
                for (int i = 1; i< kingPositionWhite().x - pieceCheck.getPosition().x; i++) {
                  MUC.add(new PVector(pieceCheck.getPosition().x + i, pieceCheck.getPosition().y + i));
                  verifyB = false;
                }
              }
              if (pieceCheck.getPosition().x < kingPositionWhite().x && pieceCheck.getPosition().y > kingPositionWhite().y) {
                for (int i = 0; i< kingPositionWhite().x - pieceCheck.getPosition().x; i++) {
                  MUC.add(new PVector(pieceCheck.getPosition().x +i, pieceCheck.getPosition().y - i));
                  verifyB = false;
                }
              }
              if (pieceCheck.getPosition().x > kingPositionWhite().x && pieceCheck.getPosition().y < kingPositionWhite().y) {
                for (int i = 1; i <pieceCheck.getPosition().x - kingPositionWhite().x; i++) {
                  MUC.add(new PVector((int)kingPositionWhite().x + i, (int)kingPositionWhite().y - i));
                  verifyB = false;
                }
              }
              if (pieceCheck.getPosition().x > kingPositionWhite().x && pieceCheck.getPosition().y > kingPositionWhite().y) {
                for (int i = 1; i <pieceCheck.getPosition().x - kingPositionWhite().x; i++) {
                  MUC.add(new PVector((int)kingPositionWhite().x + i, (int)kingPositionWhite().y + i));
                  verifyB = false;
                }
              }
            }
            if (verifyB) {
              if (pieceCheck.getClass().getName() == "Chess$Rock" || pieceCheck.getClass().getName() == "Chess$Queen") {
                if (pieceCheck.getPosition().x < kingPositionWhite().x) {
                  for (int i = 1; i< kingPositionWhite().x - pieceCheck.getPosition().x; i++) {
                    MUC.add(new PVector(pieceCheck.getPosition().x + i, pieceCheck.getPosition().y));
                  }
                }
                if (pieceCheck.getPosition().x > kingPositionWhite().x) {
                  for (int i = 1; i< pieceCheck.getPosition().x - kingPositionWhite().x; i++) {
                    MUC.add(new PVector(kingPositionWhite().x + i, kingPositionWhite().y));
                  }
                }
                if (pieceCheck.getPosition().y > kingPositionWhite().y) {
                  for (int i = 1; i< pieceCheck.getPosition().y - kingPositionWhite().y; i++) {
                    MUC.add(new PVector(pieceCheck.getPosition().x, kingPositionWhite().y + i));
                  }
                }
                if (pieceCheck.getPosition().y < kingPositionWhite().y) {
                  for (int i = 1; i<  kingPositionWhite().y -pieceCheck.getPosition().y; i++) {
                    MUC.add(new PVector(pieceCheck.getPosition().x, pieceCheck.getPosition().y + i));
                  }
                }
              }
            }
          }
        }
      } 
      if (!pieceCheck.getTeam()) {
        if (board[(int)pieceSelection().x][(int)pieceSelection().y].getClass().getName() == "Chess$King") {
          MUC = board[(int)kingPositionBlack().x][(int)kingPositionBlack().y].possibleMovements();
        } else {
          MUC.add(pieceCheck.getPosition());
          if (pieceCheck.getClass().getName() == "Chess$Bishop" || pieceCheck.getClass().getName() == "Chess$Queen") {
            if (pieceCheck.getPosition().x < kingPositionBlack().x && pieceCheck.getPosition().y < kingPositionBlack().y) {
              for (int i = (int)pieceCheck.getPosition().x; i< kingPositionBlack().x; i++) {
                MUC.add(new PVector(pieceCheck.getPosition().x + i, pieceCheck.getPosition().y + i));
                verifyN = false;
              }
            }
            if (pieceCheck.getPosition().x < kingPositionBlack().x && pieceCheck.getPosition().y > kingPositionBlack().y) {
              for (int i = (int)pieceCheck.getPosition().x; i< kingPositionBlack().x; i++) {
                MUC.add(new PVector(pieceCheck.getPosition().x +i, pieceCheck.getPosition().y -i));
                verifyN = false;
              }
            }
            if (pieceCheck.getPosition().x > kingPositionBlack().x && pieceCheck.getPosition().y < kingPositionBlack().y) {
              for (int i = (int)kingPositionBlack().x; i <pieceCheck.getPosition().x; i++) {
                MUC.add(new PVector((int)kingPositionBlack().x + i, (int)kingPositionBlack().y - i));
                verifyN = false;
              }
            }

            if (pieceCheck.getPosition().x > kingPositionBlack().x && pieceCheck.getPosition().y > kingPositionBlack().y) {
              for (int i = (int)kingPositionBlack().x; i <pieceCheck.getPosition().x; i++) {
                MUC.add(new PVector((int)kingPositionBlack().x + i, (int)kingPositionBlack().y + i));
                verifyN = false;
              }
            }
          }
          if (verifyN) {
            if (pieceCheck.getClass().getName() == "Chess$Rock" || pieceCheck.getClass().getName() == "Chess$Queen") {
              if (pieceCheck.getPosition().x < kingPositionBlack().x) {
                for (int i = 1; i< kingPositionBlack().x - pieceCheck.getPosition().x; i++) {
                  MUC.add(new PVector(pieceCheck.getPosition().x + i, pieceCheck.getPosition().y));
                }
              }
              if (pieceCheck.getPosition().x > kingPositionBlack().x) {
                for (int i = 1; i< pieceCheck.getPosition().x - kingPositionBlack().x; i++) {
                  MUC.add(new PVector(kingPositionBlack().x + i, kingPositionBlack().y));
                }
              }
              if (pieceCheck.getPosition().y > kingPositionBlack().y) {
                for (int i = 1; i< pieceCheck.getPosition().y - kingPositionBlack().y; i++) {
                  MUC.add(new PVector(pieceCheck.getPosition().x, kingPositionBlack().y + i));
                }
              }
              if (pieceCheck.getPosition().y < kingPositionBlack().y) {
                for (int i = 1; i<  kingPositionBlack().y -pieceCheck.getPosition().y; i++) {
                  MUC.add(new PVector(pieceCheck.getPosition().x, pieceCheck.getPosition().y + i));
                }
              }
            }
          }
        }
      }
    }
    return MUC;
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

  public PVector kingPositionWhite() {
    PVector kingPosition = new PVector();
    for (int i = 0; i<64; i++) {
      if (board[i/8][i%8] != null) {
        if (board[i/8][i%8].getClass().getName() == "Chess$King" && !board[i/8][i%8].getTeam()) {
          kingPosition = new PVector(i/8, i%8);
        }
      }
    }
    return kingPosition;
  }

  public PVector kingPositionBlack() {
    PVector kingPosition = new PVector();
    for (int i = 0; i<64; i++) {
      if (board[i/8][i%8] != null) {
        if (board[i/8][i%8].getClass().getName() == "Chess$King" && board[i/8][i%8].getTeam()) {
          kingPosition = new PVector(i/8, i%8);
        }
      }
    }

    return kingPosition;
  }

  public boolean checkWhite() {
    boolean check = false;
    pieceCheck = null;

    for (int i = 0; i<64; i++) {
      if (board[i/8][i%8] != null) {
        if (board[i/8][i%8].getTeam()) {
          if (board[i/8][i%8].getClass().getName() != "Chess$Pawn") {
            if (board[i/8][i%8].possibleMovements().indexOf(kingPositionWhite()) != -1) {
              check = true;
              pieceCheck = board[i/8][i%8];
            }
          } else {
            if (kingPositionWhite().x != 7) {
              if (board[(int)kingPositionWhite().x + 1][(int)kingPositionWhite().y - 1] == board[i/8][i%8]) {
                check = true;
                pieceCheck = board[i/8][i%8];
              }
            }
            if (kingPositionWhite().x != 0) {
              if ( board[(int)kingPositionWhite().x - 1][(int)kingPositionWhite().y - 1] == board[i/8][i%8]) {
                check = true;
                pieceCheck = board[i/8][i%8];
              }
            }
          }
        }
      }
    }
    if (board[(int)kingPositionWhite().x][(int)kingPositionWhite().y].possibleMovements().size() != 0) {
      //println(board[(int)kingPositionWhite().x][(int)kingPositionWhite().y].possibleMovements().get(0).getClass());
    }
    ////println(pieceCheck);
    ////println("Blancas Jaque: " + check);
    return check;
  }

  public boolean checkBlack() {
    boolean check = false;

    for (int i = 0; i<64; i++) {
      if (board[i/8][i%8] != null) {
        if (!board[i/8][i%8].getTeam()) {
          if (board[i/8][i%8].getClass().getName() != "Chess$Pawn") {
            if (board[i/8][i%8].possibleMovements().indexOf(kingPositionBlack()) != -1) {
              check = true;
              pieceCheck = board[i/8][i%8];
            }
          } else {
            if (kingPositionBlack().x != 7) {
              if (board[(int)kingPositionBlack().x + 1][(int)kingPositionBlack().y + 1] == board[i/8][i%8]) {
                check = true;
                pieceCheck = board[i/8][i%8];
              }
            }
            if (kingPositionBlack().x != 0) {
              if ( board[(int)kingPositionBlack().x - 1][(int)kingPositionBlack().y + 1] == board[i/8][i%8]) {
                check = true;
                pieceCheck = board[i/8][i%8];
              }
            }
          }
        }
      }
    }
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
            pushMatrix();
            translate(width/2-size*4, (height/2-size*4));
            fill(255, (c*10)%255, 0);
            rect((i/8)*size, (i%8)*size, size, size);
            fill(0);
            //textSize(50);
            //text(c, (i)/8*size, (i)%8*size);
            popMatrix();
          }
        }
      }
    }
  }
  public PVector pieceSelection() {
    PVector p = new PVector(8, 8);
    for (int i = 0; i<64; i++) {
      if (board[i/8][i%8] != null) {
        if (board[i/8][i%8].getSelection()) {
          p = new PVector(board[i/8][i%8].getPosition().x, board[i/8][i%8].getPosition().y);
          pushMatrix();
          translate(width/2-size*4, (height/2-size*4));
          fill(0, 255, 0);
          rect((i/8)*size, (i%8)*size, size, size);
          popMatrix();
        }
      }
    }
    return p;
  }


  public void mouseClicked() {

    if (pieceSelection().x < 8 && pieceSelection().y < 8) {
      move();
      eat();
      //  deselect();
    }
    if (board[(int)mousePosition().x][(int)mousePosition().y] != null) {
      onlySelection();
      if (mouseX < size*8 + width/2 && mouseY < size*8 + height/2) { 
        turnManager();
      } 
      if (verify) {
        board[(int)mousePosition().x][(int)mousePosition().y].setSelection(false);
        verify=false;
      }
    }
  }

  public void mouseReleased() {
  };
}