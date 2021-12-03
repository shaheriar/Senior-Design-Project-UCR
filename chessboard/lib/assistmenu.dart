import 'package:chessboard/sync.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Classes/Color.dart';
import 'homepage.dart';
import 'Classes/Assists.dart';

class assists extends StatefulWidget {
  int human = 0;
  bool check = false;
  assists({Key? key, required this.human, required this.check}) : super(key: key);

  @override
  _assistsState createState() => _assistsState(human, check);
}

class _assistsState extends State<assists> {
  bool b = false; //black recommended
  bool w = false; //white recommended
  int h = 0; //vs human or ai
  bool check = false;
  _assistsState(int human, bool check) {
    this.h = human;
    this.check = check;
  }
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'AI Assists',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      fixedSize: Size(360, 60),
                      primary: Colors.white,
                      backgroundColor: darkbrown,
                    ),
                    onPressed: () {
                    },
                    child: Text(
                      'Recommended Moves',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Column(
                    children: [
                      h == 1 ? Text('Player 1',style: TextStyle(color: Colors.white),) : Container(),
                      SizedBox(height: 5,),
                      Transform.scale(
                        scale: 2,
                        child: Checkbox(
                          activeColor: darkbrown,
                          value: w,
                          onChanged: (bool? value) {
                            setState(() {
                              w = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20,),
                  h == 1 ? Column(
                    children: [
                      Text('Player 2',style: TextStyle(color: Colors.white),),
                      SizedBox(height: 5,),
                      Transform.scale(
                        scale: 2,
                        child: Checkbox(
                          activeColor: darkbrown,
                          value: b,
                          onChanged: (bool? value) {
                            setState(() {
                              b = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ) : Container(),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              MyButton(context, 'Play', syncgame(assists: Assists(w,b,h,check),)),
            ],
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
