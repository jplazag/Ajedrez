class Reader {

  String[] input;
  String rec = new String();
  int numPlay;
  ArrayList<String> plays = new ArrayList<String>();
  //int index = 0, n = 0;


  public Reader() {
  }

  public void setInput(String[] i) {
    this.input = i;
  }

  public ArrayList<String> getPlays() {
    return plays;
  }
  public String posicion_inicial() {
    String s = new String();
    for (int i = 0; i < input.length; i++) {
    }
    for (int x=10; x<input.length; x++) {
      s += input[x];
      s += " ";
    }
    s = s.substring(0, s.length()-2);
    s+="<";
    return s.toString();
  }

  public void lector() {
    int index = 0;
    while (posicion_inicial().charAt(index++) != '<') {
      if (posicion_inicial().charAt(index) == ' ') {
        do {
          index++;
          if (posicion_inicial().charAt(index) != ' ' && posicion_inicial().charAt(index) != '+' && posicion_inicial().charAt(index) != '#')
            rec += posicion_inicial().charAt(index);
        } while (posicion_inicial().charAt(index) != ' ');
        plays.add(rec);
        rec = "";
        index++;
        if (Character.isDigit(posicion_inicial().charAt(index)) ) {
          do {
            index++;
          } while (Character.isDigit(posicion_inicial().charAt(index)));
        } else {
          index -= 2;
        }
      } 
      if ( posicion_inicial().charAt(index) == '<') break;
    }
    //for (int x = 0; x <plays.size(); x++) {
    //  println(x + " " + plays.get(x));
    //}
  }

  public void reproductor(int c) {
    //Piece object = new Piece();
    int /*c = 0,*/ i = 0, j= 0/*, n = 0, k = 0*/;
    //Aqui se debe conectar con un boton que aumente el contador c
    String play = plays.get(c);
    if(c%2 == 0){
    switch(play.length()) {
    case 2: //Pawn
      i = ((int) (play.charAt(1) - 48)) - 1;     //Cambiar para que sea int
      j = conversor(play, 0);
      PVector finb = new PVector();
      finb.x = i;
      finb.y = j;
      
      //n  = i;
      
      for(int x =i; x <= 7; x++ ){ 
        if(board.board[x][j] != null){
         if(board.board[x][j].getClass().getName() == "Chess$Pawn"){
           board.board[x][j] = null;
           board.board[(int)finb.x][(int)finb.y] = nueva_pieza(play,0,finb, true); 
          }
        }
      }
      
     /*  PVector inicio = new PVector();
       inicio.x = n;
       inicio.y = j;*/
    break;
    case 3: 
     
      PVector fin2b = new PVector();
      fin2b.x = (int) (play.charAt(2) - 48)-1;
      fin2b.y = conversor(play, 1);      
      for(int x = 0; x < 64; x++){
        if(board.board[x/8][x%8]!=null){
        if(board.board[x/8][x%8].getClass().getName() == identificador(play, 0) && (board.board[x/8][x%8].possibleMovements().indexOf(fin2b) != -1)){
          board.board[x/8][x%8] = null;
          board.board[(int)fin2b.x][(int)fin2b.y] = nueva_pieza(play,0,fin2b, true);          
        }
      }
      }
       
      break;
    case 4: //Captura
      PVector fin3b = new PVector();
      fin3b.x = (int) (play.charAt(3) - 48);
      fin3b.y = conversor(play, 2);
      board.board[(int)fin3b.x][(int)fin3b.y] = null;  
      for(int x = 0; x < 64; x++){
        if(board.board[x/8][x%8]!=null){
        if(board.board[x/8][x%8].getClass().getName() == identificador(play, 0) && (board.board[x/8][x%8].possibleMovements().indexOf(fin3b) != -1)){
          board.board[x/8][x%8] = null;
          board.board[(int)fin3b.x][(int)fin3b.y] = nueva_pieza(play,0,fin3b, true);  
        }
        }
        } 
     break;
    }
    }
//    *********************************************************************
if(c%2==1){
    switch(play.length()) {
    case 2: //Pawn
      i = ((int) (play.charAt(1) - 48)) - 1;     //Cambiar para que sea int
      j = conversor(play, 0);
      PVector finn = new PVector();
      finn.x = i;
      finn.y = j;
      
      //n  = i;
      
      
           for(int n = i; n >= 0; n-- ){ 
        if(board.board[n][j] != null){
         if(board.board[n][j].getClass().getName() == "Chess$Pawn"){
           board.board[n][j] = null;
           board.board[(int)finn.x][(int)finn.y] = nueva_pieza(play,0,finn, false);     
          }
        }
      }
    break;
    case 3: 
     
      PVector fin2n = new PVector();
      fin2n.x = (int) (play.charAt(2) - 48)-1;
      fin2n.y = conversor(play, 1);      
      for(int x = 0; x < 64; x++){
        if(board.board[x/8][x%8]!=null){
        if(board.board[x/8][x%8].getClass().getName() == identificador(play, 0) && (board.board[x/8][x%8].possibleMovements().indexOf(fin2n) != -1)){
          board.board[x/8][x%8] = null;
          board.board[(int)fin2n.x][(int)fin2n.y] = nueva_pieza(play,0,fin2n, false);          
        }
      }
      }
       
      break;
    case 4: //Captura  
          PVector fin3n = new PVector();
      fin3n.x = (int) (play.charAt(3) - 48);
      fin3n.y = conversor(play, 2);  
      board.board[(int)fin3n.x][(int)fin3n.y] = null;  
      for(int x = 0; x < 64; x++){
        if(board.board[x/8][x%8]!=null){
        if(board.board[x/8][x%8].getClass().getName() == identificador(play, 0) && (board.board[x/8][x%8].possibleMovements().indexOf(fin3n) != -1)){
          board.board[x/8][x%8] = null;
          board.board[(int)fin3n.x][(int)fin3n.y] = nueva_pieza(play,0,fin3n, false);          
        }
        }
        } 
     break;
    }
    }
}
 
  public int conversor(String p, int index) {
    int j = 0;
    switch(p.charAt(index)) {
    case 'a':
      j = 0;
      break;
    case 'b':
      j = 1;
      break;
    case 'c':
      j = 2;
      break;
    case 'd':
      j = 3;
      break;
    case 'e':
      j = 4;
      break;
    case 'f':
      j = 5;
      break;
    case 'g':
      j = 6;
      break;
    case 'h':
      j = 7;
      break;
    default:
      j = -1;
      break;
    }
    return j;
  }


  public String identificador(String p, int index) {
    String pieza = new String();
    switch(p.charAt(index)) {
    case 'R':
      pieza = "Chess$Rock";
      break;
    case 'N':
      pieza = "Chess$Knight";
      break;
    case 'B':
      pieza = "Chess$Bishop";
      break;
    case 'Q':
      pieza = "Chess$Queen";
      break;
    case 'K':
      pieza = "Chess$King";
      break;
    }
    return pieza;
  }
  
   public Piece nueva_pieza(String p, int index,PVector positionf, boolean team) {
    Piece object = null;
if(team==true){
  switch(p.charAt(index)) {
    default:
      object = new Pawn(positionf, team, i[0]);
      break;
    case 'N':
      object = new Knight(positionf, team, i[4]);
      break;
    case 'B':
      object = new Bishop(positionf, team, i[2]);
      break;
    case 'R':
      object = new Rock(positionf, team, i[6]);
      break;
    case 'Q':
      object = new Queen(positionf, team, i[8]);
      break;
    case 'K':
      object = new King(positionf, team, i[10]);
      break;
    }
}else if(team==false){
  switch(p.charAt(index)) {
    default:
      object = new Pawn(positionf, team, i[1]);
      break;
    case 'N':
      object = new Knight(positionf, team, i[5]);
      break;
    case 'B':
      object = new Bishop(positionf, team, i[3]);
      break;
    case 'R':
      object = new Rock(positionf, team, i[7]);
      break;
    case 'Q':
      object = new Queen(positionf, team, i[9]);
      break;
    case 'K':
      object = new King(positionf, team, i[11]);
      break;
    }    
}return object;
  }
}