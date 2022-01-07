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
  List<int> time = [5,10,15,20,30];
  int index = 0;
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
                TimeButton(),
                SizedBox(height: 20,),
                MyButton(context, 'vs Human', assists(human: 1,check: false,time: time[index])),
                SizedBox(height: 20,),
                MyButton(context, 'vs AI', difficulty(time: time[index])),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget TimeButton() {
  return TextButton(
    style: TextButton.styleFrom(
      fixedSize: Size(170, 50),
      primary: primary,
      backgroundColor: lightbrown,
    ),
    onPressed: () {
      setState(() {
        index = (index + 1) % time.length;
      });
    },
    child: Text(
      '${time[index]} minutes',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
  );
}
}
