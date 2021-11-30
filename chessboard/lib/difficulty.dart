import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'assistmenu.dart';
import 'Classes/Color.dart';
import 'homepage.dart';

class difficulty extends StatefulWidget {
  difficulty({Key? key}) : super(key: key);

  @override
  _difficultyState createState() => _difficultyState();
}

class _difficultyState extends State<difficulty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFF747474),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: FloatingActionButton(backgroundColor: darkbrown, onPressed: () => Navigator.pop(context), child: Icon(CupertinoIcons.back),),
      body: Stack(
        children: [
          background(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MyButton(context, 'Easy', assists()),
                SizedBox(
                  height: 20,
                ),
                MyButton(context, 'Medium', assists()),
                SizedBox(
                  height: 20,
                ),
                MyButton(context, 'Hard', assists())
              ],
            ),
          ),
        ],
      ),
    );
  }
}