import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Classes/Color.dart';
import 'game.dart';
import 'winsplash.dart';
import 'Classes/Assists.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

class historygame extends StatefulWidget {
  historygame({Key? key}) : super(key: key);

  @override
  _historygameState createState() => _historygameState();
}

class _historygameState extends State<historygame> {
  List<dynamic> boardlist = [];
  int index = -1;
  List<dynamic> gamestates = [
    [
      'r',
      'n',
      'b',
      'q',
      'k',
      'b',
      'n',
      'r',
      'p',
      'p',
      'p',
      'p',
      'p',
      'p',
      'p',
      'p',
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
      'P',
      'P',
      'P',
      'P',
      '.',
      'P',
      'P',
      'P',
      'R',
      'N',
      'B',
      'Q',
      'K',
      'B',
      'N',
      'R'
    ],
    [
      'r',
      'n',
      'b',
      'q',
      'k',
      'b',
      'n',
      'r',
      '.',
      'p',
      'p',
      'p',
      'p',
      'p',
      'p',
      'p',
      '.',
      '.',
      '.',
      '.',
      '.',
      '.',
      '.',
      '.',
      'p',
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
      'P',
      'P',
      'P',
      'P',
      '.',
      'P',
      'P',
      'P',
      'R',
      'N',
      'B',
      'Q',
      'K',
      'B',
      'N',
      'R'
    ],
    [
      'r',
      'n',
      'b',
      'q',
      'k',
      'b',
      'n',
      'r',
      '.',
      'p',
      'p',
      'p',
      'p',
      'p',
      'p',
      'p',
      '.',
      '.',
      '.',
      '.',
      '.',
      '.',
      '.',
      '.',
      'p',
      '.',
      '.',
      '.',
      '.',
      '.',
      '.',
      '.',
      '.',
      '.',
      'B',
      '.',
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
      'P',
      'P',
      'P',
      'P',
      '.',
      'P',
      'P',
      'P',
      'R',
      'N',
      'B',
      'Q',
      'K',
      '.',
      'N',
      'R'
    ],
    [
      'r',
      'n',
      'b',
      'q',
      'k',
      'b',
      'n',
      'r',
      '.',
      'p',
      'p',
      'p',
      'p',
      'p',
      'p',
      'p',
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
      '.',
      'B',
      '.',
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
      'P',
      'P',
      'P',
      'P',
      '.',
      'P',
      'P',
      'P',
      'R',
      'N',
      'B',
      'Q',
      'K',
      '.',
      'N',
      'R'
    ],
    [
      'r',
      'n',
      'b',
      'q',
      'k',
      'b',
      'n',
      'r',
      '.',
      'p',
      'p',
      'p',
      'p',
      'p',
      'p',
      'p',
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
      'Q',
      'p',
      '.',
      'B',
      '.',
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
      'P',
      'P',
      'P',
      'P',
      '.',
      'P',
      'P',
      'P',
      'R',
      'N',
      'B',
      '.',
      'K',
      '.',
      'N',
      'R'
    ],
    [
      'r',
      'n',
      'b',
      'q',
      'k',
      'b',
      'n',
      'r',
      '.',
      'p',
      'p',
      'p',
      'p',
      'p',
      'p',
      'p',
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
      'Q',
      '.',
      '.',
      'B',
      '.',
      'P',
      '.',
      '.',
      '.',
      'p',
      '.',
      '.',
      '.',
      '.',
      '.',
      '.',
      '.',
      'P',
      'P',
      'P',
      'P',
      '.',
      'P',
      'P',
      'P',
      'R',
      'N',
      'B',
      '.',
      'K',
      '.',
      'N',
      'R'
    ],
    [
      'r',
      'n',
      'b',
      'q',
      'k',
      'b',
      'n',
      'r',
      '.',
      'p',
      'p',
      'p',
      'p',
      'Q',
      'p',
      'p',
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
      'B',
      '.',
      'P',
      '.',
      '.',
      '.',
      'p',
      '.',
      '.',
      '.',
      '.',
      '.',
      '.',
      '.',
      'P',
      'P',
      'P',
      'P',
      '.',
      'P',
      'P',
      'P',
      'R',
      'N',
      'B',
      '.',
      'K',
      '.',
      'N',
      'R'
    ]
  ];



  @override
  void initState() {
    super.initState();
    _getAllCsvFiles();
    boardlist = List.from(defaultboard.reversed);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: primary,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Row(
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
            ],
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }

  Future<List<FileSystemEntity>> _getAllCsvFiles() async {
  final String directory = '../Game History';
  final path = "$directory/";
  print(path);
  final myDir = Directory(path);
  List<FileSystemEntity> _csvFiles;
  _csvFiles = myDir.listSync(recursive: true, followLinks: false);
  _csvFiles.sort((a, b) {
    return b.path.compareTo(a.path);
  });
  return _csvFiles;
}

  leftbutton() {
    return 
                  GestureDetector(
                    onTap: () {
                      if (index > 0) {
                        setState(() {
                          index--;
                          boardlist = gamestates[index];
                        });
                      } else {
                        setState(() {
                          index = -1;
                          boardlist = List.from(defaultboard.reversed);
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
                      if (index < gamestates.length) {
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

List<String> squares = [
  'a1',
  'b1',
  'c1',
  'd1',
  'e1',
  'f1',
  'g1',
  'h1',
  'a2',
  'b2',
  'c2',
  'd2',
  'e2',
  'f2',
  'g2',
  'h2',
  'a3',
  'b3',
  'c3',
  'd3',
  'e3',
  'f3',
  'g3',
  'h3',
  'a4',
  'b4',
  'c4',
  'd4',
  'e4',
  'f4',
  'g4',
  'h4',
  'a5',
  'b5',
  'c5',
  'd5',
  'e5',
  'f5',
  'g5',
  'h5',
  'a6',
  'b6',
  'c6',
  'd6',
  'e6',
  'f6',
  'g6',
  'h6',
  'a7',
  'b7',
  'c7',
  'd7',
  'e7',
  'f7',
  'g7',
  'h7',
  'a8',
  'b8',
  'c8',
  'd8',
  'e8',
  'f8',
  'g8',
  'h8',
];
