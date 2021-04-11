import 'package:universal_io/io.dart';

import 'package:application/constants.dart';
import 'package:application/dashboard.dart';
import 'package:application/sign_in.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Sign_in(),
    );
  }
}
