public class Board {
  int bLength = 800;
  Square[][] spaces = new Square[8][8];
  String wKingLoc;
  String bKingLoc;
  public Board() {
    create();
  }

  Square squareAt(int x, int y) {
    return spaces[x][y];
  }

  public void create() {
    textSize(12);
    background(255);
    rect(0, 0, bLength, bLength);

    //Creation of the Checkered Board Pattern
    createCheckered();
    //Creation of the Letters/Numbers
    fill(0);
    int j = 0;
    for (char i = 'A'; i < 'I'; i++) {
      text(i, j * bLength/8 + 50, bLength + (height - bLength)/2); 
      j++;
    }

    for (int i = 1; i < 9; i++) {
      text(i, bLength+ (height - bLength)/2, i * bLength/8 - 50);
    }

    //Adding pieces to the board
    spaces[0][0] = new Square(0, 0, new Rook(0));
    spaces[0][1] = new Square(1, 0, new Knight(0)); 
    spaces[0][2] = new Square(2, 0, new Bishop(0));
    spaces[0][3] = new Square(3, 0, new Queen(0));
    spaces[0][4] = new Square(4, 0, new King(0));
    bKingLoc = "04";
    spaces[0][5] = new Square(5, 0, new Bishop(0));
    spaces[0][6] = new Square(6, 0, new Knight(0));
    spaces[0][7] = new Square(7, 0, new Rook(0));
    for (int i = 0; i <= 7; i++) {
      spaces[1][i] = new Square(i, 1, new Pawn(0));
    }

    for (int i = 0; i <= 7; i++) {
      spaces[6][i] = new Square(i, 6, new Pawn(255));
    }
    spaces[7][0] = new Square(0, 7, new Rook(255));
    spaces[7][1] = new Square(1, 7, new Knight(255));
    spaces[7][2] = new Square(2, 7, new Bishop(255));
    spaces[7][3] = new Square(3, 7, new Queen(255));
    spaces[7][4] = new Square(4, 7, new King(255));
    wKingLoc = "47";
    spaces[7][5] = new Square(5, 7, new Bishop(255));
    spaces[7][6] = new Square(6, 7, new Knight(255));
    spaces[7][7] = new Square(7, 7, new Rook(255));


    for (int i = 2; i < 6; i++) {
      for (int k = 0; k <= 7; k++) {
        spaces[i][k] = new Square(k, i, null);
      }
    }
  }
  
