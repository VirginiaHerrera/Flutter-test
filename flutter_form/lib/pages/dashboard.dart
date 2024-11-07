import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  static String id = "dashboard_page";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('Hello, you are in your dashboard!'),
        ),
      ),
    );
  }
}
