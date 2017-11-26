public class ColButton extends Button {
  protected String buttonTxt=""; 
  protected float txtscl=1;
  protected color c, txtc;
  protected color[] colorArray= new color[3];

  protected float textscale() {
    return this.txtscl;
  }
  protected void setTextscale(float ts) {
    this.txtscl=ts;
  }
  protected String buttonText() {
    return this.buttonTxt;
  }
  protected void setbuttonText(String tx) {
    this.buttonTxt=tx;
  }
  public color col() {
    return this.c;
  }
  public void setColor (color col) {
    this.c=col;
  }
  public color txtcol() {
    return this.txtc;
  }
  public void setTextColor (color txtcol) {
    this.txtc=txtcol;
  }
  public color[] colArr() {
    return this.colorArray;
  }
  public void setColorArr (color[] colAr) {
    this.colorArray=colAr;
  }

  ColButton(PVector t, color[] col, color txtcol, String tx, int bh, int bw, int v, float ts, boolean l) {
    super(t, v, l);
    setColorArr (col);
    setbuttonText(tx);
    setTextscale(ts);
    setTextColor(txtcol);
    setButtonHeight(bh);
    setButtonWidth(bw);
  }
  public void imInicial() {
    this.c=this.colorArray[2];
  }
  public void imCambio1() {
    this.c=this.colorArray[1];
  }
  public void imCambio2() {
    this.c=this.colorArray[0];
  }

  public void drawButton() {
    fill(this.c);
    rectMode(CENTER);
    textAlign(CENTER, CENTER);

    rect(this.translation.x, this.translation.y, this.BWidth, this.BHeight);
    fill(this.txtc);
    textSize(txtscl*20);
    text(this.buttonTxt, this.translation.x, this.translation.y);
  }
}