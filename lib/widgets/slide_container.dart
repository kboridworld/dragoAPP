import 'package:flutter/material.dart';

///带滑动动画效果的容器
class SlideContainer extends StatefulWidget {
  final bool isShow;
  final Widget child;
  final int duration; //旋转时间

  final double startTop;
  final double endTop;

  SlideContainer(
      {this.duration = 200,
      this.isShow = true,
      required this.child,
      required this.startTop,
      required this.endTop});

  @override
  State<StatefulWidget> createState() {
    return _SlideContainerState();
  }
}

class _SlideContainerState extends State<SlideContainer>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<EdgeInsetsGeometry> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));
    _animation = Tween(
            begin: EdgeInsets.only(top: widget.startTop),
            end: EdgeInsets.only(top: widget.endTop))
        .animate(_controller);
    _animation.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SlideContainer oldWidget) {
    if (widget.isShow) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _animation.value,
      child: widget.child,
    );
  }
}
