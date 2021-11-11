import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'Color.dart';


class WinSplash extends StatefulWidget {
  WinSplash({Key? key, required this.title, required this.win}) : super(key: key);
  final String title;
  bool win;

  @override
  _WinSplashState createState() => _WinSplashState(win);
}

class _WinSplashState extends State<WinSplash> {
  @override
  bool winner;
  _WinSplashState(this.winner);
  Widget build(BuildContext context) {
    return splash(context, winner);
  }
}

splash(BuildContext context, bool win) {
  return Material(
    color: Colors.black87,
    child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              win ? StyledText('Black Won!') : StyledText('White Won!'),
              TextButton(
                style: TextButton.styleFrom(
                  fixedSize: Size(200, 60),
                  primary: Colors.white,
                  backgroundColor: darkbrown,
                ),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text(
                  'Continue',
                  style: TextStyle(fontSize: 35),
                ),
              )
            ],
          )
      ),
  );
}

StyledText(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 50,
      color: Colors.white,
      fontWeight: FontWeight.bold
    ),
  );
}