import 'dart:async';
import 'dart:isolate';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:lib_ylz_page_lifecycle/base/routing_manager.dart';
import 'package:lib_ylz_router_package/lib_ylz_router_package.dart';
import 'package:lib_ylz_ui_kit_package/lib_ylz_ui_kit_package.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dragoma/application.dart';
import 'package:dragoma/common/provider/provider_manager.dart';
import 'package:dragoma/common/res/strings.dart';
import 'package:dragoma/common/route/app_routes.dart';

import 'common/res/styles.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //滚动性能优化
  WidgetsBinding.instance!.resamplingEnabled = true;
  //强制竖屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  ErrorWidget.builder = (FlutterErrorDetails details) {
    Zone.current.handleUncaughtError(details.exception,
        details.stack ?? StackTrace.fromString(details.exceptionAsString()));
    return Container(color: Colors.transparent);
  };
  FlutterError.onError = (details) {
    Zone.current.handleUncaughtError(details.exception,
        details.stack ?? StackTrace.fromString(details.exceptionAsString()));
  };
  Isolate.current.addErrorListener(new RawReceivePort((dynamic pair) {
    var isolateError = pair as List<dynamic>;
    var _error = isolateError.first;
    var _stackTrace = isolateError.last;
    Zone.current.handleUncaughtError(_error, _stackTrace);
  }).sendPort);

  runZonedGuarded<Future<void>>(() async {
    Application.appInitializer().then((value) {
      runApp(DriverApp());
    });
  }, (dynamic error, StackTrace stackTrace) {
    debugPrint('🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽Error🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽');
    debugPrint(error.toString());
    debugPrintStack(stackTrace: stackTrace);
    debugPrint('🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼Error🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼🔼');
  });
}

final GlobalKey<NavigatorState> driverAppGlobalKey =
    GlobalKey<NavigatorState>();

class DriverApp extends StatelessWidget {
  static const MaterialColor greenTheme = MaterialColor(
    0xFF06B880,
    <int, Color>{
      50: Color(0xade2f5ec),
      100: Color(0xd7e2f5ec),
      200: Color(0xffb9e5d1),
      300: Color(0xFF8ad4b3),
      400: Color(0xFF52c596),
      500: Color(0xFF06B880),
      600: Color(0xFF00ab6a),
      700: Color(0xFF009c5f),
      800: Color(0xFF008a52),
      900: Color(0xFF007945),
    },
  );
  final botToastBuilder = BotToastInit(); // toast
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: myProviders,
      child: RefreshConfiguration(
        footerTriggerDistance: 15,
        dragSpeedRatio: 0.91,
        headerBuilder: () => CustomWaterDropHeader(
          waterDropColor: ColorValues.primaryColor,
        ),
        footerBuilder: () => ClassicFooter(),
        enableLoadingWhenNoData: false,
        shouldFooterFollowWhenNotFull: (state) => false,
        enableBallisticLoad: true,
        child: OKToast(
          child: GetMaterialApp(
            initialRoute: AppRoutes.rootPage,
            getPages: AppRoutes.getPages,
            unknownRoute: AppRoutes.notFoundPage,
            routingCallback: (routing) {
              RoutingManager.onAppRoutingChange(routing);
            },
            navigatorKey: driverAppGlobalKey,
            navigatorObservers: [
              RouteManager.routeObserver,
              BotToastNavigatorObserver()
            ],
            title: YlzString.appName,
            theme: ThemeData(
              primarySwatch: greenTheme,
              scaffoldBackgroundColor: ColorValues.grey_bg,
            ),
            locale: const Locale('zh'),
            localizationsDelegates: [
              RefreshLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: [Locale('zh')],
            builder: (BuildContext context, Widget? child) {
              child = botToastBuilder(context, child);
              return MediaQuery(
                child: child,
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              );
            },
          ),
        ),
      ),
    );
  }
}
