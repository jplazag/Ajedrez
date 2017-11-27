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
          if (nivel==(20+j)) {
            instrucciones=(j*11);
          }
        }
        nivel=this.value;
      }
      if (lvl==1) {
        instrucciones+=this.value;
      }
      if (lvl==2) {
          if (a<lee.playsFEN.size()-1) {
            a+= this.value;
            if (0<=a && a < lee.playsFEN.size()) {
              board.setFEN(lee.playsFEN.get(a));
              board.reset();
              board.importFEN();
              board.turnIntoFEN(a);

              key = 0;
            }
          }
        }
      pressed=false;
    }
  }
}