  void move(String first, String place) {
    String fLetter = first.substring(0, 1);
    int fStringNum = lToN(fLetter);
    int fNum = Integer.parseInt(first.substring(1)) - 1;


    String pLetter = place.substring(0, 1);
    int pStringNum = lToN(pLetter);
    int pNum = Integer.parseInt(place.substring(1)) - 1;

    if (canMove(fNum, fStringNum, pNum, pStringNum) &&
    !isChecked(fNum, fStringNum, pNum, pStringNum) {
      Pieces x = spaces[fNum][fStringNum].getPiece();
      spaces[fNum][fStringNum].setPiece(null);
      spaces[pNum][pStringNum].setPiece(x);
    }
  }
  
  boolean isChecked(int firstX, int firstY, int lastX, int lastY){
    Pieces inOld = spaces[firstX][firstY].getOccupant();
    int kingLocX;
    int kingLocY;
    if (inOld.col == 255){
      kingLocX = int(bKingLoc.substring(0,1));
      kingLocY = int(bKingLoc.substring(1));
    }else{
      kingLocX = int(wKingLoc.substring(0,1));
      kingLocY = int(wKingLoc.substring(1));
    }
    for(int i = 0; i < kingLocX; i++){
      if(spaces[i][kingLocY] != null){
        if (canMove(i, kingLocY, kingLocX, kingLocY)){
          return true;
        }i = kingLocX;
      }
    }
    for(int i = 0; i < kingLocY; i++){
      if(spaces[kingLocX][i] != null){
        if (canMove(kingLocX, i, kingLocX, kingLocY)){
          return true;
        }i = kingLocY;
      }
    }
    return false;
  }
  boolean canMove(int firstX, int firstY, int lastX, int lastY) {
    println("Last X: " + lastX);
    println("Last Y: " + lastY);
    println("First Y: " + firstY);
    println("First X: " + firstX);


    //piece of same color in last
    Pieces inNew = spaces[lastX][lastY].getOccupant();
    Pieces inOld = spaces[firstX][firstY].getOccupant();
    if (inNew != null) {
      if ((inOld.col == 255 && inNew.col == 255) ||
        (inOld.col == 0 && inNew.col == 0)) {
          print("piece of same color in spot");
        return false;
      }
    }

    //out of bounds
    /*  if (firstX < 0 || firstX > 7 || firstY < 0 || firstY > 7
     || lastX < 0 || lastX > 7 || lastY < 0 || lastY > 8) {
     return false;
     } */

    if (inOld.name().equals("pawn")) {
      //return true;
      if (inOld.col == 255) { //white side basic movement 
        if (firstX == 6) {
          if (lastX == 4 && lastY == firstY) {
            return true;
          }
        } 
        if (firstX - 1 == lastX && lastY == firstY) {
                 println(spaces[lastY][lastX].isEmpty());
                 
          if(spaces[lastY][lastX].isEmpty()){
     
          return true;
          }
        }
        //capturing left/right side
        if (firstX - 1 == lastX) {
          if (firstY + 1 == lastY && spaces[lastY][lastX].getOccupant() != null && spaces[lastY][lastX].getOccupant().col != 255) {
            return true;
          }
        }
      }


      if (inOld.col == 0) { //black side
        if (firstX == lastX - 1 && (firstY == lastY - 1 || firstY == lastY + 1)) { //capturing
          if (inNew == null || inNew.col != 255) {
            return false;
          }
        } else if (inNew != null || (firstX != lastX - 1 && spaces[lastX + 1][lastY].getOccupant() != null)) {
          return false;
        } else if (firstX == 1) {
          if (firstY != lastY || (firstX != lastX - 1 && firstX != lastX - 2)) {
            return false;
          }
        } else {
          if (firstY != lastY || firstX != lastX - 1) {
            return false;
          }
        }
      }
    }

    if (inOld.name().equals("rook")) {
      boolean moveVert = false;
      boolean moveHor = false;
      //making sure its horizontal/vertical
      if (firstX == lastX) {
        moveHor = true;
      } else if (firstY == lastY && firstX != lastX) {
        moveVert = true;
      }
      //this part is supposed to be for checking for pieces in the way but it doesnt work
      for (int i = firstX; i < lastX; i++) {
        if (spaces[i][firstY].getPiece() != null) {
          return false;
        }
      }
      for (int i = firstX; i < lastX; i--) {
        if (spaces[i][firstY].getPiece() != null) {
          return false;
        }
      }
      for (int i = firstY; i < lastY; i++) {
        if (spaces[firstX][i].getPiece() != null) {
          return false;
        }
      }
      for (int i = firstY; i < lastY; i--) {
        if (spaces[firstX][i].getPiece() != null) {
          return false;
        }
      }
    }

    if (inOld.name().equals("knight")) {
      if (firstX - lastX == 0 || firstY - lastY == 0) {
        return false;
      }
      if ((firstX - 2) == lastX && firstY - 1 == lastY) {
        return true;
      }
      if ((firstX - 2) == lastX && firstY + 1 == lastY) {
        return true;
      }
      if ((firstX + 2) == lastX && firstY + 1 == lastY) {
        return true;
      }
      if ((firstX + 2) == lastX && firstY - 1 == lastY) {
        return true;
      }
      if ((firstX + 1) == lastX && firstY + 2 == lastY) {
        return true;
      }
      if (firstX - 1 == lastX && firstY + 2 == lastY) {
        return true;
      }
      if (firstX + 1 == lastX && firstY - 2 == lastY) {
        return true;
      }
      if (firstX - 1 == lastX && firstY - 2 == lastY) {
        return true;
      }
    }


    if (inOld.name().equals("bishop")) {

      int tempX = abs(firstX - lastX);
      int tempY = abs(firstY - lastY);
      if (tempX == tempY) {
        boolean x = true;
        //check left up
        if (firstX >lastX && firstY > lastY) {
          println(x);
          int tempx = firstX;
          int tempy = firstY;
          while (tempx != lastX && tempy != lastY) {
            tempx--;
            tempy--;
            print(tempx + " " + tempy);
            if (!spaces[tempy][tempx].isEmpty()) {
              println(spaces[tempy][tempx].getPiece().name()); 
              //  println("has something empty");
              x = false;
            }
          }
          print(x);
          if (x == false) {
            return x;
          } else return true;
        }
        return x;
      }
    }
    //return true;
    return false;
  }

  int lToN(String x) {
    switch(x) {
    case "A":
      return 0;
    case "B":
      return 1;
    case "C":
      return 2;
    case "D":
      return 3;
    case "E":
      return 4;
    case "F":
      return 5;
    case "G":
      return 6;
    }
    return 7;
  }


  void update() {
    createCheckered();
    for (int i = 0; i < spaces.length; i++) {
      for (int j = 0; j < spaces[0].length; j++) {
        spaces[i][j].show();
      }
    }
  }

  void createCheckered() {
    boolean alternate = false;
    for (int i = 0; i < spaces.length; i++) {
      for (int j = 0; j < spaces[0].length; j++) {
        alternate = !alternate;
        if (alternate == false) {
          fill(105, 180, 105);
          square(i * 100, j * 100, 100);
        } else if (alternate == true) {
          fill(150, 75, 150);
          square(i * bLength/8, j * bLength/8, 100);
        }
      }
      if (alternate == true) {
        alternate = !alternate;
      } else alternate = !alternate;
    }
    fill(0);
  }
}
