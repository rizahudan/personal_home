import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({required Key key, required String title}) : super(key: key);

  @override
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(
          width: 160,
          color: Colors.red,
        ),
        Container(
          width: 160,
          color: Colors.blue,
        ),
        Container(
          width: 160,
          color: Colors.green,
        ),
        Container(
          width: 160,
          color: Colors.yellow,
        ),
        Container(
          width: 160,
          color: Colors.orange,
        ),
      ],
    );
  }
}