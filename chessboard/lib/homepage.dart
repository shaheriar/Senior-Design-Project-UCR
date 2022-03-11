import 'package:flutter/material.dart';
import 'vsMenu.dart';
import 'settings.dart';
import 'history.dart';
import 'Classes/Color.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: secondary,
      body: Center(
        child: Stack(
          children: [
            background(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child: Container()),
                title(),
                SizedBox(height: 20,),
                playbutton(),
                Expanded(child: Container()),
                Row(
                  children: [
                    //settingsbutton(),
                    SizedBox(width: 10,),
                    historybutton(),
                    Expanded(child: Container()),
                    Text('By: The Segfaults',style: TextStyle(fontSize: 20, color: Colors.white),),
                    SizedBox(width: 20,)
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  title() {
    return Text(
      'Smart Chessboard',
      style: TextStyle(
        color: Colors.white,
        fontSize: 80,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  playbutton() {
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
                vsMenu(title: 'title'),
          ),
        );
      },
      child: Text(
        'Play',
        style: TextStyle(fontSize: 35),
      ),
    );
  }

  settingsbutton() {
    return FloatingActionButton(
      heroTag: "SETTINGS",
      backgroundColor: darkbrown,
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => settings(),
          ),
        );
      },
      child: Icon(Icons.settings),
    );
  }

  historybutton() {
    return FloatingActionButton(
      heroTag: "HISTORY",
      backgroundColor: darkbrown,
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => history(),
          ),
        );
      },
      child: Icon(Icons.menu_book),
    );
  }
}

Widget background() {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 11,
    ),
    itemBuilder: buildGridItems,
    itemCount: 88,
  );
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

Widget buildGridItems(BuildContext context, int index) {
  return GridTile(
    child: Container(
      width: 50,
      height: 50,
      color: getcolor(index),
    ),
  );
}
