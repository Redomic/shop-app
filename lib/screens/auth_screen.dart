import 'dart:math';

import 'package:flutter/material.dart';


enum AuthMode {Signup, Login}

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(215, 188, 117, 1).withOpacity(0.9)
                ]
              )
            ),
          ),
        ],
      ),
    );
  }
}
