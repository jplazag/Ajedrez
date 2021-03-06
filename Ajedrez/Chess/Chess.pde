import ddf.minim.*;
import processing.video.*;
AudioPlayer m;
AudioPlayer  error;

Minim minim;

int conAcertijo=0;
Movie myMovie;

PImage[] i = new PImage[12];
PImage whiteSq, blackSq;
ArrayList<PVector> posible;
String b;
int  inicio=0, lecFEN = -1, solAc=0;
Reader aperturas = new Reader();
Reader match = new Reader();

Board board;
//Board elegido;
boolean selection = false, prom;

String[] lines, nombres= new String[4];
String posicion_inicial(int x) {

  lines = loadStrings("ejerciciosFEN.txt");

  return lines[x].toString();
}
StringBuffer cadena = new StringBuffer();

PrintWriter output;


int cambioPartida = 0, cambioPartidaAcertijo=0;

//******************************Menu
//Inicialización de posicion botones
PVector[] botonesMPPos = new PVector[5], botonesCJPos = new PVector[3], botonesMAPos=new PVector[9], botonesMNPos=new PVector[9], botonesArrPos= new PVector[3], botonesfPos= new PVector[3], promotionPos=new PVector[4];
PVector botonGBPos, flechaIzq, flechaDer, botonGBAPos, botonGBPPos, botonesSolAcPos;
//Contador de nivel y instrucciones
int nivel=0, instrucciones=0, promo;

//Valores para los botones
int[] valueMP = new int[] {1, 2, 3, 4, 5}, valueCJ=new int[] {21, 22, 23}, valueAA=new int[]{41, 42, 43, 44, 45, 46, 47, 48, 49}, valueAP=new int[] {31, 32, 33, 34, 35, 36, 37, 38, 39};
//Colores generales para botones
color[] colorGeneral = new color[3];
color[][] colorBoton = new color[3][3];
//inicialización imagenes
PImage[][] imagenesMP = new PImage[5][3], imagenesCJ = new PImage[3][3];
PImage [] leftArrow, rigthArrow;
PImage cursor, qr;

PFont fuente;


//Ctrl + z
boolean entrada = true;

//Inicializacion Botones
Movie videoP, videoA_C, videoD_T, videoE, videoObj, videoRey, videoAp;

ImButton[] butMP = new ImButton[5], butCJ = new ImButton [3], butArrows= new ImButton [2], flechita= new ImButton [2];
ColButton[] butMA=new ColButton[9], butMN=new ColButton[9], promotion= new ColButton[4];
ColButton butGB, butGBA, butGBP, butSolAc;

