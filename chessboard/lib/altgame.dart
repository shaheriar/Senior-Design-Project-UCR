import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Classes/Color.dart';
import 'drawsplash.dart';
import 'winsplash.dart';
import 'Classes/Assists.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class altgame extends StatefulWidget {
  altgame({Key? key, required this.assists, required this.time}) : super(key: key);
  Assists assists;
  int time;

  @override
  _altgameState createState() => _altgameState(assists, time);
}

class _altgameState extends State<altgame> {
  final _channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:8765'),
  );
  var bmin;
  var bsec;
  var wmin;
  var wsec;
  bool flag = false;
  bool winner = false;
  ScrollController _scrollControllerw = ScrollController();
  ScrollController _scrollControllerb = ScrollController();
  List<String> moves = [];
  Assists inf = Assists(false, false, 0, false);

  _altgameState(Assists assists, int time) {
    inf = assists;
    bmin = time;
    wmin = time;
    flag = (time == -1);
    bsec = 0;
    wsec = 0;
  }
  _scrollw() {
    _scrollControllerw.jumpTo(_scrollControllerw.position.maxScrollExtent);
  }

  _scrollb() {
    _scrollControllerb.jumpTo(_scrollControllerb.position.maxScrollExtent);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: primary,
      body: Container(
        child: Stack(
          children: [
            Row(
              children: [
                Container(width: MediaQuery.of(context).size.width/2 - 5,color: lightbrown,),
                Container(
                width: 10,
                color: primary,
              ),
                Container(width: MediaQuery.of(context).size.width/2 - 5,color: darkbrown,)
              ],
            ),
            Column(
              children: [
                times(),
                Container(height: 10, color: primary),
                moveslist(),
                Expanded(child: Container(),),
                buttons(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  times() {
    return StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          if (moves.length % 2 == 0) {
            whitetime();
            winner = false;
          } else {
            blacktime();
            winner = true;
          }
          if (bsec == 0 && bmin == 0) {
            _channel.sink.add('Time');
            flag = true;
            winner = flag;
            Future.delayed(Duration.zero, () async {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (context, animation1, animation2) =>
                      WinSplash(win: true),
                ),
              );
            });
          } else if (wsec == 0 && wmin == 0) {
            _channel.sink.add('Time');
            flag = true;
            winner = !flag;
            Future.delayed(Duration.zero, () async {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (context, animation1, animation2) =>
                      WinSplash(win: false),
                ),
              );
            });
          }
          return Row(
            children: [
              Container(
                color: lightbrown,
                width: MediaQuery.of(context).size.width / 2 - 5,
                child: Center(
                  child: Text(
                    formattime(wmin, wsec),
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 8,
                        color: primary),
                  ),
                ),
              ),
              Container(
                width: 10,
                color: primary,
              ),
              Container(
                color: darkbrown,
                width: MediaQuery.of(context).size.width / 2 - 5,
                child: Center(
                  child: Text(
                    formattime(bmin, bsec),
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 8,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        });
  }

  moveslist() {
    return StreamBuilder(
        stream: _channel.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = jsonDecode(snapshot.data.toString());
            if (data["move"] != null) {
              if (moves.length > 0) {
                if (moves[moves.length - 1] != data["move"]) {
                  moves.add(data["move"]);
                }
              } else {
                moves.add(data["move"]);
              }
            }
            if (data["status"] != null) {
              String status = data["status"];
              if (status == "checkmate" ||
                  status == "stalemate" ||
                  status == "repetition") {
                flag = true;
                if (status == "checkmate") {
                  WidgetsBinding.instance!.addPostFrameCallback(
                    (_) => Navigator.push(
                      context,
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (context, animation1, animation2) =>
                            WinSplash(win: moves.length % 2 != 0),
                      ),
                    ),
                  );
                } else {
                  WidgetsBinding.instance!.addPostFrameCallback(
                    (_) => Navigator.push(
                      context,
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (context, animation1, animation2) =>
                            DrawSplash(status: status),
                      ),
                    ),
                  );
                }
              }
            }
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  color: lightbrown,
                  width: MediaQuery.of(context).size.width / 2 - 5,
                  height: MediaQuery.of(context).size.height - 190,
                  child: ListView.builder(
                    controller: _scrollControllerw,
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: moves.length,
                    itemBuilder: (context, index) {
                      _scrollw();
                      return Center(child: getMove(true, index));
                    },
                  ),
                ),
              ),
              Container(
                width: 10,
                color: primary,
              ),
              Expanded(
                child: Container(
                  color: darkbrown,
                  width: MediaQuery.of(context).size.width / 2 - 5,
                  height: MediaQuery.of(context).size.height - 190,
                  child: ListView.builder(
                    controller: _scrollControllerb,
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: moves.length,
                    itemBuilder: (context, index) {
                      _scrollb();
                      return Center(child: getMove(false, index));
                    },
                  ),
                ),
              ),
            ],
          );
        });
  }

  buttons() {
    return Container(
      color: primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          offerdraw(),
          altresignbutton(),
        ],
      ),
    );
  }

  whitetime() {
    if (!flag) {
      wsec--;
      if (wsec < 0) {
        wsec = 59;
        wmin--;
      }
    }
  }

  blacktime() {
    if (!flag) {
      bsec--;
      if (bsec < 0) {
        bsec = 59;
        bmin--;
      }
    }
  }

  formattime(int min, int sec) {
    if (flag) {
      return "???:???";
    }
    if (sec < 10) {
      if (min < 10) {
        return "0$min:0$sec";
      }
      return "$min:0$sec";
    } else {
      if (min < 10) {
        return "0$min:$sec";
      }
      return "$min:$sec";
    }
  }

  Widget getMove(bool p, int index) {
    if (p) {
      if (index % 2 == 0) {
        return Text(
          moves[index],
          style: TextStyle(fontSize: 100, color: primary),
        );
      } else {
        return Container();
      }
    } else {
      if (index % 2 == 1) {
        return Text(
          moves[index],
          style: TextStyle(fontSize: 100, color: Colors.white),
        );
      } else {
        return Container();
      }
    }
  }

  Widget altresignbutton() {
    return TextButton(
      style: TextButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width / 3,
            MediaQuery.of(context).size.height / 8),
        primary: Colors.white,
        backgroundColor: primary,
      ),
      onPressed: () {
        _channel.sink.add('Resign');
        Navigator.push(
          context,
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, animation1, animation2) =>
                WinSplash(win: winner),
          ),
        );
      },
      child: Text(
        'Resign',
        style: TextStyle(fontSize: MediaQuery.of(context).size.width / 16),
      ),
    );
  }

  Widget offerdraw() {
    return TextButton(
      style: TextButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width / 3,
            MediaQuery.of(context).size.height / 8),
        primary: Colors.white,
        backgroundColor: primary,
      ),
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, animation1, animation2) => splash(),
          ),
        );
      },
      child: Text(
        'Offer Draw',
        style: TextStyle(fontSize: MediaQuery.of(context).size.width / 16),
      ),
    );
  }

  splash() {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StyledText('Accept Draw?'),
          SizedBox(
            height: 20,
          ),
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
                  _channel.sink.add('Draw');
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text(
                  'Yes',
                  style: TextStyle(fontSize: 35),
                ),
              ),
              SizedBox(
                width: 20,
              ),
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
      )),
    );
  }

  StyledText(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}
