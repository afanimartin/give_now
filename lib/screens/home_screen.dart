import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Givenow',
            style: TextStyle(
                color: Colors.black, fontSize: 28, letterSpacing: 1.2),
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {})
          ],
        ),
      );
}
