abstract class Button {
  protected PVector translation;
  protected int BWidth, BHeight, value;
  protected boolean pressed;
  protected int lvl;

  protected int getButtonValue() {
    return value;
  }
  protected void setButtonValue(int v) {
    value=v;
  }
  protected int getButtonWidth() {
    return BWidth;
  }
  protected void setButtonWidth(int bw) {
    BWidth=bw;
  }
  protected int getButtonHeight() {
    return BHeight;
  }
  protected void setButtonHeight(int bh) {
    BHeight=bh;
  }

  public PVector getTranslation() {
    return translation;
  }
  public void setTranslation (PVector t) {
    translation =t;
  }
  public  int getLevl() {
    return lvl;
  }
  public  void setLevl(int l) {
    lvl=l;
  }
  Button(PVector t, int v, int l) {
    setTranslation (t);
    setButtonValue(v);
    setLevl(l);
  }
  abstract void drawButton();
  abstract void imInicial();
  abstract void imCambio1();
  abstract void imCambio2();

  public void cambio() {
    if (mouseX<(this.translation.x+(this.BWidth/2))&& mouseX>(this.translation.x-(this.BWidth/2))&&mouseY<(this.translation.y+(this.BHeight/2))&& mouseY>(this.translation.y-(this.BHeight/2))) {
      if (mousePressed) {
        imInicial();
        this.pressed=true;
      } else { 
        imCambio1();
      }
    } else {
      imCambio2();
    }
  }
  protected void draw() {
    pushStyle();
    pushMatrix();
    drawButton();
    popStyle();
    popMatrix();
  }
  public void mouseReleased() {
    if (this.pressed==true) {
      if (lvl==0) {
        for (int j=1; j<4; j++) {
          if (this.value==(20+j)) {
            instrucciones=(j*11);
          }
        }
        nivel=this.value;
      }
      if (lvl==1) {
        instrucciones+=this.value;
      }
      if (lvl==2) {
        if (inicio < aperturas.plays.size()) {

          for (int x = 0; x < aperturas.plays.size(); x++) {
            aperturas.reproductor(x);
          }
          board.reset();
          board.importFEN();
        }
        //aperturas.setInput(loadStrings(partida));
        aperturas.lector();

        if (lecFEN<aperturas.playsFEN.size()-1) {
          lecFEN+=this.value;
          if (0<=lecFEN && lecFEN < aperturas.playsFEN.size()) {
            board.setFEN(aperturas.playsFEN.get(lecFEN));
            board.reset();
            board.importFEN();
            board.turnIntoFEN(lecFEN);
          }
        }
      }
      if (lvl==3) {
        solAc=this.value;
      }
      if(lvl==4){
        nivel=this.value;
        conAcertijo=this.value;
        board.setFEN(posicion_inicial(conAcertijo-40));
        board.reset();
        board.importFEN();
        println(conAcertijo);
        println(posicion_inicial(conAcertijo-40));
        //if (inicio < aperturas.plays.size()) {

        //  for (int x = 0; x < aperturas.plays.size(); x++) {
        //    aperturas.reproductor(x);
        //  }
        //  board.reset();
        //  board.importFEN();
        //}
        ////aperturas.setInput(loadStrings(partida));
        //aperturas.lector();

        //if (lecFEN <aperturas.playsFEN.size()-1) {
        //  lecFEN+=this.value;
        //  if (0<=lecFEN && lecFEN < aperturas.playsFEN.size()) {
        //    board.setFEN(aperturas.playsFEN.get(lecFEN));
        //    board.reset();
        //    board.importFEN();
        //    board.turnIntoFEN(lecFEN);
        //  }
        //}
      }
      if(lvl==5){
        nivel=this.value;
        solAc=0;  lecFEN=-1;
        aperturas.playsFEN.clear();
        board.setFEN(posicion_inicial(conAcertijo-40));
        board.reset();
        board.importFEN();
        println("holi");
      }
      pressed=false;
    }
  }
}