import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'altgame.dart';
import 'game.dart';
import 'homepage.dart';
import 'Classes/Color.dart';
import 'winsplash.dart';
import 'Classes/Assists.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class syncgame extends StatefulWidget {
  syncgame({Key? key, required this.assists}) : super(key: key);
  Assists assists;

  @override
  _syncgameState createState() => _syncgameState(assists);
}

class _syncgameState extends State<syncgame> {
    final _channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:8765'),
  );
  var start;
  List<String> moves=[];
  Assists inf = Assists(false, false, 0);

  _syncgameState(Assists assists) {
    inf = assists;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String json = jsonEncode(inf.toJson());
    _channel.sink.add(json);
    return altgame(assists: inf);
  }
}