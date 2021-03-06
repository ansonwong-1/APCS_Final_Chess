// individual piece not the array
public class Pieces {
  PImage piece;
  color col;
  int x;
  int y;
  boolean isDead;
  
  String name(){
    return "piece";
  }
  
  Pieces(color c_, int x_, int y_) {
    col = c_;
    x = x_ * 100;
    y = y_ * 100;

    isDead = false;
  }

  Pieces(color c_) {
    col = c_;
    isDead = false;
  }

  void kill() {
    isDead = true;
  }

  String setImage() {
    return null;
  }
}

//move to a new tab- j testing it first
class Pawn extends Pieces {
  Pawn(color c_) {
    super(c_);
  }
  
  String name(){
    return "pawn";
  }

  String setImage() {
    if (col == 0) {
      //works with other images (chess.jpeg)
      return "Black_Pawn.png";
    } else return "White_Pawn.png";
  }
}

class Knight extends Pieces {
  Knight(color c_) {
    super(c_);
  }
  
  String name(){
    return "knight";
  }
  
  String setImage() {
    if (col == 0) {
      //works with other images (chess.jpeg)
      return "Black_Knight.png";
    } else if (col == 255) {
      return "White_Knight.png";
    } else return "";
  }
}

class Rook extends Pieces {
  Rook(color c_) {
    super(c_);
  }
  
  String name(){
    return "rook";
  }
  
  String setImage() {
    if (col == 0) {
      //works with other images (chess.jpeg)
      return "Black_Rook.png";
    } else return "White_Rook.png";
  }
}

class Queen extends Pieces {
  Queen(color c_) {
    super(c_);
  }
  
  String name(){
    return "queen";
  }
  
  String setImage() {
    if (col == 0) {
      //works with other images (chess.jpeg)
      return "Black_Queen.png";
    } else return "White_Queen.png";
  }
}

class King extends Pieces {
  King(color c_) {
    super(c_);
  }
  
  String name(){
    return "king";
  }
  
  String setImage() {
    if (col == 0) {
      //works with other images (chess.jpeg)
      return "Black_King.png";
    } else return "White_King.png";
  }
}

class Bishop extends Pieces {
  Bishop(color c_) {
    super(c_);
  }
  
  String name(){
    return "bishop";
  }

  String setImage() {
    if (col == 0) {
      return "Black_Bishop.png";
    } else return "White_Bishop.png";
  }
}
