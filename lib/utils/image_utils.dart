import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:lib_ylz_utils_package/lib_ylz_utils_package.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dragoma/common/res/styles.dart';
import 'package:dragoma/utils/platform_utils.dart';

class ImageWaterUtils {
  static Future<File> getFile(String urlImage, BuildContext context,
      String? address, String? dateTimes) async {
    /// 图片记录仪
    var pictureRecorder = new ui.PictureRecorder();

    ///canvas接受一个图片记录仪
    var canvas = new Canvas(pictureRecorder);

    /// 使用方法获取Unit8List格式的图片
    // var targetImage = await loadImage(targetImgName, false);
    var targetImage = await loadImage(urlImage, true);

    print(
        '屏幕尺寸:---${MediaQuery.of(context).size.width.toInt()}-----${MediaQuery.of(context).size.height.toInt()}');
    print('原始如尺寸:---${targetImage.width}-----${targetImage.height}');

    var compressImg = targetImage;

    /// 压缩
    // if(targetImage.width > MediaQuery.of(context).size.width * 2){
    //   compressImg = await compressImage(targetImgName);
    // }

    /// 绘制图片
    canvas.drawImage(compressImg, Offset(0, 0), Paint());

    /// 文字大小系数
    double txtSize = targetImage.width / MediaQuery.of(context).size.width;

    /// 绘制文字
    ui.ParagraphBuilder pb = ui.ParagraphBuilder(
      ui.ParagraphStyle(
          textAlign: TextAlign.left,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 14.0 * txtSize),
    );
    pb.pushStyle(ui.TextStyle(color: Colors.white));
    dateTimes = '${address.isNotTextEmpty ? "\n" : ""}${dateTimes ?? ''}';

    pb.addText(address ?? "");
    pb.addText(dateTimes);

    /// 设置文本的宽度约束
    ParagraphConstraints pc =
        ui.ParagraphConstraints(width: compressImg.width.toDouble());
    ui.Paragraph paragraph = pb.build()..layout(pc);

    /// 绘制参数
    Paint _linePaint = new Paint()
      ..color = ColorValues.summaryText
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 30.0;

    /// 动态计算文本高度
    String totalString = (address ?? "") + dateTimes;
    double maxWidth = targetImage.width.toDouble();
    double scrWidth = MediaQuery.of(context).size.width;
    double textHeight = calculateTextHeight(context, totalString,
        14.0 * txtSize, FontWeight.w400, maxWidth - 10 * txtSize, 4);
    print("$maxWidth,$scrWidth");

    /// 绘制背景
    canvas.drawRect(
        Rect.fromLTWH(0, compressImg.height.toDouble() - textHeight,
            compressImg.width.toDouble(), textHeight),
        _linePaint);

    /// 绘制文字
    canvas.drawParagraph(paragraph,
        Offset(10 * txtSize, compressImg.height.toDouble() - textHeight));

    /// 设置生成图片的宽和高
    var picture = await pictureRecorder
        .endRecording()
        .toImage(compressImg.width, compressImg.height);
    var pngImageBytes =
        await picture.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = pngImageBytes!.buffer.asUint8List();

    /// 生成file文件
    final Directory _directory = await getTemporaryDirectory();
    final Directory _imageDirectory =
        await new Directory('${_directory.path}/image/')
            .create(recursive: true);
    String _targetPath = _imageDirectory.path;
    File file = File(
        '${_targetPath}water_mark_image${DateTime.now().millisecondsSinceEpoch}.jpg');

    file.writeAsBytesSync(pngBytes.buffer.asInt8List());

    print('处理结果:${file.path}');

    return file;
  }

  /// 压缩
  // Future<ui.Image> compressImage(String imgName,BuildContext context,{bool isNetImage = false,Uint8List image}) async {
  //   var result;
  //   if(isNetImage == true){
  //     result = await FlutterImageCompress.compressWithList(
  //       image,
  //       minWidth: MediaQuery.of(context).size.width.toInt() * 2,
  //       minHeight: 0,
  //       quality: 95,
  //     );
  //   }else{
  //     result = await FlutterImageCompress.compressAssetImage(
  //       imgName,
  //       minWidth: MediaQuery.of(context).size.width.toInt() * 2,
  //       minHeight: 0,
  //       quality: 95,
  //     );
  //   }
  //   var u8list = Uint8List.fromList(result);
  //   var compressImage = await bytesToImage(u8list);
  //   return compressImage;
  // }

  /// Uint8List转image
  static Future<ui.Image> bytesToImage(Uint8List imgBytes) async {
    ui.Codec codec = await ui.instantiateImageCodec(imgBytes);
    ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  }

  /// 图片转换Uint8List( 网络 | 本地 )
  static Future<ui.Image> loadImage(var path, bool isUrl) async {
    ImageStream? stream;
    if (isUrl) {
      stream = NetworkImage(path).resolve(ImageConfiguration.empty);
    } else {
      // stream = AssetImage(path, bundle: rootBundle)
      //     .resolve(ImageConfiguration.empty);
    }
    Completer<ui.Image> completer = Completer<ui.Image>();
    void listener(ImageInfo frame, bool synchronousCall) {
      final ui.Image image = frame.image;
      completer.complete(image);
      stream?.removeListener(ImageStreamListener(listener));
    }

    stream?.addListener(ImageStreamListener(listener));
    return completer.future;
  }

  ///value: 文本内容；fontSize : 文字的大小；fontWeight：文字权重；maxWidth：文本框的最大宽度；maxLines：文本支持最大多少行
  static double calculateTextHeight(BuildContext text, String value, fontSize,
      FontWeight fontWeight, double maxWidth, int maxLines) {
    value = filterText(value);
    TextPainter painter = TextPainter(

        ///AUTO：华为手机如果不指定locale的时候，该方法算出来的文字高度是比系统计算偏小的。
        locale: Localizations.localeOf(text),
        maxLines: maxLines,
        textDirection: TextDirection.ltr,
        text: TextSpan(
            text: value,
            style: TextStyle(
              fontWeight: fontWeight,
              fontSize: fontSize,
            )));
    painter.layout(maxWidth: maxWidth);

    ///文字的宽度:painter.width
    return painter.height;
  }

  static String filterText(String text) {
    String tag = '<br>';
    while (text.contains('<br>')) {
// flutter 算高度,单个\n算不准,必须加两个
      text = text.replaceAll(tag, '\n\n');
    }
    return text;
  }
}
