class Board {
  Piece[][] w = new Piece[8][8];
  int size;
  int turn = 1;
  Board (Piece[][] a, int s) {
    w = a;
    size = s;
  }

  public int getSize() {
    return size;
  }

  public void display () {
    for (int i = 0; i < 64; i ++) {
      if (w[i/8][i%8] != null) {
        w[i/8][i%8].drawPiece(size);
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
            //fill(255, 0, 0);
            //rect((i/8)*size, (i%8)*size, size, size);
          }
        }
      }
    }
  }

  public PVector pieceSelection() {
    PVector p = new PVector(8, 8);
    for (int i = 0; i<64; i++) {
      if (w[i/8][i%8] != null) {
        if (w[i/8][i%8].getSelection() == true) {
          p = new PVector(w[i/8][i%8].getPosition().x, w[i/8][i%8].getPosition().y);
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
    int x=0 ;
    int y=0;
    boolean verify = false;
    if (pieceSelection().x < 8 && pieceSelection().y < 8) {
      if (  (w[(int)mousePosition().x][(int)mousePosition().y] == null) && (pieceSelection() != null) && (w[(int)pieceSelection().x][(int)pieceSelection().y].possibleMovements().indexOf(mousePosition()) != -1)) {
        w[(int)mousePosition().x][(int)mousePosition().y] = w[(int)pieceSelection().x][(int)pieceSelection().y];
        w[(int)pieceSelection().x][(int)pieceSelection().y] = null;
        w[(int)mousePosition().x][(int)mousePosition().y].setPosition(new PVector(mousePosition().x, mousePosition().y));
        x = (int)mousePosition().x;
        y = (int)mousePosition().y;
        verify =true;
        turn += 1;
      } else {
        if (w[(int)mousePosition().x][(int)mousePosition().y] != null && w[(int)pieceSelection().x][(int)pieceSelection().y].getClass().getName() != "Chess$Pawn") {
          if ((w[(int)pieceSelection().x][(int)pieceSelection().y].getTeam() != w[(int)mousePosition().x][(int)mousePosition().y].getTeam()) && (w[(int)pieceSelection().x][(int)pieceSelection().y].possibleMovements().indexOf(mousePosition()) != -1)) {
            w[(int)mousePosition().x][(int)mousePosition().y] = w[(int)pieceSelection().x][(int)pieceSelection().y];
            w[(int)pieceSelection().x][(int)pieceSelection().y] = null;
            w[(int)mousePosition().x][(int)mousePosition().y].setPosition(new PVector(mousePosition().x, mousePosition().y));
            x = (int)mousePosition().x;
            y = (int)mousePosition().y;
            verify =true;
            turn += 1;
          }
        }
        if ((w[(int)pieceSelection().x][(int)pieceSelection().y].possibleMovements().indexOf(mousePosition()) == -1)) {
          w[(int)pieceSelection().x][(int)pieceSelection().y].setSelection(false);
        }
      }
    }

    if (w[(int)mousePosition().x][(int)mousePosition().y] != null) {
      for (int i = 0; i<64; i++) {
        if (((i/8) != (int)mousePosition().x  || (i%8) !=(int)mousePosition().y) && w[i/8][i%8] != null) {
          w[i/8][i%8].setSelection(false);
        }
      }
      if (mouseX < size*8 && mouseY < size*8) { 
        if (turn % 2 != 0) {
          if (!w[(int)mousePosition().x][(int)mousePosition().y].getTeam()) {
            w[(int)mousePosition().x][(int)mousePosition().y].setSelection(true);
          }
        } else {
          if (w[(int)mousePosition().x][(int)mousePosition().y].getTeam()) {
            w[(int)mousePosition().x][(int)mousePosition().y].setSelection(true);
          }
        }
      } 
      if (verify) {
        w[x][y].setSelection(false);
        verify=false;
      }
    }
  }
}