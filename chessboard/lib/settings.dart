import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'vsMenu.dart';
import 'settings.dart';
import 'history.dart';
import 'Classes/Color.dart';
import 'homepage.dart';

class settings extends StatefulWidget {
  settings({Key? key}) : super(key: key);

  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: FloatingActionButton(backgroundColor: darkbrown, onPressed: () => Navigator.pop(context), child: Icon(CupertinoIcons.back),),
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFF747474),
      body: Stack(
        children: [
          background(),
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                fixedSize: Size(300, 60),
                primary: Colors.white,
                backgroundColor: darkbrown,
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
