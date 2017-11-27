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

  ColButton(PVector t, color[] col, color txtcol, String tx, int bh, int bw, int v, float ts, int l) {
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
  public void borrar() {
    if (this.pressed) {
      board.reset();
      board.importFEN();
    }
  }
  public void borrar1() {
    if (this.pressed) {
      board.reset();
      board.setFEN(posicion_inicial());
      board.importFEN();
    }
  }
  public void espacio(String l) {
    if (this.pressed) {
      lee.setInput(loadStrings(l));
      lee.lector();
      for (int x = 0; x <lee.plays.size(); x++) {
        println(x + " " + lee.plays.get(x));
      }
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
  }
}