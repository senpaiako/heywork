import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
          child: Text('Profile Screen',
              style: TextStyle(color: Colors.white, fontSize: 24))),
    );
  }
}
