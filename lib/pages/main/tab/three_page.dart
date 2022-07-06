import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///页面3
class ThreePage extends StatefulWidget {
  const ThreePage({Key? key}) : super(key: key);

  @override
  State<ThreePage> createState() => _ThreePageState();
}

class _ThreePageState extends State<ThreePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('ThreePage')),
      body: SafeArea(
        child: Center(
          child: Text('three'),
        ),
      ),
    );
  }
}
