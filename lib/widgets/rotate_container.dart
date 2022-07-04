import 'package:flutter/material.dart';

/// 旋转动画，旋转指定角度  动画 + Transform.rotate() 实现
class RotateContainer extends StatefulWidget {
  final double endAngle; // 旋转角度
  final bool reverse; //正/反旋转
  final Widget child;
  final int duration; //旋转时间

  RotateContainer(
      {this.endAngle = 180,
      this.duration = 200,
      this.reverse = false,
      required this.child});

  @override
  State<StatefulWidget> createState() {
    return _RotateContainer();
  }
}

class _RotateContainer extends State<RotateContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double angle = 0;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));
    _animation = Tween(begin: 0.0, end: widget.endAngle).animate(_controller)
      ..addListener(() {
        setState(() {
          angle = _animation.value;
        });
      });
    super.initState();
  }

  @override
  void didUpdateWidget(RotateContainer oldWidget) {
    if (oldWidget.reverse == widget.reverse) {
      return; //减少绘制
    }
    if (widget.reverse) {
      _controller.reverse(); //反向旋转
    } else {
      _controller.forward(); //正向旋转
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
    return Transform.rotate(
      angle: angle,
      child: widget.child,
    );
  }
}
