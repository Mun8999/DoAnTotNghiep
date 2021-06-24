import 'package:flutter/material.dart';

class InteractiveDemo extends StatefulWidget {
  const InteractiveDemo({Key? key}) : super(key: key);

  @override
  _InteractiveDemoState createState() => _InteractiveDemoState();
}

class _InteractiveDemoState extends State<InteractiveDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.green,
      child: InteractiveViewer(
        minScale: 0.5,
        child: Container(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.red,
                image: DecorationImage(
                    image: AssetImage('assets/FB_IMG_1619035803604.jpg'),
                    fit: BoxFit.contain))),
      ),
    ));
  }
}
