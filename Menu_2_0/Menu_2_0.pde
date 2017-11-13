PVector botonJugar, botonComoJugar= new PVector(500, 500), botonAperturas= new PVector(700, 100);
int[] bw= new int []{209, 216, 238}, bh=new int[] {110, 83, 84}, value=new int[] {1, 2, 3};
int jbh=110, jbw=209, jv=2, cjbh=83, cjbw=216, cjv=3, abh=84, abw=238, av=4, nivel=0; 
float ts;
PImage[] jugar, comoJugar, aperturas;
ImButton[] butMP=new ImButton[3], butCJ, butAp;
void setup () {
  jugar = new PImage [] {loadImage("jugar1.png"), loadImage("jugar2.png"), loadImage("jugar3.png")};
  comoJugar = new PImage [] {loadImage("comojugar1.png"), loadImage("comojugar2.png"), loadImage("comojugar3.png")};
  aperturas = new PImage [] {loadImage("aperturas1.png"), loadImage("aperturas2.png"), loadImage("aperturas3.png")};
  size(500, 550);
}
void draw() {
  botonJugar = new PVector(width/2, height/6);
  botonComoJugar = new PVector((width/2)-(bw[1]/2)-10, 3*height/10);
  botonAperturas = new PVector((width/2)+(bw[2]/2)+10, 3*height/10);
  butMP[0] = new ImButton (botonJugar, jugar, bh[0], bw[0], value[0]);
  butMP[1] = new ImButton (botonComoJugar, comoJugar, bh[1], bw[1], value[1]);
  butMP[2] = new ImButton (botonAperturas, aperturas, bh[2], bw[2], value[2]);
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