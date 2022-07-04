import 'dart:ui' as ui;

import 'package:flutter/material.dart'
    show TextPainter, TextSpan, TextStyle, TextDirection, Size, Color;

///获取字体的宽高，放在size中
Size getTextWidth({String? text, double? fontsize}) {
  final textPainter = TextPainter(
    textDirection: TextDirection.ltr,
    text: TextSpan(
      text: text,
      style: TextStyle(fontSize: fontsize),
    ),
  );
  textPainter.layout();
  return Size(textPainter.width, textPainter.height);
}

///生成一个字体的形状，来画出来
ui.Paragraph getParagraph(
    {required String text, double? fontsize, Color? textColor, required Size textSize}) {
  ui.TextStyle ts = ui.TextStyle(color: textColor, fontSize: fontsize);

  //下面的代码是画text
  ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(ui.ParagraphStyle(
    textDirection: TextDirection.ltr,
  ))
    ..pushStyle(ts)
    ..addText(text);
  ui.Paragraph paragraph = paragraphBuilder.build()
    ..layout(ui.ParagraphConstraints(width: textSize.width));
  return paragraph;
}
