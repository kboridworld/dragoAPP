import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dragoma/common/ylz_page.dart';

///页面1
class OnePage extends YLZPage {
  OnePage({Key? key}) : super(key: key);

  @override
  YLZState<YLZPage> createYLZState() => _OnePageState();
}

class _OnePageState extends YLZState<OnePage> {
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
          child: Text('one'),
        ),
      ),
    );
  }
}
