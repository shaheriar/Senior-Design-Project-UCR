class Assists {
  bool w = false;
  bool b = false;
  int h = 0;
  bool check = false;
  Assists(this.w, this.b, this.h, this.check);
  Map toJson() => {
        'player1': w, //RECOMMENDED MOVES FOR P1
        'player2': b, //RECOMMENDED MOVES FOR P2
        'gamemode' : h > 1 ? 2 : 1, //VS HUMAN OR AI  1 = human, 2 = easy, 3 = medium, 4 = hard
        'difficulty' : h,
        'move' : null,  //LAST MOVE DONE
        'usercolor' : check //COLOR OF THE USER
      };
}