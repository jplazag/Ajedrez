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

  ImButton( PVector t, PImage[] img, int bh, int bw, int v) {
    super(t, bh, bw, v);
    setImagArr(img);
  }

  public void imInicial() {
    this.imag=this.imagArray[2];
  }
  public void imCambio1() {
    this.imag=this.imagArray[1];
  }
  public void imCambio2() {
    this.imag=this.imagArray[0];
  }

  public void drawButton() {
    imageMode(CENTER);
    image(this.imag, this.translation.x, this.translation.y,this.BWidth,this.BHeight);
  }
}