PVector[] botonesMPPos=new PVector[5],botonesCJPos=new PVector[3];
int[] bwMP= new int []{209, 216, 238, 220, 204}, bhMP=new int[] {110, 83, 86, 76, 81}, valueMP=new int[] {1, 2, 3, 4, 5};
int[] bwCJ= new int []{190,190,190}, bhCJ=new int[] {65,65,65}, valueCJ=new int[] {6,7,8};
int nivel=0;
PImage[][] imagenesMP= new PImage[5][3], imagenesCJ = new PImage[3][3];
ImButton[] butMP = new ImButton[5], butCJ = new ImButton [3];

public void setupBotones() {
  //Inicializacion imagenes
  imagenesMP[0] = new PImage [] {loadImage("jugar1.png"), loadImage("jugar2.png"), loadImage("jugar3.png")};
  imagenesMP[1] = new PImage [] {loadImage("comojugar1.png"), loadImage("comojugar2.png"), loadImage("comojugar3.png")};
  imagenesMP[2] = new PImage [] {loadImage("aperturas1.png"), loadImage("aperturas2.png"), loadImage("aperturas3.png")};
  imagenesMP[3] = new PImage [] {loadImage("acertijos1.png"), loadImage("acertijos2.png"), loadImage("acertijos3.png")};
  imagenesMP[4] = new PImage [] {loadImage("creditos1.png"), loadImage("creditos2.png"), loadImage("creditos3.png")};
  imagenesCJ[0] = new PImage [] {loadImage("cjVersus1.png"), loadImage("cjVersus2.png"), loadImage("cjVersus3.png")};
  imagenesCJ[1] = new PImage [] {loadImage("cjAperturas1.png"), loadImage("cjAperturas2.png"), loadImage("cjAperturas3.png")};
  imagenesCJ[2] = new PImage [] {loadImage("cjAcertijos1.png"), loadImage("cjAcertijos2.png"), loadImage("cjAcertijos3.png")};

  //Inicializacion posiciones

  botonesMPPos[0] = new PVector(width/2, height/7);
  botonesMPPos[1] = new PVector((width/2)-110, 3*height/10);
  botonesMPPos[2] = new PVector((width/2)+130, (3*height/10)-1);
  botonesMPPos[3] = new PVector((width/2)-113, 14*height/30);
  botonesMPPos[4] = new PVector((width/2)+113, (14*height/30)-2);
  for (int i=0;i<botonesCJPos.length;i++){
    botonesCJPos[i] =new PVector((i+1)*width/4, 150);
  }

  //Inicializacion de los constructores
  for (int j=0; j<butMP.length; j++) {
    butMP[j] =new ImButton(botonesMPPos[j], imagenesMP[j], bhMP[j], bwMP[j], valueMP[j]);
  }
  for (int k=0; k<butCJ.length;k++){
    butCJ[k]=new ImButton (botonesCJPos[k], imagenesCJ[k], bhCJ[k], bwCJ[k], valueCJ[k]);
  }
}

void setup () {
  setupBotones();
  size(1000, 550);
}

void draw() {
  background(50);
  if (nivel==0) {
    for (int i=0; i<butMP.length; i++) {
      butMP[i].cambio();
      butMP[i].draw();
    }
  }
  if (nivel==2) {
    for (int j=0; j<butCJ.length; j++) {
      butCJ[j].cambio();
      butCJ[j].draw();
    }
  }
  println(nivel);
}

void mouseReleased() {
  if(nivel==0){
    for (int i=0; i<butMP.length; i++) {
      butMP[i].mouseReleased();
    }
  }
  if (nivel==2) {
    for (int j=0; j<butCJ.length; j++) {
      butCJ[j].mouseReleased();
    }
  }
}