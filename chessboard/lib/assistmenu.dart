import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'game.dart';
import 'Classes/Color.dart';
import 'homepage.dart';
import 'Classes/Assists.dart';

class assists extends StatefulWidget {
  assists({Key? key}) : super(key: key);

  @override
  _assistsState createState() => _assistsState();
}

class _assistsState extends State<assists> {
  bool recommended = false;
  bool available = false;
  bool illegal = false;
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
                      fixedSize: Size(350, 60),
                      primary: Colors.white,
                      backgroundColor: darkbrown,
                    ),
                    onPressed: () {
                      setState(() {
                        recommended = !recommended;
                      });
                    },
                    child: Text(
                      'Recommended Moves',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Transform.scale(
                    scale: 2,
                    child: Checkbox(

                      activeColor: darkbrown,
                      value: recommended,
                      onChanged: (bool? value) {
                        setState(() {
                          recommended = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      fixedSize: Size(350, 60),
                      primary: Colors.white,
                      backgroundColor: darkbrown,
                    ),
                    onPressed: () {
                      setState(() {
                        available = !available;
                      });
                    },
                    child: Text(
                      'Available Moves',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Transform.scale(
                    scale: 2,
                    child: Checkbox(
                      activeColor: darkbrown,
                      value: available,
                      onChanged: (bool? value) {
                        setState(() {
                          available = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      fixedSize: Size(350, 60),
                      primary: Colors.white,
                      backgroundColor: darkbrown,
                    ),
                    onPressed: () {
                      setState(() {
                        illegal = !illegal;
                      });
                    },
                    child: Text(
                      'Show Illegal Moves',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Transform.scale(
                    scale: 2,
                    child: Checkbox(
                      activeColor: darkbrown,
                      value: illegal,
                      onChanged: (bool? value) {
                        setState(() {
                          illegal = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              MyButton(context, 'Play', game(assists: Assists(available,recommended,illegal),)),
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
