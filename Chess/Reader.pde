class Reader {

  String[] input;
  String rec = new String();
  int numPlay;
  ArrayList<String> plays = new ArrayList<String>();
  ArrayList<String> playsFEN = new ArrayList<String>();
  String[] lines;
  StringBuffer cadena = new StringBuffer();


  public Reader() {
  }

  public void setInput(String[] i) {
    this.input = i;
  }

  public ArrayList<String> getPlays() {
    return plays;
  }

  public String readFiles() {
    String s = new String();
    s = "";
    for (int x=10; x<input.length; x++) {
      s += input[x];
      s += " ";
    }
    s = s.substring(0, s.length()-2);
    s+="<";
    return s.toString();
  }
  public String readFilesFEN(String[] playFEN, int a) {
    lines = playFEN;
    cadena.append(lines[a]);
    return cadena.toString();
  }
  public void lector() {
    int index = 0;
    plays.clear();                                                           //ACAAAAAAAAAAAAAAAAAAAAA
    while (readFiles().charAt(index++) != '<') {

      if (readFiles().charAt(index) == ' ' || (readFiles().charAt(index) == '.' && readFiles().charAt(index + 1) != ' ' )) {
        do {
          index++;
          if (readFiles().charAt(index) != ' ' && readFiles().charAt(index) != '+' && readFiles().charAt(index) != '#')
            rec += readFiles().charAt(index);
        } while (readFiles().charAt(index) != ' ');
        plays.add(rec);
        rec = "";
        index++;
        if (Character.isDigit(readFiles().charAt(index)) ) {
          do {
            index++;
          } while (Character.isDigit(readFiles().charAt(index)));
          if (readFiles().charAt(index) == '.')
            index--;
        } else {
          index -= 2;
        }
      } 
      if ( readFiles().charAt(index) == '<') break;
    }
  }

  public void reproductor(int c) {

    if (c == 0) {
      playsFEN.add(board.turnIntoFEN(c));
    }
    String play = plays.get(c%plays.size());
    if (c%2==0) {
      switch(play.length()) {
      case 2: //Pawn
        PVector finb = new PVector();
        finb.x = conversor(play, 0);
        finb.y = 7-(((int) (play.charAt(1) - 48)) - 1);
        for (int x = 0; x < 64; x++) {
          if (board.board[x/8][x%8]!=null) {
            if (board.board[x/8][x%8].getClass().getName() == identificador(play, 0) && (board.board[x/8][x%8].possibleMovements().indexOf(finb) != -1) && board.board[x/8][x%8].getTeam() == false) {
              board.board[x/8][x%8] = null;
              board.board[(int)finb.x][(int)finb.y] = new Pawn(finb, false, loadImage("PeonB.png"));
            }
          }
        }
        break;

      case 3: 
        if (play.charAt(0) == 'O') {
          //println("holi");
          PVector ki1 = new PVector(6, 7);
          PVector To1 = new PVector(5, 7);          
          board.board[4][7] = null;
          board.board[7][7] = null;
          board.board[6][7] = new King(ki1, false, i[10]);
          board.board[5][7] = new Rock(To1, false, i[6]);
        } else {
          PVector fin2b = new PVector();
          fin2b.y = 7 - ((int) (play.charAt(2) - 48)-1);
          fin2b.x = conversor(play, 1);      
          for (int x = 0; x < 64; x++) {
            if (board.board[x/8][x%8]!=null) {
              if (board.board[x/8][x%8].getClass().getName() == identificador(play, 0) && (board.board[x/8][x%8].possibleMovements().indexOf(fin2b) != -1) && board.board[x/8][x%8].getTeam() == false) {
                board.board[x/8][x%8] = null;
                board.board[(int)fin2b.x][(int)fin2b.y] = nueva_pieza(play, 0, fin2b, false);
              }
            }
          }
        }
        break;

      case 4: //Captura  o movimiento ambiguo
        PVector fin3b = new PVector();
        fin3b.y = 7 - ((int) (play.charAt(3) - 48)-1);
        fin3b.x = conversor(play, 2);
        int n1 = 7 - ((int) (play.charAt(1) - 48)-1);

        if (play.charAt(1) == 'x') {  
          for (int x = 0; x < 64; x++) {
            if (board.board[x/8][x%8]!=null) {
              if (board.board[x/8][x%8].getClass().getName() == identificador(play, 0) && (board.board[x/8][x%8].possibleMovements().indexOf(fin3b) != -1) && board.board[x/8][x%8].getTeam() == false) {
                board.board[x/8][x%8] = null;
                board.board[(int)fin3b.x][(int)fin3b.y] = nueva_pieza(play, 0, fin3b, false);
              }
            }
          }
        } else if (conversor(play, 1) != -1) {
          //println("si " + conversor(play, 1));
          //println("2 " + fin3b);

          for (int i = 0; i < 8; i++) {
            if (board.board[conversor(play, 1)][i] !=null) {
              //println("i " + i);
              if (board.board[conversor(play, 1)][i].getClass().getName() == identificador(play, 0) && (board.board[conversor(play, 1)][i].possibleMovements().indexOf(fin3b) != -1) && board.board[conversor(play, 1)][i].getTeam() == false) {
                //println("i " + i);
                board.board[conversor(play, 1)][i] = null;
                board.board[(int)fin3b.x][(int)fin3b.y] = nueva_pieza(play, 0, fin3b, false);
              }
            }
          }
        } else if (Character.isDigit(play.charAt(1))) {
          for (int j = 0; j < 8; j++) {
            if (board.board[j][n1]!=null) {
              if (board.board[j][n1].getClass().getName() == identificador(play, 0) && (board.board[j][n1].possibleMovements().indexOf(fin3b) != -1) && board.board[j][n1].getTeam() == false) {
                board.board[j][n1] = null;
                board.board[(int)fin3b.x][(int)fin3b.y] = nueva_pieza(play, 0, fin3b, false);
              }
            }
          }
        }
      case 5:
        if (play.charAt(0) == 'O') {
          //println("holi");
          PVector ki3 = new PVector(2, 7);
          PVector To3 = new PVector(3, 7);          
          board.board[4][7] = null;
          board.board[0][7] = null;
          board.board[2][7] = new King(ki3, false, i[10]);
          board.board[3][7] = new Rock(To3, false, i[6]);
        }
        break;
      }
    }

    //    *******************************************************************
    if (c%2 == 1) {
      switch(play.length()) {
      case 2: //Pawn
        PVector finn = new PVector();
        finn.x = conversor(play, 0);
        finn.y = 7-(((int) (play.charAt(1) - 48)) - 1);

        for (int x = 0; x < 64; x++) {
          if (board.board[x/8][x%8]!=null) {
            if (board.board[x/8][x%8].getClass().getName() == identificador(play, 0) && (board.board[x/8][x%8].possibleMovements().indexOf(finn) != -1) && board.board[x/8][x%8].getTeam() == true) {
              board.board[x/8][x%8] = null;
              board.board[(int)finn.x][(int)finn.y] = new Pawn(finn, true, loadImage("PeonN.png"));
            }
          }
        }
        break;

      case 3:

        if (play.charAt(0) == 'O') {
          PVector ki2 = new PVector(6, 0);
          PVector To2 = new PVector(5, 0);
          board.board[4][0] = null;
          board.board[7][0] = null;
          board.board[6][0] = new King(ki2, true, i[11]);
          board.board[5][0] = new Rock(To2, true, i[7]);
        } else {
          PVector fin2n = new PVector();
          fin2n.y = 7 - ((int) (play.charAt(2) - 48)-1);
          fin2n.x = conversor(play, 1);      
          for (int x = 0; x < 64; x++) {
            if (board.board[x/8][x%8]!=null) {
              if (board.board[x/8][x%8].getClass().getName() == identificador(play, 0) && (board.board[x/8][x%8].possibleMovements().indexOf(fin2n) != -1) && board.board[x/8][x%8].getTeam() == true) {
                board.board[x/8][x%8] = null;
                board.board[(int)fin2n.x][(int)fin2n.y] = nueva_pieza(play, 0, fin2n, true);
              }
            }
          }
        }
        break;

      case 4: //Captura  o movimiento ambiguo
        PVector fin3n = new PVector();
        fin3n.y = 7 - ((int) (play.charAt(3) - 48)-1);
        fin3n.x = conversor(play, 2);
        int n2 = 7 - ((int) (play.charAt(1) - 48)-1);

        if (play.charAt(1) == 'x') {  
          for (int x = 0; x < 64; x++) {
            if (board.board[x/8][x%8]!=null) {
              if (board.board[x/8][x%8].getClass().getName() == identificador(play, 0) && (board.board[x/8][x%8].possibleMovements().indexOf(fin3n) != -1) && board.board[x/8][x%8].getTeam() == true) {
                board.board[x/8][x%8] = null;
                board.board[(int)fin3n.x][(int)fin3n.y] = nueva_pieza(play, 0, fin3n, true);
              }
            }
          }
        } else if (conversor(play, 1) != -1) {
          //println("si " + conversor(play, 1));
          for (int i = 0; i < 8; i++) {

            if (board.board[conversor(play, 1)][i] != null) {

              //println("i " + i + board.board[conversor(play, 1)][i].getClass().getName() + board.board[conversor(play, 1)][i].getTeam());
              if (board.board[conversor(play, 1)][i].getClass().getName() == identificador(play, 0) && (board.board[conversor(play, 1)][i].possibleMovements().indexOf(fin3n) != -1) && board.board[conversor(play, 1)][i].getTeam() == true) {
                board.board[conversor(play, 1)][i] = null;
                board.board[(int)fin3n.x][(int)fin3n.y] = nueva_pieza(play, 0, fin3n, true);
              }
            }
          }
        } else if (Character.isDigit(play.charAt(1))) {
          for (int j = 0; j < 8; j++) {
            if (board.board[j][n2]!=null) {
              if (board.board[j][n2].getClass().getName() == identificador(play, 0) && (board.board[j][n2].possibleMovements().indexOf(fin3n) != -1) && board.board[j][n2].getTeam() == true) {
                board.board[j][n2] = null;
                board.board[(int)fin3n.x][(int)fin3n.y] = nueva_pieza(play, 0, fin3n, true);
              }
            }
          }
        }
        break;
      case 5:
        if (play.charAt(0) == 'O') {
          PVector ki4 = new PVector(2, 0);
          PVector To4 = new PVector(3, 0);
          board.board[4][0] = null;
          board.board[0][0] = null;
          board.board[2][0] = new King(ki4, true, i[11]);
          board.board[3][0] = new Rock(To4, true, i[7]);
        }      
        break;
      }
    }
    playsFEN.add(board.turnIntoFEN(c));
  }

  public void reproductorFEN(Board object, String match) {
    //if (a < match.size() && a >= 0)
    object.setFEN(match);
    object.reset();
    object.importFEN();
  }

  public int conversor(String p, int index) {
    int i = 0;
    switch(p.charAt(index)) {
    case 'a':
      i = 0;
      break;
    case 'b':
      i = 1;
      break;
    case 'c':
      i = 2;
      break;
    case 'd':
      i = 3;
      break;
    case 'e':
      i = 4;
      break;
    case 'f':
      i = 5;
      break;
    case 'g':
      i = 6;
      break;
    case 'h':
      i = 7;
      break;
    default:
      i = -1;
      break;
    }
    return i;
  }


  public String identificador(String p, int index) {
    String pieza = new String();
    switch(p.charAt(index)) {
    case 'R':
      pieza = "Chess$Rock";
      break;
    case 'N':
      pieza = "Chess$Knight";
      break;
    case 'B':
      pieza = "Chess$Bishop";
      break;
    case 'Q':
      pieza = "Chess$Queen";
      break;
    case 'K':
      pieza = "Chess$King";
      break;
    default :
      pieza = "Chess$Pawn";
      break;
    }
    return pieza;
  }

  public Piece nueva_pieza(String p, int index, PVector positionf, boolean team) {
    Piece object = null;
    if (team==false) {
      switch(p.charAt(index)) {
      case 'B':
        object = new Bishop(positionf, team, i[2]);
        break;
      case 'N':
        object = new Knight(positionf, team, i[4]);
        break;
      case 'R':
        object = new Rock(positionf, team, i[6]);
        break;
      case 'Q':
        object = new Queen(positionf, team, i[8]);
        break;
      case 'K':
        object = new King(positionf, team, i[10]);
        break;
      default :
        object = new Pawn(positionf, team, i[0]);
        break;
      }
    } else if (team==true) {
      switch(p.charAt(index)) {
      case 'B':
        object = new Bishop(positionf, team, i[3]);
        break;
      case 'N':
        object = new Knight(positionf, team, i[5]);
        break;
      case 'R':
        object = new Rock(positionf, team, i[7]);
        break;
      case 'Q':
        object = new Queen(positionf, team, i[9]);
        break;
      case 'K':
        object = new King(positionf, team, i[11]);
        break;
      default :
        object = new Pawn(positionf, team, i[1]);
        break;
      }
    }
    return object;
  }
}