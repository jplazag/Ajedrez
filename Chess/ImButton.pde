public class ImButton extends Button {
  protected PImage imag;
  protected PImage[] imagArray= new PImage[3];

  public PImage imagen() {
    return this.imag;
  }
  public void setImagen (PImage img) {
    imag=img;
  }
  public PImage[] imagArr() {
    return this.imagArray;
  }
  public void setImagArr (PImage[] imgAr) {
    imagArray=imgAr;
  }

  ImButton( PVector t, PImage[] img, int v, boolean l) {
    super(t, v, l);
    setImagArr(img);
  }

  public void imInicial() {
    this.imag=this.imagArray[2];
    setButtonHeight(imag.height);
    setButtonWidth(imag.width);
  }
  public void imCambio1() {
    this.imag=this.imagArray[1];
    setButtonHeight(imag.height);
    setButtonWidth(imag.width);
  }
  public void imCambio2() {
    this.imag=this.imagArray[0];
    setButtonHeight(imag.height);
    setButtonWidth(imag.width);
  }

  public void drawButton() {
    imageMode(CENTER);
    image(this.imag, this.translation.x, this.translation.y, this.BWidth, this.BHeight);
  }
}