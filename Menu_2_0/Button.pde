abstract class Button {
  protected PVector translation;
  protected int BWidth, BHeight, value;
  protected boolean pressed;

  protected int buttonValue() {
    return value;
  }
  protected void setButtonValue(int v) {
    value=v;
  }
  protected int ButtonWidth() {
    return BWidth;
  }
  protected void setButtonWidth(int bw) {
    BWidth=bw;
  }
  protected int ButtonHeight() {
    return BHeight;
  }
  protected void setButtonHeight(int bh) {
    BHeight=bh;
  }

  public PVector translation() {
    return translation;
  }
  public void setTranslation (PVector t) {
    translation =t;
  }
  Button(PVector t, int bh, int bw, int v) {
    setTranslation (t);
    setButtonHeight(bh);
    setButtonWidth(bw);
    setButtonValue(v);
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
    if (pressed==true) {
      nivel=this.value;
      pressed=false;
    }
  }
}