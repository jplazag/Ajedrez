PImage i;
float x = 5;
float y = 5;

Knight knight = new Knight(new PVector(x, y), true, i);
Bishop bishop = new Bishop(new PVector(x, y), true, i);
ArrayList<PVector> posible;

void setup() {
  size(500, 500);
  i = loadImage("Hola.png");
}

void draw() {
  knight.setPosition(x, y);
  posible = knight.posibleMoviments();

  for (int j = 0; j<8; j++) {
    for (int i = 0; i<8; i++) {
      if ((mouseX>(i)*50) && (mouseX<(i+1)*50) && (mouseY>(j)*50) && (mouseY<(j+1)*50)) {
        x=j+1;
        y=i+1;
        fill(0, 255, 0);
      } else if (((j  == posible.get(5).x-1) && (i == posible.get(5).y-1))) {
        for (int c = 0; c < posible.size(); c++) {
          if ((j  == posible.get(c).x-1) && (i == posible.get(c).y-1)) {
            fill(255, 0, 0);
          }
        }
        /*((j  == posible.get(1).x-1) && (i == posible.get(1).y-1))||
         ((j  == posible.get(2).x-1) && (i == posible.get(2).y-1))||
         ((j  == posible.get(3).x-1) && (i == posible.get(3).y-1))||
         ((j  == posible.get(4).x-1) && (i == posible.get(4).y-1))||
         ((j  == posible.get(5).x-1) && (i == posible.get(5).y-1))||
         ((j  == posible.get(6).x-1) && (i == posible.get(6).y-1))||
         ((j  == posible.get(7).x-1) && (i == posible.get(7).y-1))*/
      }else if ((i+j)%2==0) {
        fill(0);
      } else {
        fill(255);
      }
      rect(i*50, j*50, 50, 50);
    }
  }
}