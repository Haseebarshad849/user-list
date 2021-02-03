import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:model/screens/login.dart';
import 'package:model/screens/model.dart';
import 'package:model/services/auth.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ignore: deprecated_member_use
      home: StreamBuilder<User>(
        stream: AuthService().auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Model();
          } else {
            return LogIn();
          }
        },
      ),
    );
  }
}
