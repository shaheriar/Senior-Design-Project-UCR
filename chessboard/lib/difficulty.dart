import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'assistmenu.dart';
import 'Color.dart';
import 'homepage.dart';

class difficulty extends StatefulWidget {
  difficulty({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _difficultyState createState() => _difficultyState();
}

class _difficultyState extends State<difficulty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFF747474),
      body: Stack(
        children: [
          GridView.builder(
            primary: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 11,
            ),
            itemBuilder: buildGridItems,
            itemCount: 77,
          ),
          Row(
            children: [
              FloatingActionButton(
                backgroundColor: darkbrown,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(CupertinoIcons.back),
              )
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MyButton(context, 'Easy', assists(title: '')),
                SizedBox(
                  height: 20,
                ),
                MyButton(context, 'Medium', assists(title: '')),
                SizedBox(
                  height: 20,
                ),
                MyButton(context, 'Hard', assists(title: '',))
              ],
            ),
          ),
        ],
      ),
    );
  }
}