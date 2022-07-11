import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class countDown extends StatefulWidget {
  const countDown({Key? key}) : super(key: key);

  @override
  State<countDown> createState() => _countDownState();
}

class _countDownState extends State<countDown> {
  @override
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 5;

    void onEnd() {
      print('onEnd');
    }


 
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      CountdownTimer(
      endTime: endTime,
      onEnd: onEnd,
      ),
    );
  }
}