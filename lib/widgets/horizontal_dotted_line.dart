import 'package:flutter/material.dart';

///
/// 横着的虚线
class HorizontalDottedLine extends StatelessWidget {
  final Color color;
  final double width;

  const HorizontalDottedLine({this.color = Colors.black, this.width = 0.5});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.constrainWidth();
        final dashWidth = 4.0;
        final dashCount = (width / (2 * dashWidth)).floor();

        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              height: width,
              width: dashWidth,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
