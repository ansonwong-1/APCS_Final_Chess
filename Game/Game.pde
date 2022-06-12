import javax.swing.*;
Board b;
boolean title = false;
Player[] players = new Player[2];
int current = 0;
int CLICK_MODE;
boolean whoseTurn = true;
final int FIRST = 0;
final int LOC = 1;
final int NEXT_PLAY = 2;
String first;

void setup() {
  size(1000, 850);
  title();
}

void draw() {
  if (!title) {
    b.update();
    //text(players[current].getName() + "Turn", 400, 800);
    fill(255);
    rect(835, 400, 200, 45);
    textSize(25);
    fill(0);
    if (!whoseTurn) {
      text("Black(" + players[1].getName() + ")", 845, 425);
    } else text("White(" + players[0].getName() + ")", 845, 435);
  }
}

String mouseSquare(int x, int y) {
  char c = char(65 + (x / 100));
  y = y / 100 + 1;
  String sq = c + str(y);
  return sq;
}

void mouseClicked() {
  if (title == false) {

    if (CLICK_MODE == FIRST) {
      int x = mouseX;
      int t = mouseY;
      if (whoseTurn) {
        if (x < 800 && t < 800 && !b.squareAt(t/100, x/100).isEmpty() && b.squareAt(t/100, x/100).getPiece().col == 255) {
          first = mouseSquare(x, t);
          textSize(15);
          fill(255);
          rect(835, 25, 200, 40);
          fill(0);
          String pColor;
          if (b.squareAt(t/100, x/100).getPiece().col == 0) {
            pColor = "Black";
          } else pColor = "White";
          text("Selected: " + pColor + " "  + b.squareAt(t/100, x/100).getPiece().name(), 840, 40);
          println(first);
          CLICK_MODE++;
        }
      } else {
        if (x < 800 && t < 800 && !b.squareAt(t/100, x/100).isEmpty() && b.squareAt(t/100, x/100).getPiece().col == 0) {
          first = mouseSquare(x, t);
          textSize(15);
          fill(255);
          rect(835, 25, 200, 40);
          fill(0);
          String pColor;
          if (b.squareAt(t/100, x/100).getPiece().col == 0) {
            pColor = "Black";
          } else pColor = "White";
          text("Selected: " + pColor + " "  + b.squareAt(t/100, x/100).getPiece().name(), 840, 40);
          println(first);
          CLICK_MODE++;
        }
      }
    } else if (CLICK_MODE == LOC) {
      int finalx = mouseX;
      int finaly = mouseY;
      if (finalx < 800 && finaly < 800) {
        fill(255);
        rect(835, 25, 200, 40);
        print(finalx + " " + finaly);
        String loc = mouseSquare(finalx, finaly);
        CLICK_MODE=0;
        if (!loc.equals(first)) {
          b.move(first, loc);
        }
      }
    }
  }
}

boolean validIn(String x) { //have this check if input commands are valid
  if (x.length() == 2) {
    String lLoc = x.substring(0, 1);
    int iLoc;
    try {
      iLoc = Integer.parseInt(x.substring(1));
    }
    catch(Exception e) {
      return false;
    }
    if (lLoc.compareTo("A") >=0 && lLoc.compareTo("H") <= 0) {
      if (iLoc >= 1 && iLoc <= 8) {
        return true;
      }
    }
  }
  return false;
}


void startGame() {
  b = new Board();
  title = false;
}


void keyPressed() {
  if (key == ' ') {
    startGame();
     String name1 = "";
     String name2 = "";
    while (name1 == null || name1.length() == 0 || name1.length() > 4) {
       name1 = getS("Enter Player 1 Name (4 Char or less): ");
     }
     while (name2 == null || name2.length() == 0 || name2.length() > 4) {
       name2 = getS("Enter Player 2 Name (4 Char or less): ");
     }
     players[0] = new Player(name1, 255);
     players[1] = new Player(name2, 0);
  } else if (key == '`') {
    title();
    startGame();
  } else if (key == 'p') {
    exit();
  }
}

void title() {
  title = true;
  background(0);
  PImage titlescreen = loadImage("chess.jpeg");
  image(titlescreen, 110, 248);
  //int x = titlescreen.width;
  //int y = titlescreen.height;
  //print(x + " " + y);
  textSize(50);
  fill(255);
  text("CHESS", width/2 - 90, 198);
  text("Press SPACEBAR to start", 140, 652);
}


String prompt(String s)
{
  println(s);
  String entry = JOptionPane.showInputDialog(s);
  if (entry == null)
    return null;
  println(entry);
  return entry;
}

String getS(String s)
{
  return prompt(s);
}

int getI(String s)
{
  return Integer.parseInt(getS(s));
}
