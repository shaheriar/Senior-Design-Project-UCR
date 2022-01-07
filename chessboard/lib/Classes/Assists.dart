class Assists {
  bool w = false;
  bool b = false;
  int h = 0;
  bool check = false;
  Assists(this.w, this.b, this.h, this.check);
  Map toJson() => {
        'player1': w, //RECOMMENDED MOVES FOR P1
        'player2': b, //RECOMMENDED MOVES FOR P2
        'gamemode' : h, //VS HUMAN OR AI
        'move' : null,  //LAST MOVE DONE
        'usercolor' : check //COLOR OF THE USER
      };
}