public void setupBotones() {

  nombres= new String[]{"Dama", "Caballo", "Alfil", "Torre"};
  //Inicializacion imagenes y colores
  imagenesMP[0] = new PImage [] {loadImage("jugar1.png"), loadImage("jugar2.png"), loadImage("jugar3.png")};
  imagenesMP[1] = new PImage [] {loadImage("comojugar1.png"), loadImage("comojugar2.png"), loadImage("comojugar3.png")};
  imagenesMP[2] = new PImage [] {loadImage("aperturas1.png"), loadImage("aperturas2.png"), loadImage("aperturas3.png")};
  imagenesMP[3] = new PImage [] {loadImage("acertijos1.png"), loadImage("acertijos2.png"), loadImage("acertijos3.png")};
  imagenesMP[4] = new PImage [] {loadImage("creditos1.png"), loadImage("creditos2.png"), loadImage("creditos3.png")};
  imagenesCJ[0] = new PImage [] {loadImage("cjVersus1.png"), loadImage("cjVersus2.png"), loadImage("cjVersus3.png")};
  imagenesCJ[1] = new PImage [] {loadImage("cjAperturas1.png"), loadImage("cjAperturas2.png"), loadImage("cjAperturas3.png")};
  imagenesCJ[2] = new PImage [] {loadImage("cjAcertijos1.png"), loadImage("cjAcertijos2.png"), loadImage("cjAcertijos3.png")};
  leftArrow = new PImage [] {loadImage("leftArrow1.png"), loadImage("leftArrow2.png"), loadImage("leftArrow3.png")};
  rigthArrow = new PImage [] {loadImage("rigthArrow1.png"), loadImage("rigthArrow2.png"), loadImage("rigthArrow3.png")};  
  colorBoton[0] = new color[]{color(200), color(190), color(210)};
  colorBoton[1] = new color[]{color(150), color(140), color(160)};
  colorBoton[2] = new color[]{color(100), color(90), color(110)};
  colorGeneral = new color[]{color(200), color(190), color(210)};
  cursor= loadImage("cursor.png");
  qr=loadImage("codigo.png");

  //Inicializacion posiciones

  botonesMPPos[0] = new PVector(width/2, height/7);
  botonesMPPos[1] = new PVector((width/2)-130, 3*height/10);
  botonesMPPos[2] = new PVector((width/2)+130, (3*height/10)-5);
  botonesMPPos[3] = new PVector((width/2)-130, 27*height/60);
  botonesMPPos[4] = new PVector((width/2)+115, (27*height/60)-4);

  botonesArrPos[0]= new PVector(2*width/5, 9*height/10);
  botonesArrPos[1]= new PVector(3*width/5, 9*height/10);
  botonesfPos[0]= new PVector((width*7/8)-50, (height*7/8)-100);
  botonesfPos[1]= new PVector((width*7/8)+50, (height*7/8)-100);
  botonesSolAcPos=new PVector((width*7/8), (height*7/8)-100);

  for (int i=0; i<botonesCJPos.length; i++) {
    botonesCJPos[i] =new PVector((i+1)*width/4, 150);
  }
  for (int i=0; i<promotionPos.length; i++) {
    promotionPos[i] =new PVector((4*(i+2)*width/25)-30, 150);
  }
  for (int j=0; j<3; j++) {
    for (int i=(j*3); i<(j*3)+3; i++) {
      botonesMAPos[i]=new PVector((width*(i+(1-(j*3)))/3)-300, (height/7)+(150+(100*j)));
    }
  }
  for (int j=0; j<3; j++) {
    for (int i=(j*3); i<(j*3)+3; i++) {
      botonesMNPos[i]=new PVector((width*(i+(1-(j*3)))/3)-300, (height/7)+(150+(100*j)));
    }
  }
  botonGBPos = new PVector((width*7/8), (height*7/8));
  flechaIzq = new PVector((width*7/8)-50, (height*7/8)-100);
  flechaDer = new PVector((width*7/8)+50, (height*7/8)-100);
  botonGBAPos = new PVector((width*7/8), (height*7/8));
  botonGBPPos= new PVector((width*7/8), (height*7/8));

  //Inicializacion de los constructores
  for (int j=0; j<butMP.length; j++) {
    butMP[j] =new ImButton(botonesMPPos[j], imagenesMP[j], valueMP[j], 0);
  }
  for (int k=0; k<butCJ.length; k++) {
    butCJ[k]=new ImButton (botonesCJPos[k], imagenesCJ[k], valueCJ[k], 0);
  }
  for (int j=0; j<3; j++) {
    for (int i=(j*3); i<(j*3)+3; i++) {
      butMN[i] = new ColButton (botonesMNPos[i], colorBoton[j], color(0), "Apertura "+(i+1), 70, 200, valueAP[i], 1f, 0);
    }
  }
  for (int j=0; j<3; j++) {
    for (int i=(j*3); i<(j*3)+3; i++) {
      butMA[i] = new ColButton (botonesMAPos[i], colorBoton[j], color(0), "Acertijo "+(i+1), 70, 200, valueAA[i], 1f, 4);
    }
  }
  for (int j=0; j<promotion.length; j++) {
    promotion[j] = new ColButton(promotionPos[j], colorGeneral, color(0), nombres[j], 70, 200, valueMP[j], 1f, 6);
  }

  butArrows[0]= new ImButton (botonesArrPos[0], leftArrow, -1, 1);
  butArrows[1]= new ImButton (botonesArrPos[1], rigthArrow, 1, 1);
  flechita[0]= new ImButton (botonesfPos[0], leftArrow, -1, 2);
  flechita[1]= new ImButton (botonesfPos[1], rigthArrow, 1, 2);
  butGB= new ColButton (botonGBPos, colorGeneral, color(0), "Menú principal", 70, 200, 0, 1f, 0);
  butGBP= new ColButton (botonGBAPos, colorGeneral, color(0), "Aperturas", 70, 200, 3, 1f, 0);
  butGBA= new ColButton (botonGBAPos, colorGeneral, color(0), "Acertijos", 70, 200, 4, 1f, 5);
  butSolAc=new ColButton (botonesSolAcPos, colorGeneral, color(0), "solución", 60, 180, 1, 1f, 3);
}

