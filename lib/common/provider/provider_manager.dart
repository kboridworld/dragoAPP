import 'package:lib_ylz_upgrade_package/lib_ylz_upgrade_package.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> myProviders = [...independentServices];
//独立的model 如：主题 ,用户
List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider(create: (_) => UpgradeViewModel()),
];

//依赖model  ，如 A 需要依赖存储 B
List<SingleChildWidget> dependentServices = [
//  ChangeNotifierProxyProvider<B, A>(
//    create: null,
//    update: (context, bModel, aModel) =>
//    aModel ??
//        A(bModel: bModel),
//  )
];
