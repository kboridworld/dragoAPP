import 'package:nh_flutter_network/network/host/nh_network_host_provider.dart';
import 'package:dragoma/common/http/host/constants_host.dart';

class SSOHostProvider extends HostProvider {
  @override
  String get alias => Host.SSO;

  @override
  String get devHost => Host.SSO_DEV;

  @override
  String get prodHost => Host.SSO_PROD;

  @override
  String get qaHost => Host.SSO_QA;
}
