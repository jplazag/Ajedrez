abstract class Piece {

  PVector position;
  boolean team;
  PImage icon;
  boolean selection = false;
  boolean first = true;

  //Constructor
  public Piece(PVector p, boolean t, PImage i) {
    position = p;
    team = t;
    icon = i;
  }

  public void setSelection(boolean b) {
    selection = b;
  }

  public boolean getFirst(){
    return first;
  }
  
  public void setFirst(boolean f) {
    this.first = f;
  }

  public boolean getSelection() {
    return selection;
  }

  public void setPosition(PVector e) {
    position = e;
  }

  public PVector getPosition() {
    return position;
  }

  public boolean getTeam() {
    return team;
  }

  public void drawPiece(int s) {
    image(icon, (position.x)*s, (position.y)*s, s, s);
  }

  abstract public ArrayList possibleMovements();

  public void eat() {
  }
}