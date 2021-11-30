import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'drawsplash.dart';
import 'game.dart';
import 'homepage.dart';
import 'Classes/Color.dart';
import 'winsplash.dart';
import 'Classes/Assists.dart';
import 'package:intl/intl.dart';

class altgame extends StatefulWidget {
  altgame({Key? key, required this.assists}) : super(key: key);
  Assists assists;

  @override
  _altgameState createState() => _altgameState();
}

class _altgameState extends State<altgame> {
  var start;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start = DateTime.now().add(const Duration(minutes: 30));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: primary,
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              info(true, moves),
              Container(width: 10,color: primary,),
              info(false, moves),
            ],
          ),
          Column(
            children: [
              Expanded(child: Container()),
              offerdraw(context),
              SizedBox(height: 10,),
              altresignbutton(context),
              SizedBox(height: 20,),
            ],
          ),
        ],
      ),
    );
  }

  whitetime() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(start.add(const Duration(minutes: -20, seconds: -5)).difference(DateTime.now()).inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(start.add(const Duration(minutes: -20,seconds: -5)).difference(DateTime.now()).inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  blacktime() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(start.difference(DateTime.now()).inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(start.difference(DateTime.now()).inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Widget info(bool p, List<String> moveslist) {
    return Container(
      color: p ? lightbrown : darkbrown,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2 - 5,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                whitetime();
                blacktime();
                return Text(
                  p ? whitetime() : blacktime(),
                  style: TextStyle(fontSize: 200, color: p ? primary : Colors.white),
                );
              }
            ),
            Container(height: 10,color: primary),
            Expanded(
              child: ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: moves.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      p ? Text('$index. ',style: TextStyle(fontSize: 50, color: p ? primary : Colors.white),) : Container(),
                      Expanded(child: Container(),),
                      Text(
                        moveslist[index],
                        style: TextStyle(fontSize: 100, color: p ? primary : Colors.white),
                      ),
                      Expanded(child: Container(),),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> moves = [
  'Na6',
  'a3',
  'O-O',
  'e6',
  'Qc4',
  'Bh6',
  'a3',
  'O-O',
  'e6',
  'Qc4',
  'Bh6'
];

Widget altresignbutton(BuildContext context) {
  return TextButton(
    style: TextButton.styleFrom(
      fixedSize: Size(300, 60),
      primary: Colors.white,
      backgroundColor: primary,
    ),
    onPressed: () {
      Navigator.push(
        context,
        PageRouteBuilder(
          opaque: false,
          pageBuilder: (context, animation1, animation2) =>
              WinSplash(win: false),
        ),
      );
    },
    child: Text(
      'Resign',
      style: TextStyle(fontSize: 35),
    ),
  );
}

Widget offerdraw(BuildContext context) {
  return TextButton(
    style: TextButton.styleFrom(
      fixedSize: Size(300, 60),
      primary: Colors.white,
      backgroundColor: primary,
    ),
    onPressed: () {
      Navigator.push(
        context,
        PageRouteBuilder(
          opaque: false,
          pageBuilder: (context, animation1, animation2) =>
              drawSplash(),
        ),
      );
    },
    child: Text(
      'Offer Draw',
      style: TextStyle(fontSize: 35),
    ),
  );
}
