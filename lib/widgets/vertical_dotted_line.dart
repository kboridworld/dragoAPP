import 'package:flutter/material.dart';

///
/// 竖着的虚线
class VerticalDottedLine extends StatelessWidget {
  final Color color;
  final double width;
  final double dashWidth;
  final Axis direction;

  const VerticalDottedLine(
      {this.color = Colors.black,
      this.width = 0.5,
      this.dashWidth = 4.0,
      this.direction = Axis.vertical});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final height = constraints.constrainHeight();
        final dashCount = (height / (2 * dashWidth)).floor();

        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: 0.5,
              height: dashWidth,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: direction,
        );
      },
    );
  }
}
