import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'Classes/Color.dart';
import 'winsplash.dart';
import 'Classes/Assists.dart';

class game extends StatefulWidget {
  game({Key? key, required this.title, required this.assists}) : super(key: key);
  final String title;
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
            Column(
              children: [
                StyleText('5:00',1),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                    ),
                  ),
                  width: 229,
                  height: 500,
                  child: Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: moves.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: StyleText(moves[index],0),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StyleText('White\'s Turn',1),
                      StyleText('Move 10',1),
                    ],
                  ),
                  Chessboard(),
                  Container(
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
                                WinSplash(title: 'title', win: false),
                          ),
                        );
                      },
                      child: Text(
                        'Resign',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                StyleText('1:00',1),
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
                        title: StyleText(moves[index],0),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

Widget StyleText(String text, double x) {
  return Container(
    width: 229,
    decoration: BoxDecoration(
      border: x >= 1 ?
      Border.all(
        width: x,
      ) : null,
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 35),
      ),
    ),
  );
}

Widget Chessboard() {
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
  switch (((x + x/8) % 2).floor()) {
    case 0:
      return lightbrown;
    case 1:
      return darkbrown;
    default:
      return darkbrown;
  }
}

List<String> moves = [
  'Na6',
  'a3',
  'O-O',
  'e6',
  'Qc4',
  'Bh6',
  'a3',
  'O-O',
  'e6',
  'Qc4',
  'Bh6',
];

List<String> board =
['r','.','b','q','k','b','.','r',
    'p','p','p','p','.','Q','p','p',
    '.','.','n','.','.','n','.','.',
    '.','.','.','.','p','.','.','.',
    '.','.','B','.','P','.','.','.',
    '.','.','.','.','.','.','.','.',
    'P','P','P','P','.','P','P','P',
    'R','N','B','.','K','.','N','R'];

Widget getpiece(String c) {
  String img;
  switch(c) {
    case 'r':
      img = 'Chess_rdt60.png';
      break;
    case 'n':
      img = 'Chess_ndt60.png';
      break;
    case 'b':
      img = 'Chess_bdt60.png';
      break;
    case 'k':
      img = 'Chess_kdt60.png';
      break;
    case 'q':
      img = 'Chess_qdt60.png';
      break;
    case 'p':
      img = 'Chess_pdt60.png';
      break;
    case 'R':
      img = 'Chess_rlt60.png';
      break;
    case 'N':
      img = 'Chess_nlt60.png';
      break;
    case 'B':
      img = 'Chess_blt60.png';
      break;
    case 'K':
      img = 'Chess_klt60.png';
      break;
    case 'Q':
      img = 'Chess_qlt60.png';
      break;
    case 'P':
      img = 'Chess_plt60.png';
      break;
    default:
      img = '';
  }
  if (img != '') {
    return Image.asset('images/'+img);
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