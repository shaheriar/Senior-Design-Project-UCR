import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'difficulty.dart';
import 'assistmenu.dart';
import 'Classes/Color.dart';
import 'homepage.dart';

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
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: FloatingActionButton(backgroundColor: darkbrown, onPressed: () => Navigator.pop(context), child: Icon(CupertinoIcons.back),),
      body: Stack(
        children: [
          background(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MyButton(context, 'vs Human', assists(human: 1,check: false,)),
                SizedBox(
                  height: 20,
                ),
                MyButton(context, 'vs AI', difficulty())
              ],
            ),
          ),
        ],
      ),
    );
  }
}