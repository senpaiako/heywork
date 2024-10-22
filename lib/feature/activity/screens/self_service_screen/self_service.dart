import 'package:flutter/material.dart';

class SelfService extends StatelessWidget {
  const SelfService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
          child: Text('Self Service Screen',
              style: TextStyle(color: Colors.white, fontSize: 24))),
    );
  }
}
