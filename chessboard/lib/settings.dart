import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'vsMenu.dart';
import 'settings.dart';
import 'history.dart';

class settings extends StatefulWidget {
  settings({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFF747474),
      body: Stack(
        children: [
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 11,
            ),
            itemBuilder: _buildGridItems,
            itemCount: 77,
          ),
          Row(
            children: [
              FloatingActionButton(
                backgroundColor: Color(0xFFf67a7a),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(CupertinoIcons.back),
              )
            ],
          ),
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                fixedSize: Size(300, 60),
                primary: Colors.white,
                backgroundColor: Color(0xFFf67a7a),
              ),
              onPressed: () {
              },
              child: Text(
                'Delete All Games',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Color getcolor(int x) {
  switch (x % 2) {
    case 0:
      return Color(0xFF672727);
    case 1:
      return Color(0xFF747474);
    default:
      return Color(0xFF747474);
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
