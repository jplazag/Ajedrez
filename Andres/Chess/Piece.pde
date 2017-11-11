abstract class Piece {
  
  PVector position;
  boolean team;
  PImage icon;
  
  public Piece(PVector p, boolean t, PImage i){
    position = p;
    team = t;
    icon = i;
  }
  
  public void setPosition(float f, float c){
    this.position.x = f;
    this.position.y = c;
  }
  
  public PVector getPosition(){
    return position;
  }
  
  public boolean getTeam(){
    return team;
  }
  
  abstract public PVector moviment(PVector c);
  
  abstract public ArrayList posibleMoviments();
  
  public void eat(){
      
  }
}