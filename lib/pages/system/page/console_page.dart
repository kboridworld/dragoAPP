import 'package:dragoma/utils/database/ylz_consignor_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lib_ylz_ui_kit_package/lib_ylz_ui_kit_package.dart';
import 'package:dragoma/widgets/app_bar.dart';
import 'package:dragoma/pages/system/controller/console_controller.dart';
import 'package:dragoma/utils/log/ylz_log.dart';

class ConsolePage extends GetView<ConsoleController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '控制台日志'),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: controller.dao.getLogRecords(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<YlzLogData>> snapshot) {
                if (!snapshot.hasData || snapshot.hasError) {
                  return Center(child: Text('暂无数据'));
                } else {
                  return ListView.builder(
                    itemBuilder: (ctx, index) {
                      YlzLogData log =
                          snapshot.data![snapshot.data!.length - index - 1];
                      return ExpansionTile(
                        title: Text(
                          log.headerTitle(),
                          style: TextStyle(fontSize: 14),
                        ),
                        children: <Widget>[
                          Card(
                            child: log.isContentJsonView
                                ? JsonViewerWidget(log.requestContentDic())
                                : Text(log.content ?? '',
                                    textAlign: TextAlign.left),
                          )
                        ],
                      );
                    },
                    itemCount: snapshot.data!.length,
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
