import 'package:flutter/material.dart';
import 'package:dragoma/utils/ui_utils.dart';

class BounceTap extends StatefulWidget {
  final VoidCallback? onPressed;
  final HitTestBehavior? behavior;
  final Widget child;
  final double scale;

  const BounceTap({
    Key? key,
    this.onPressed,
    required this.child,
    this.behavior,
    double scale = 0.95,
  })  : scale = scale <= 0 || scale >= 1 ? 0.95 : scale,
        super(key: key);

  @override
  _BounceTapState createState() {
    return _BounceTapState();
  }
}

class _BounceTapState extends State<BounceTap> {
  double _scale = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: widget.behavior,
      onTapDown: (TapDownDetails details) {
        setState(() {
          _scale = widget.scale;
        });
      },
      onTapUp: (TapUpDetails details) {
        setState(() {
          _scale = 1;
        });
      },
      onTapCancel: () {
        setState(() {
          _scale = 1;
        });
      },
      onTap: () => throttle(() {
        widget.onPressed?.call();
      }),
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}
