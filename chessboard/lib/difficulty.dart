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
  bool check = false;
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
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      fixedSize: Size(200, 60),
                      primary: check ? Colors.white : Colors.black,
                      backgroundColor: check ? Colors.black : Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        check = !check;
                      });
                    },
                    child: Text(
                      'Player Color',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ],
              ),
                SizedBox(
                  height: 20,
                ),
                MyButton(context, 'Easy', assists(human: 2, check: check)),
                SizedBox(
                  height: 20,
                ),
                MyButton(context, 'Medium', assists(human: 2, check: check)),
                SizedBox(
                  height: 20,
                ),
                MyButton(context, 'Hard', assists(human: 2, check: check))
              ],
            ),
          ),
        ],
      ),
    );
  }
}