import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:model/screens/wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Model', home: Wrapper());
  }
}
