import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dragoma/common/ylz_page.dart';

///页面3
class ThreePage extends YLZPage {
  ThreePage({Key? key}) : super(key: key);

  @override
  YLZState<YLZPage> createYLZState() => _ThreePageState();
}

class _ThreePageState extends YLZState<ThreePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Text('three'),
        ),
      ),
    );
  }
}
