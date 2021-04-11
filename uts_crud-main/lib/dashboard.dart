import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  // Initial variable String
  final em;
  final ps;
  // Map<String, String> data = {"jkt":"jakarta","bdg":"Bandung"};

// Get Key Data
  Dashboard({Key key, this.em, this.ps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Dashboard")),
        body: Center(
          child: RaisedButton(
              onPressed: () {
                Navigator.pop(context); //untuk kembali ke halaman sebelumnya
              },
              child: Text("Email = " + em + " Password = " + ps)),
        ));
  }
}
