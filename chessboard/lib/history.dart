import 'dart:convert';
import 'package:chessboard/historygame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'Classes/Color.dart';
import 'homepage.dart';

class history extends StatefulWidget {
  history({Key? key}) : super(key: key);

  @override
  _historyState createState() => _historyState();
}

class _historyState extends State<history> {
 final _channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:8765'),
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _channel.sink.add('History');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFF747474),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: darkbrown,
        onPressed: () => Navigator.pop(context),
        child: Icon(CupertinoIcons.back),
      ),
      body: Stack(
        children: [
          background(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              title(),
              gameList(),
            ],
          ),
        ],
      ),
    );
  }

  title() {
    return Column(
      children: [
        Text(
          'History',
          style: TextStyle(
            color: Colors.white,
            fontSize: 80,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  gameList() {
    return StreamBuilder(
      stream: _channel.stream,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator(),);
        }
        print(snapshot.data);
        var data = jsonDecode(snapshot.data.toString());
        List<dynamic> gameslist = data["history"];
        gameslist = List.from(gameslist.reversed);
        return SizedBox(
          height: MediaQuery.of(context).size.height - 135,
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: gameslist.length,
            itemBuilder: (BuildContext context, int index) {
              String date = gameslist[index].toString().substring(0,10);
              String time = gameslist[index].toString().substring(11,19);
              time = time.replaceAll('-',':');
              date = date.replaceAll('-','/');
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: Size(300, 100),
                    primary: Colors.white,
                    backgroundColor: darkbrown,
                  ),
                  onPressed: () {
                    Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => historygame(name: gameslist[index]),
              ),
            );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Text(
                          '${index+1}',
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Text(
                          date,
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Text(
                          time,
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }
    );
  }
}
