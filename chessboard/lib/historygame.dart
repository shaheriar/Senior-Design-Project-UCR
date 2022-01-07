import 'dart:convert';
import 'package:flutter/material.dart';
import 'Classes/Color.dart';
import 'game.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class historygame extends StatefulWidget {
  historygame({Key? key, required String this.name}) : super(key: key);
  String name;

  @override
  _historygameState createState() => _historygameState(name);
}

class _historygameState extends State<historygame> {
  String boardlist = '';
  int index = -1;
  var gamestates;
  String name = '';
  final _channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:8765'),
  );

  _historygameState(String name) {
    this.name = name;
  }

  @override
  void initState() {
    super.initState();
    _channel.sink.add(name);
    boardlist = List.from(defaultboard.reversed).join("");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: primary,
        body: StreamBuilder(
            stream: _channel.stream,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return loadingview();
              }
              gamestates = json.decode(snapshot.data.toString());
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    leftbutton(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        chessboard(),
                        exit(),
                      ],
                    ),
                    rightbutton()
                  ],
                ),
              );
            }),
      ),
      onWillPop: () async => false,
    );
  }

  loadingview() {
    return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20,),
                      exit()
                    ],
                  ),
                );
  }

  leftbutton() {
    return GestureDetector(
      onTap: () {
        if (index > 0) {
          setState(() {
            index--;
            boardlist = gamestates[index];
          });
        } else {
          setState(() {
            index = -1;
            boardlist = List.from(defaultboard.reversed).join("");
          });
        }
        print('PREVIOUS STATE');
      },
      child: Container(
        color: lightbrown,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width / 5,
        child: Center(
            child: Icon(
          Icons.arrow_back_ios,
          size: 100,
        )),
      ),
    );
  }

  rightbutton() {
    return GestureDetector(
      onTap: () {
        if (index < gamestates.length - 1) {
          setState(() {
            index++;
            boardlist = gamestates[index];
          });
        }
        print('NEXT STATE');
      },
      child: Container(
        color: darkbrown,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width / 5,
        child: Center(
            child: Icon(
          Icons.arrow_forward_ios,
          size: 100,
        )),
      ),
    );
  }

  Widget chessboard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.width / 2,
          width: 10,
          child: ListView.builder(
              itemCount: 8,
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                int i = index + 1;
                return Container(
                  height: (MediaQuery.of(context).size.width / 2) / 8,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '$i',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width / 2,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                ),
                itemBuilder: _buildGridItems,
                itemCount: 64,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 20,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    String c = String.fromCharCode(index + 97);
                    return SizedBox(
                      width: (MediaQuery.of(context).size.width / 2) / 8,
                      child: Center(
                        child: Text(
                          '$c',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.width / 2,
          width: 10,
          child: ListView.builder(
              itemCount: 8,
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                int i = index + 1;
                return Container(
                  height: (MediaQuery.of(context).size.width / 2) / 8,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '$i',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget _buildGridItems(BuildContext context, int index) {
    return GridTile(
      child: Stack(
        children: [
          Container(
            width: 90,
            height: 90,
            color: getcolor(index),
          ),
          Center(child: getpiece(boardlist[index].toString())),
        ],
      ),
    );
  }

  translate(int n) {
    int j = (n / 8).floor();
    int k = n % 8;
    int h = 64 - (8 - k) - (8 * j);
    return h;
  }

  Widget getMove(bool p, int index) {
    if (p) {
      if (index % 2 == 0) {
        return Text(
          moves[index],
          style: TextStyle(fontSize: 50, color: primary),
        );
      } else {
        return Container();
      }
    } else {
      if (index % 2 == 1) {
        return Text(
          moves[index],
          style: TextStyle(fontSize: 50, color: Colors.white),
        );
      } else {
        return Container();
      }
    }
  }

  Widget exit() {
    return TextButton(
      style: TextButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width / 4 - 20,
            MediaQuery.of(context).size.height / 10),
        primary: Colors.white,
        backgroundColor: buttoncolor,
      ),
      onPressed: () {
        Navigator.popUntil(context, (route) => route.isFirst);
      },
      child: Text(
        'Exit',
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}

List<String> defaultboard = [
  'R',
  'N',
  'B',
  'K',
  'Q',
  'B',
  'N',
  'R',
  'P',
  'P',
  'P',
  'P',
  'P',
  'P',
  'P',
  'P',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  '.',
  'p',
  'p',
  'p',
  'p',
  'p',
  'p',
  'p',
  'p',
  'r',
  'n',
  'b',
  'k',
  'q',
  'b',
  'n',
  'r'
];