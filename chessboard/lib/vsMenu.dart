import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'difficulty.dart';
import 'assistmenu.dart';
import 'Color.dart';

class vsMenu extends StatefulWidget {
  vsMenu({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _vsMenuState createState() => _vsMenuState();
}

class _vsMenuState extends State<vsMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFF747474),
      body: Stack(
        children: [
          GridView.builder(
            primary: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 11,
            ),
            itemBuilder: _buildGridItems,
            itemCount: 77,
          ),
          Row(
            children: [
              FloatingActionButton(
                backgroundColor: darkbrown,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(CupertinoIcons.back),
              )
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MyButton(context, 'vs Human', assists(title: '')),
                SizedBox(
                  height: 20,
                ),
                MyButton(context, 'vs AI', difficulty(title: 'title'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget MyButton(BuildContext context, String text, Widget widget) {
  return TextButton(
    style: TextButton.styleFrom(
      fixedSize: Size(200, 60),
      primary: Colors.white,
      backgroundColor: darkbrown,
    ),
    onPressed: () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              widget,
        ),
      );
    },
    child: Text(
      text,
      style: TextStyle(fontSize: 35),
    ),
  );
}

Color getcolor(int x) {
  switch (x % 2) {
    case 0:
      return primary;
      break;
    case 1:
      return secondary;
      break;
    default:
      return secondary;
  }
}

Widget _buildGridItems(BuildContext context, int index) {
  return GridTile(
    child: Container(
      width: 50,
      height: 50,
      color: getcolor(index),
    ),
  );
}
