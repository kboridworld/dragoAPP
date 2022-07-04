import 'package:flutter/material.dart';

class FantasyFAB extends StatefulWidget {
  FantasyFAB({required this.subActions}) : assert(subActions.length > 0);
  final List<FantasyFABItem> subActions;
  @override
  _FantasyFABState createState() => _FantasyFABState(subActions: this.subActions);
}

class _FantasyFABState extends State<FantasyFAB> with SingleTickerProviderStateMixin {
  _FantasyFABState({this.subActions = const []});
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<Color?> _animateColor;
  late Animation<double> _animateIcon;
  late Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
  List<FantasyFABItem>? subActions;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateColor =
        ColorTween(begin: Color(0xFF0BC86C), end: Color(0xFF0BC86C)).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -0.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget toggle() {
    return FloatingActionButton(
      backgroundColor: _animateColor.value,
      onPressed: animate,
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        color: Colors.white,
        progress: _animateIcon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        for (int index = 0; index < this.subActions!.length; index++) ...[
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * (this.subActions!.length - index),
              0.0,
            ),
            child: GestureDetector(
              onTap: () {
                this.animate();
                if (this.subActions![index].onTap != null) {
                  this.subActions![index].onTap?.call();
                }
              },
              child: this.subActions![index].child,
            ),
          )
        ],
        toggle(),
      ],
    );
  }
}

class FantasyFABItem {
  FantasyFABItem({required this.child, this.onTap});
  final FloatingActionButton child;
  final VoidCallback? onTap;
}
