import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'Classes/Color.dart';
import 'winsplash.dart';
import 'Classes/Assists.dart';

class game extends StatefulWidget {
  game({Key? key, required this.assists}) : super(key: key);
  Assists assists;

  @override
  _gameState createState() => _gameState();
}

class _gameState extends State<game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: primary,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          playerinfo('5:00', moves),
          Container(
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    styleText('White\'s Turn', 1),
                    styleText('Move 10', 1),
                  ],
                ),
                chessboard(),
                resignbutton(context)
              ],
            ),
          ),
          playerinfo('1:00', moves)
        ],
      ),
    );
  }
}

Widget playerinfo(String time, List<String> moveslist) {
  return Column(
    children: [
      styleText(time, 1),
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
          ),
        ),
        width: 229,
        height: 500,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: moves.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: styleText(moveslist[index], 0),
            );
          },
        ),
      ),
    ],
  );
}

Widget resignbutton(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        width: 1,
      ),
    ),
    child: TextButton(
      style: TextButton.styleFrom(
        fixedSize: Size(200, 60),
        primary: Colors.white,
        backgroundColor: darkbrown,
      ),
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, animation1, animation2) =>
                WinSplash(win: false),
          ),
        );
      },
      child: Text(
        'Resign',
        style: TextStyle(fontSize: 35),
      ),
    ),
  );
}

Widget styleText(String text, double x) {
  return Container(
    width: 229,
    decoration: BoxDecoration(
      border: x >= 1
          ? Border.all(
              width: x,
            )
          : null,
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 35),
      ),
    ),
  );
}

Widget chessboard() {
  return SizedBox(
    height: 500,
    width: 500,
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
      ),
      itemBuilder: _buildGridItems,
      itemCount: 64,
    ),
  );
}

Color getcolor(int x) {
  switch (((x + x / 8) % 2).floor()) {
    case 0:
      return lightbrown;
    case 1:
      return darkbrown;
    default:
      return darkbrown;
  }
}

List<String> moves = ['Na6', 'a3', 'O-O', 'e6', 'Qc4', 'Bh6', 'a3', 'O-O', 'e6', 'Qc4', 'Bh6'];

List<String> board = ['r','.','b','q','k','b','.','r',
                      'p','p','p','p','.','Q','p','p',
                      '.','.','n','.','.','n','.','.',
                      '.','.','.','.','p','.','.','.',
                      '.','.','B','.','P','.','.','.',
                      '.','.','.','.','.','.','.','.',
                      'P','P','P','P','.','P','P','P',
                      'R','N','B','.','K','.','N','R'];

Widget getpiece(String c) {
  if (c != '.') {
    if (c == c.toLowerCase()) {
      return Image.asset('images/Chess_' + c.toLowerCase() + 'dt60.png');
    } else if (c == c.toUpperCase()) {
      return Image.asset('images/Chess_' + c.toLowerCase() + 'lt60.png');
    }
  }
  return Container();
}

Widget _buildGridItems(BuildContext context, int index) {
  return GridTile(
    child: Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          color: getcolor(index),
        ),
        Center(child: getpiece(board[index])),
      ],
    ),
  );
}