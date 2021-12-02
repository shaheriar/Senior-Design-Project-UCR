class Assists {
  bool w = false;
  bool b = false;
  int h = 0;
  Assists(this.w, this.b, this.h);
  Map toJson() => {
        'white': w,
        'black': b,
        'gamemode' : h,
        'move' : null
      };
}