import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              getFlatButton(color: Colors.red, soundNumber: 1),
              getFlatButton(color: Colors.orange, soundNumber: 2),
              getFlatButton(color: Colors.yellow, soundNumber: 3),
              getFlatButton(color: Colors.green, soundNumber: 4),
              getFlatButton(color: Colors.blue, soundNumber: 5),
              getFlatButton(color: Colors.indigo, soundNumber: 6),
              getFlatButton(color: Colors.purple, soundNumber: 7),
            ],
          ),
        ),
      ),
    );
  }

  Widget getFlatButton({Color color, int soundNumber}) {
    return Expanded(
      child: FlatButton(
        color: color,
        child: Container(
          width: double.infinity,
        ),
        onPressed: () {
          final player = AudioCache();
          player.play('note$soundNumber.wav');
        },
      ),
    );
  }
}
