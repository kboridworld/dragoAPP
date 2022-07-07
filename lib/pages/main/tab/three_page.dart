import 'package:dragoma/common/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///页面3
class ThreePage extends StatefulWidget {
  const ThreePage({Key? key}) : super(key: key);

  @override
  State<ThreePage> createState() => _ThreePageState();
}

class _ThreePageState extends State<ThreePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: ColorValues.background,
      body: SafeArea(
        child: Center(
          child: Text('three'),
        ),
      ),
    );
  }
}
