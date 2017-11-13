PVector botonJugar, botonComoJugar, botonAperturas,botonAcertijos;
int[] bw= new int []{209, 216, 238,231}, bh=new int[] {110, 83, 84,72}, value=new int[] {1, 2, 3, 4};
int nivel=0; 
float ts;
PImage[] jugar, comoJugar, aperturas,acertijos;
ImButton[] butMP=new ImButton[4];
void setup () {
  jugar = new PImage [] {loadImage("jugar1.png"), loadImage("jugar2.png"), loadImage("jugar3.png")};
  comoJugar = new PImage [] {loadImage("comojugar1.png"), loadImage("comojugar2.png"), loadImage("comojugar3.png")};
  aperturas = new PImage [] {loadImage("aperturas1.png"), loadImage("aperturas2.png"), loadImage("aperturas3.png")};
  acertijos = new PImage [] {loadImage("acertijos1.png"), loadImage("acertijos2.png"), loadImage("acertijos3.png")};
  size(1000, 550);
}
void draw() {
  botonJugar = new PVector(width/2, height/6);
  botonComoJugar = new PVector((width/2)-(bw[1]/2)-10, 3*height/10);
  botonAperturas = new PVector((width/2)+(bw[2]/2)+10, 3*height/10);
  botonAcertijos = new PVector((width/2)-(bw[3]/2)+30, 13*height/30);
  butMP[0] = new ImButton (botonJugar, jugar, bh[0], bw[0], value[0]);
  butMP[1] = new ImButton (botonComoJugar, comoJugar, bh[1], bw[1], value[1]);
  butMP[2] = new ImButton (botonAperturas, aperturas, bh[2], bw[2], value[2]);
  butMP[3] = new ImButton (botonAcertijos, acertijos, bh[3], bw[3], value[3]);
  background(50);
  for (int i=0; i<butMP.length; i++) {
    butMP[i].cambio();
    butMP[i].draw();
  }
  println(nivel);
}
void mouseReleased() {
  for (int i=0; i<butMP.length; i++) {
    butMP[i].mouseReleased();
  }
}