void setup() {

  //fullScreen();
  size(1000, 1000);
  //myMovie = new Movie(this, "animacion.mp4");
  //myMovie.play();
  frameRate(100);
  minim = new Minim(this);
  m = minim.loadFile("aaa.wav");
  error = minim.loadFile("error.mp3");
  setupBotones();
  b = posicion_inicial(0);
  i[0] = loadImage("PeonB.png");
  i[1] = loadImage("PeonN.png");
  i[2] = loadImage("AlfilB.png");
  i[3] = loadImage("AlfilN.png");
  i[4] = loadImage("CaballoB.png");
  i[5] = loadImage("CaballoN.png");
  i[6] = loadImage("TorreB.png");
  i[7] = loadImage("TorreN.png");
  i[8] = loadImage("ReinaB.png");
  i[9] = loadImage("ReinaN.png");
  i[10] = loadImage("ReyB.png");
  i[11] = loadImage("ReyN.png");
  whiteSq=loadImage("cuadro_Blanco.png");
  blackSq=loadImage("cuadro_Negro.png");
  board = new Board(b, 90);
  board.importFEN();
  //elegido = new Board(b, 90);
  //elegido.importFEN();
  board.turnIntoFEN(0);
  videoP=new Movie(this, "Peon.mp4");//
  videoA_C=new Movie(this, "Caballo-Alfil.mp4");//
  videoD_T=new Movie(this, "Reina-Torre.mp4");//
  videoE=new Movie(this, "Enroque.mp4");//
  videoObj=new Movie(this, "Objetivo.mp4");//
  videoRey=new Movie(this, "Rey.mp4");
  videoAp=new Movie(this, "aperturas.mp4");
}

void mouseReleased() {
  board.mouseReleased();
  //separación

  switch(nivel) {
  case 0:
    for (int i=0; i<butMP.length; i++) {
      butMP[i].mouseReleased();
    }
    break;
  case 1:
    butGB.mouseReleased();
    for (int j=0; j<promotion.length; j++) {
      promotion[j].mouseReleased();
    }
    break;
  case 2:
    for (int j=0; j<butCJ.length; j++) {
      butCJ[j].mouseReleased();
    }
    butGB.mouseReleased();
    break;
  case 3:
    for (int i=0; i<butMN.length; i++) { 
      if (butMN[i].pressed) {
        cambioPartida=i;
      }
      butMN[i].mouseReleased();
    }
  case 4:
    for (int i=0; i<butMA.length; i++) {
      butMA[i].mouseReleased();
    }
    butGB.mouseReleased();
    break;
  case 5:
    butGB.mouseReleased();
    break;
  }
  if (nivel==21||nivel==22||nivel==23) {
    for (int j=0; j<butCJ.length; j++) {
      butCJ[j].mouseReleased();
    }
    butGB.mouseReleased();
    butArrows[0].mouseReleased();
    butArrows[1].mouseReleased();
  }
  for (int i=31; i<40; i++) {
    if (nivel==i) {
      flechita[0].mouseReleased();
      flechita[1].mouseReleased();
      if (butGBP.pressed==true) {
        lecFEN=-1;
        aperturas.playsFEN.clear();
        board.setFEN(posicion_inicial(0));
        board.reset();
        board.importFEN();
      }
      butGBP.mouseReleased();
    }
  }
  for (int i=41; i<50; i++) {
    for (int j=0; i<butMA.length; i++) {
      butMA[j].mouseReleased();
    }
    /*if (nivel==i||nivel==4) {
     if (butGBA.pressed) {
     solAc=0;  
     lecFEN=-1;
     //aperturas.playsFEN.clear();
     board.setFEN(posicion_inicial(conAcertijo-40));
     board.reset();
     board.importFEN();
     }
     }*/
    if (nivel==i) {
      butGBA.mouseReleased();
      butSolAc.mouseReleased();
      if (solAc==0) {
        butSolAc.mouseReleased();
      }
      if (solAc==1) {
        if (lecFEN!=-1) {
          flechita[0].mouseReleased();
        }
        flechita[1].mouseReleased();
      }
    }
  }
}
void mouseClicked() {
  board.mouseClicked();
  //println(board.turn);
}


