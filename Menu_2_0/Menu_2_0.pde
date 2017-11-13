PVector botonJugar= new PVector(100, 50), botonComoJugar= new PVector(500, 500),botonAperturas= new PVector(700, 100);
int jbh=110, jbw=209, jv=2, cjbh=83, cjbw=216, cjv=3,abh=84, abw=238, av=4, nivel=0; 
float ts;
PImage[] jugar, comoJugar,aperturas;
ImButton butJug, butCJ,butAp;
void setup () {
  jugar = new PImage [] {loadImage("jugar1.png"), loadImage("jugar2.png"), loadImage("jugar3.png")};
  comoJugar = new PImage [] {loadImage("comojugar1.png"), loadImage("comojugar2.png"), loadImage("comojugar3.png")};
  aperturas = new PImage [] {loadImage("aperturas1.png"), loadImage("aperturas2.png"), loadImage("aperturas3.png")};
  size(1000, 600);
}
void draw() {
  butJug = new ImButton (botonJugar, jugar, jbh, jbw, jv);
  butCJ = new ImButton (botonComoJugar, comoJugar, cjbh, cjbw, cjv);
  butAp = new ImButton (botonAperturas, aperturas, abh, abw, av);
  background(50);
  butJug.cambio();
  butJug.draw();
  butCJ.cambio();
  butCJ.draw();
  butAp.cambio();
  butAp.draw();
  println(nivel);
  println(butJug.pressed);
}
void mouseReleased() {
  butJug.mouseReleased();
  butCJ.mouseReleased();
  butAp.mouseReleased();
}