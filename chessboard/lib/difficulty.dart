import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'assistmenu.dart';
import 'Classes/Color.dart';
import 'homepage.dart';

class difficulty extends StatefulWidget {
  difficulty({Key? key, required int this.time}) : super(key: key);
  int time;

  @override
  _difficultyState createState() => _difficultyState(time);
}

class _difficultyState extends State<difficulty> {
  bool check = false;
  int time = 0;

  _difficultyState(int t) {
    time = t;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFF747474),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: darkbrown,
        onPressed: () => Navigator.pop(context),
        child: Icon(CupertinoIcons.back),
      ),
      body: Stack(
        children: [
          background(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                colorpicker(),
                SizedBox(height: 20,),
                MyButton(context, 'Easy', assists(human: 2, check: check, time: time)),
                SizedBox(height: 20,),
                MyButton(context, 'Medium', assists(human: 3, check: check, time: time)),
                SizedBox(height: 20,),
                MyButton(context, 'Hard', assists(human: 4, check: check, time: time))
              ],
            ),
          ),
        ],
      ),
    );
  }

  colorpicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Player Color:',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 35, color: Colors.white),
        ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: darkbrown, width: 2),
              borderRadius: BorderRadius.circular(5),
              color: check ? Colors.black : Colors.white,
            ),
            height: 60,
            width: 60,
          ),
          onTap: () {
            setState(() {
              check = !check;
            });
          },
        ),
      ],
    );
  }
}