void draw() {
  if (keyPressed && key == 'v') {
    if ((board.numJugada) > 0) {
      println("board.numJugada " + board.numJugada);
      board.numJugada--;
      println("board.numJugada " + board.numJugada);
      match.reproductorFEN(board, board.matchPlayed.get(board.numJugada));

      for (int x = board.matchPlayed.size()-1; x >= board.numJugada; x--) {
        board.matchPlayed.remove(x);
        //save(board.matchPlayed);
      }
      save(board.matchPlayed);
      for (int x = 0; x < board.matchPlayed.size(); x++) {
        println(x + " " + board.matchPlayed.get(x));
      }
      println("holi");
    }
    key = 0;
  }

  if (keyPressed && key == 'a') {
    match.setInput(loadStrings("position.txt"));
    board.matchPlayed.clear();
    for (int x = 0; x < match.input.length; x++) {
      board.matchPlayed.add(match.input[x]);
    }
    board.numJugada = board.matchPlayed.size() - 1;
    match.reproductorFEN(board, board.matchPlayed.get(board.numJugada));
    for (int x = 0; x < board.matchPlayed.size(); x++) {
      println(x + " " + board.matchPlayed.get(x));
    }
    println(board.numJugada);
    key = 0;
    //println(cambioPartida);
  }
  //println(promo);
  background(250);

  /*pushStyle();
   pushMatrix();
   background(250);
   imageMode(CORNERS);
   tint(128, 128, 128);
   if (myMovie.time() < myMovie.duration()) {
   image(myMovie, 0, 0, width, height);
   }
   popMatrix();
   popStyle();*/

  textFont(loadFont("OCRAExtended-48.vlw"));
  //println(conAcertijo);
  //println(promo);
  switch(nivel) {
  case 0:
    for (int i=0; i<butMP.length; i++) {
      butMP[i].cambio();
      butMP[i].draw();
    }
    break;
  case 1:
    butGB.cambio();
    butGB.draw();
    board.cuadricula();
    board.pieceSelection();
    //if (board.board[(int)board.mousePosition().x][(int)board.mousePosition().y] != null) {
    //  board.PM(/*board.board[(int)board.mousePosition().x][(int)board.mousePosition().y].possibleMovements()*/ board.MovementsWhite(), !board.board[(int)board.mousePosition().x][(int)board.mousePosition().y].getTeam());
    //}
    if (board.board[(int)board.mousePosition().x][(int)board.mousePosition().y] != null) {
      board.PM(board.board[(int)board.mousePosition().x][(int)board.mousePosition().y].possibleMovements() /*board.MovementsBlack()*/, board.board[(int)board.mousePosition().x][(int)board.mousePosition().y].getSelection());
    }
    board.checkBlack();
    board.checkWhite();
    board.display();
    board.mousePosition();
    board.promotion();
    if (prom) {      
      for (int j=0; j<promotion.length; j++) {
        promotion[j].draw();
        promotion[j].cambio();
      }
    }
    //println(prom);
    break;
  case 2:
    for (int j=0; j<butCJ.length; j++) {
      butCJ[j].cambio();
      butCJ[j].draw();
    }
    butGB.cambio();
    butGB.draw();
    break;
  case 3:
    for (int i=0; i<butMN.length; i++) {
      butMN[i].cambio();
      butMN[i].draw();
      butGB.cambio();
      butGB.draw();
    }
    break;
  case 4:
    for (int i=0; i<butMA.length; i++) {
      butMA[i].cambio();
      butMA[i].draw();
      butGB.cambio();
      butGB.draw();
    }
    break;
  case 5:
    textSize(38);
    textAlign(CENTER, CENTER);
    fill(120);
    text("Créditos", width/2, height/10);
    textSize(28);
    textAlign(LEFT);
    text("Hecho por:\nJuan David Bello Rodriguez \nJuan Pablo Duque Escobar\nAndrés Felipe Medina Ealo\nKaren Nicole Mora Quiroz\nGiovanni Andrés Paez Ujueta\nJuan Diego Plaza Goméz", width/5, height/4+90);
    butGB.cambio();
    butGB.draw();
    text("Referencias:", 7*width/12, height*1/2-150);
    image(qr, 7*width/12, height*1/2-100);
    break;
  }

  if (nivel==21||nivel==22||nivel==23) {
    for (int j=0; j<butCJ.length; j++) {
      butCJ[j].cambio();
      butCJ[j].draw();
    }
    butGB.cambio();
    butGB.draw();
    if (instrucciones!=0) {
      if (instrucciones%11!=0) {
        butArrows[0].cambio();
        butArrows[0].draw();
      }
      if (instrucciones!=17 && instrucciones!=22 && instrucciones!=33) {
        butArrows[1].cambio();
        butArrows[1].draw();
      }
    }
    if (instrucciones!=0) {
      pushMatrix();
      pushStyle();
      rectMode(CENTER);
      fill(150, 150, 150, 50);
      rect(width/2, (height/2)+30, 1200, 400, 7);
      tint(255, 23);
      popStyle();
      popMatrix();
    }
    pushMatrix();
    pushStyle();
    textSize(16);
    fill(50);
    textAlign(LEFT);

    switch(instrucciones) {
    case 11:
      textSize(30);
      text("Objetivos:", width/12, (height/3)+25);      
      textSize(16);
      text("La partida de ajedrez se juega entre dos adversarios que mueven\nalternativamente sus propias piezas sobre un tablero cuadrado, llamado\n'tablero de ajedrez'. El jugador con las piezas blancas comienza la\npartida. Se dice que un jugador 'está en juego' cuando se ha realizado la\njugada de su adversario. El objetivo de cada jugador es situar al rey de\nsu adversario 'bajo ataque', de tal forma que el adversario no disponga\nde ninguna jugada (movimiento de pieza) legal que evite la 'captura' del\nrey en la siguiente jugada. Del jugador que alcanza este objetivo se dice\nque ha dado 'mate' al rey de su adversario y que ha ganado la partida.\nEl adversario, cuyo rey ha recibido el mate, pierde la partida. Si la\nposición es tal que ninguno de los jugadores puede dar mate,\nla partida es tablas.\nPor ultimo, a continuación se presentan los movimientos de cada ficha\ny movimientos especiales", width/12, (height/3)+65);
      pushStyle();
      pushMatrix();
      scale(0.45);
      videoObj.speed(4.0);
      videoObj.loop();
      image(videoObj, 14.5*width/20*(20/9), 7.25*height/20*(20/9));
      popStyle();
      popMatrix();
      videoObj.noLoop();
      break;
    case 12:
      textSize(30);
      text("Rey:", width/12, (height/3)+25);      
      textSize(16);
      text("El rey es la pieza más importante, pero también una de las más débiles.\nEl rey solo puede avanzar una casilla en cualquier dirección: hacia arriba,\nhacia abajo, hacia los lados o en diagonal. En ningún caso el rey puede\nmoverse a una casilla en la que estaría en jaque, es decir, en la que\npudiera ser capturado. Cuando el rey está directamente\namenazado por otra pieza, se dice que está 'en jaque', esto da paso a 3 \nopciones:\n - El rey debe moverse a una posición en la cual no este en jaque.\n - Una ficha del equipo en jaque debe bloquear la captura del rey.\n - Una ficha del equipo en jaque, incluido el rey, debe capturar a la ficha\n   que pone en riesgo al rey, en caso de que el rey sea el que capture\n   no puede comer si la posición donde esta la otra ficha lo deja en jaque.", width/12, (height/3)+65);
      pushStyle();
      pushMatrix();
      scale(0.45);
      videoRey.volume(0);
      videoRey.speed(4.0);
      videoRey.loop();
      image(videoRey, 14.5*width/20*(20/9), 7.25*height/20*(20/9));
      popStyle();
      popMatrix();
      videoRey.noLoop();
      break;
    case 13:
      textSize(30);
      text("Dama:", width/12, (height/3)+30);      
      textSize(16);
      text("La dama (reina) es la pieza más poderosa. Puede moverse en cualquier\ndirección (hacia adelante, hacia atrás, hacia los lados o en diagonal) y\ntantas casillas como se quiera; siempre y cuando no pase por encima de\nuna pieza de su color, asi mismo si una pieza de otro color se interpone\nen su camino solo puede capturarla mas no saltarla como todas las piezas\nexceptuando el peón y el caballo.", width/12, (height/3)+60);
      textSize(30);
      text("Torre:", width/12, (height/3)+180);      
      textSize(16);
      text("La torre puede moverse tantas casillas como quiera, pero solo hacia\nadelante, hacia atrás o hacia los lados. ¡Las torres son piezas\nespecialmente poderosas cuando trabajan juntas y se protegen\nmutuamente!", width/12, (height/3)+210);
      pushStyle();
      pushMatrix();
      scale(0.45);
      videoD_T.speed(4.0);
      videoD_T.loop();
      image(videoD_T, 14.5*width/20*(20/9), 7.25*height/20*(20/9));
      popStyle();
      popMatrix();
      videoD_T.noLoop();
      break;
    case 14:
      textSize(30);
      text("Alfil:", width/12, (height/3)+30);   
      textSize(16);
      text("El alfil puede moverse tan lejos como quiera, pero siempre en diagonal.\nCada alfil comienza en una casilla de un color (claro u oscuro) y debe\npermanecer toda la partida en ese color. Los dos alfiles trabajan bien\njuntos porque se cubren las debilidades mutuamente.", width/12, (height/3)+60);
      textSize(30);
      text("Caballo:", width/12, (height/3)+170);
      textSize(16);
      text("Los caballos se mueven de una manera muy diferente a la de las otras\npiezas: avanzan dos casillas en una dirección y luego una más en un\nángulo de 90 grados, o avanza inicialmente una casilla y luego dos más\ncon un ángulo igual, dibujando en su desplazamiento una letra 'L' sobre\nel tablero. Los caballos también son las únicas piezas que pueden saltar\nsobre otras.", width/12, (height/3)+200);
      pushStyle();
      pushMatrix();
      scale(0.45);
      videoA_C.speed(4.0);
      videoA_C.loop();
      image(videoA_C, 14.5*width/20*(20/9), 7.25*height/20*(20/9));
      popStyle();
      popMatrix();
      videoA_C.noLoop();
      break;
    case 15:
      textSize(30);
      text("Peón:", width/12, (height/3)+70);   
      textSize(16);
      text("Los peones tienen la particularidad de que se mueven y capturan de\ndiferentes maneras: se mueven hacia adelante, pero capturan en diagonal.\nLos peones sólo pueden avanzar una casilla en cada jugada, a excepción\nde su primer movimiento en el que puedan avanzar dos casillas. Los\npeones solo pueden avanzar a una casilla situada en diagonal (si hay\nuna pieza y la captura) y frente a ellos. Nunca pueden retroceder, ni\nsiquiera para capturar una pieza. Los peones no pueden moverse si en\nsu camino encuentran una pieza que ocupe la casilla situada\ndirectamente frente a ellos y tampoco pueden capturarla.", width/12, (height/3)+100);
      pushStyle();
      pushMatrix();
      scale(0.45);
      videoP.speed(4.0);
      videoP.loop();
      image(videoP, 14.5*width/20*(20/9), 7.25*height/20*(20/9));
      popStyle();
      popMatrix();
      videoP.noLoop();
      break;
    case 16:
      textSize(30);
      text("Movimientos Especiales:\n\n\nCaptura al paso:", width/12, (height/3)+10);
      textSize(16);
      text("La última regla sobre los peones se llama captura 'al paso'. Si un peón\navanza dos casillas en su primer movimiento, y al hacerlo se sitúa al\nlado de un peón rival, este peón enemigo tiene la opción de capturar al\nprimero ocupando la casilla que aquel hubiera ocupado si solo hubiera\navanzado una casilla. Esta jugada especial debe hacerse inmediatamente\ndespués del movimiento del primer peón, de lo contrario la opción de\ncapturar ya no estará disponible.", width/12, (height/3)+140);
      break;
    case 17:
      textSize(30);
      text("Enroque:", width/12, (height/3)+10);
      textSize(16);
      text("Hay otra regla especial denominada enroque. Esta jugada permite hacer\ndos cosas importantes en un solo movimiento: situar al rey en una\nposición más segura y sacar a la torre de su esquina para ponerla en\njuego. En un solo turno el jugador puede mover al rey dos casillas hacia\nun lado y, al mismo tiempo, la torre situada en la esquina de ese lado,\nse coloca junto al rey en la casilla ubicada en el lado opuesto.\nSin embargo, para poder hacer un enroque se deben cumplir las siguientes\ncondiciones:\n  - Debe ser la primera jugada de aquel rey\n  - Debe ser la primera jugada de aquella torre\n  - No puede haber ninguna pieza entre el rey y la torre\n  - El rey no puede estar en jaque ni pasar por una casilla amenazada\nSi el enroque se hace con la torre más cercana al rey se llama Enroque\ncorto o Enroque flanco de rey. Cuando el enroque se hace hacia el otro\nlado se denomina Enroque largo o Enroque flanco de dama.\nIndependientemente del tipo de enroque, el rey solo se mueve dos\ncasillas en esta jugada.", width/12, (height/3)+40);
      pushStyle();
      pushMatrix();
      scale(0.45);
      videoE.speed(4.0);
      videoE.loop();
      image(videoE, 14.5*width/20*(20/9), 7.25*height/20*(20/9));
      popStyle();
      popMatrix();
      videoE.noLoop();
      break;
    case 22:
      textSize(30);
      text("Aperturas:", width/12, (height/3)+10);
      textSize(16);
      text("En ajedrez se denomina apertura a la fase inicial del juego, en la que se\nprocede a desarrollar las piezas desde sus posiciones iniciales. Las tres\nfases de una partida de ajedrez son: apertura, medio juego y final. Las\nsecuencias de movimientos iniciales reconocidas se conocen como\naperturas o defensas. Hay docenas de aperturas diferentes que pueden\nvariar ampliamente desde el punto de vista del carácter, desde el juego\nposicional, hasta líneas de táctica salvaje. La apertura es un elemento\nfundamental en el ajedrez. Una apertura sólida permitirá consolidar\nposiciones ventajosas; por el contrario, la debilidad en la apertura\ndifícilmente podrá ser compensada en el posterior transcurso del juego.\nEste modo pretende enseñar al jugador aperturas estandarizadas para\nluego ser usadas en el modo versus\nModo de uso:\nCon las flechas que se muestran se avanza o retrocede (de acuerdo al\nsentido de la flecha) en el desarrollo de la apertura.", width/12, (height/3)+45); 
      pushStyle();
      pushMatrix();
      scale(0.3);
      videoAp.speed(4.0);
      videoAp.loop();
      image(videoAp, 14.5*width/20*(10/3), 7.25*height/20*(10/3));
      popStyle();
      popMatrix();
      videoE.noLoop();

      break;
    case 33:
      textSize(30);
      text("Acertijos:", width/12, (height/3)+80);
      textSize(16);
      text("El modo acertijos te pondra a prueba, te pondremos en una posición incial \nde una partida que ocurrio en la vida real y tendras que jugar,\ncomo ambos bandos, o con un amigo para solucionar la situación presentada,\nal lado inferior derecho tendras el botón solución que te mostrara\ncomo se desarrollo el juego en la vida real.\nEl objetivo es obtener un conocimiento de tanto ataque como defensa,\nen la pantalla de solución encontraras dos flechas para ir reproduciendo\nla solución.", width/12, (height/3)+115); 
      break;
    }
    popMatrix();
    popStyle();
  }
  for (int i=31; i<40; i++) {
    if (nivel==i) {
      if (lecFEN!=-1) {
        flechita[0].cambio();
        flechita[0].draw();
      }
      if (lecFEN < aperturas.plays.size()) {
        flechita[1].cambio();
        flechita[1].draw();
      }
      butGBP.cambio();
      butGBP.draw();

      board.cuadricula();
      board.display();


      switch(cambioPartida%9) {
      case 0:
        aperturas.setInput(loadStrings("italiana.pgn"));
        aperturas.lector();
        break;
      case 1:
        aperturas.setInput(loadStrings("atorre.pgn"));
        aperturas.lector();
        break;
      case 2:
        aperturas.setInput(loadStrings("budapest.pgn"));
        aperturas.lector();
        break;
      case 3:
        aperturas.setInput(loadStrings("inglesa.pgn"));
        aperturas.lector();
        break;
      case 4:
        aperturas.setInput(loadStrings("siciliana.pgn"));
        aperturas.lector();
        break;
      case 5:
        aperturas.setInput(loadStrings("gambito_de_dama.pgn"));
        aperturas.lector();
        break;
      case 6:
        aperturas.setInput(loadStrings("india_de_rey.pgn"));
        aperturas.lector();
        break;
      case 7:
        aperturas.setInput(loadStrings("francesa.pgn"));
        aperturas.lector();
        break;
      case 8:
        aperturas.setInput(loadStrings("la_inmortal.pgn"));
        aperturas.lector();
        break;
      }
    }
  }
  for (int i=41; i<50; i++) {
    if (nivel==i) {
      butGBA.cambio();
      butGBA.draw();
      if (solAc==0) {
        butSolAc.draw();
        butSolAc.cambio();
      }
      board.cuadricula();
      board.display();
      if (solAc==1) {
        if (lecFEN!=-1) {
          flechita[0].cambio();
          flechita[0].draw();
        }
        if (lecFEN < aperturas.plays.size()) {
          flechita[1].cambio();
          flechita[1].draw();
        }

        switch(conAcertijo-40) {
        case 1:
          aperturas.setInput(loadStrings("Solucion1.txt"));
          aperturas.lector();
          break;
        case 2:
          aperturas.setInput(loadStrings("Solucion2.txt"));
          aperturas.lector();
          break;
        case 3:
          aperturas.setInput(loadStrings("Solucion3.txt"));
          aperturas.lector();
          break;
        case 4:
          aperturas.setInput(loadStrings("Solucion4.txt"));
          aperturas.lector();
          break;
        case 5:
          aperturas.setInput(loadStrings("Solucion5.txt"));
          aperturas.lector();
          break;
        case 6:
          aperturas.setInput(loadStrings("Solucion6.txt"));
          aperturas.lector();
          break;
        case 7:
          aperturas.setInput(loadStrings("Solucion7.txt"));
          aperturas.lector();
          break;
        case 8:
          aperturas.setInput(loadStrings("Solucion8.txt"));
          aperturas.lector();
          break;
        case 9:
          aperturas.setInput(loadStrings("Solucion9.txt"));
          aperturas.lector();
          break;
        }
      }

      if (keyPressed && key == 'z') {
        //for (int x = 0; x <board.matchPlayed.size(); x++) {
        //println(x + " " + board.matchPlayed.get(x));
        //}
        save(board.matchPlayed);
        key = 0;
      }
    }
  }
  // *************************************************************************separación*********************************************************************************************//
  //if (board.board[(int)board.mousePosition().x][(int)board.mousePosition().y] != null) {
  //  println(board.board[(int)board.mousePosition().x][(int)board.mousePosition().y].getClass().getName());
  //}else {
  //  println("null");
  //}
  //if (board.board[(int)board.mousePosition().x][(int)board.mousePosition().y] != null) {
  //  println(board.board[(int)board.mousePosition().x][(int)board.mousePosition().y].getClass());
  //  println(board.board[(int)board.mousePosition().x][(int)board.mousePosition().y].getTeam());
  //} else {
  //  println("null");
  //}


  //if (board.board[(int)board.mousePosition().x][(int)board.mousePosition().y] != null) {
  //  board.PM(/*board.board[(int)board.mousePosition().x][(int)board.mousePosition().y].possibleMovements()*/ board.MovementsWhite(), !board.board[(int)board.mousePosition().x][(int)board.mousePosition().y].getTeam());
  //}

  noCursor();
  pushMatrix();
  pushStyle();
  scale(0.2);
  image(cursor, mouseX*5, mouseY*5);
  popMatrix();
  popStyle();
}
void movieEvent(Movie m) {
  m.read();
}