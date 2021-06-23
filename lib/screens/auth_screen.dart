import 'dart:math';

import 'package:flutter/material.dart';


enum AuthMode {Signup, Login}

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[],
      ),
    );
  }
}
