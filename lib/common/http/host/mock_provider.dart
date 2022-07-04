import 'package:nh_flutter_network/network/host/nh_network_host_provider.dart';
import 'package:dragoma/common/http/host/constants_host.dart';

class MockProvider extends HostProvider {
  @override
  String get alias => Host.mock;

  @override
  String get devHost => Host.mock;

  @override
  String get prodHost => Host.mock;

  @override
  String get qaHost => Host.mock;
}
