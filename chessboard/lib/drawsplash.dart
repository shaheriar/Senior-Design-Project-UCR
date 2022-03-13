import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Classes/Color.dart';

class DrawSplash extends StatefulWidget {
  DrawSplash({Key? key, required this.status}) : super(key: key);
  String status;

  @override
  _DrawSplashState createState() => _DrawSplashState(status);
}

class _DrawSplashState extends State<DrawSplash> {
  @override
  String status = "";
  _DrawSplashState(String stat) {
    status = stat;
  }
  Widget build(BuildContext context) {
    return splash(status);
  }
  splash(String status) {
  return Scaffold(
    backgroundColor: Colors.black,
    body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StyledText('${status}!'),
              SizedBox(height: 20,),
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