import 'package:flutter/material.dart';
import 'vsMenu.dart';
import 'settings.dart';
import 'history.dart';
import 'Color.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: secondary,
      body: Stack(
        children: [
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 11,
            ),
            itemBuilder: _buildGridItems,
            itemCount: 77,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child: Container()),
                Text(
                  'Smart Chessboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20,),
                TextButton(
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
                            vsMenu(title: 'title'),
                      ),
                    );
                  },
                  child: Text(
                    'Play',
                    style: TextStyle(fontSize: 35),
                  ),
                ),
                Expanded(child: Container()),
                Row(
                  children: [
                    FloatingActionButton(
                      backgroundColor: darkbrown,
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                settings(title: 'title'),
                          ),
                        );
                      },
                      child: Icon(Icons.settings),
                    ),
                    SizedBox(width: 10,),
                    FloatingActionButton(
                      backgroundColor: darkbrown,
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                settings(title: 'title'),
                          ),
                        );
                      },
                      child: Icon(Icons.menu_book),
                    ),
                  ],
                )
              ],
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
      return primary;
    case 1:
      return secondary;
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
