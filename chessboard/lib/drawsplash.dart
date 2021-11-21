import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'Classes/Color.dart';

class drawSplash extends StatefulWidget {
  drawSplash({Key? key}) : super(key: key);

  @override
  _drawSplashState createState() => _drawSplashState();
}

class _drawSplashState extends State<drawSplash> {
  @override
  Widget build(BuildContext context) {
    return splash(context);
  }
}

splash(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.black87,
    body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StyledText('Accept Draw?'),
            SizedBox(height: 20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                    'Yes',
                    style: TextStyle(fontSize: 35),
                  ),
                ),
                SizedBox(width: 20,),
                TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: Size(200, 60),
                    primary: Colors.white,
                    backgroundColor: darkbrown,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'No',
                    style: TextStyle(fontSize: 35),
                  ),
                ),
              ],
            ),
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