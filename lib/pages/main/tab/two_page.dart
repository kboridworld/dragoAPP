import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dragoma/common/ylz_page.dart';

///页面2
class TwoPage extends YLZPage {
  TwoPage({Key? key}) : super(key: key);

  @override
  YLZState<YLZPage> createYLZState() => _TwoPageState();
}

class _TwoPageState extends YLZState<TwoPage> {
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
          child: Text('two'),
        ),
      ),
    );
  }
}
