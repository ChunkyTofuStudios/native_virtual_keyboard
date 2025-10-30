import 'package:device_info_plus/device_info_plus.dart';

extension IosVersionInfos on IosDeviceInfo {
  bool get isIos26 {
    final major = systemVersion.split('.').first;
    return (int.tryParse(major) ?? 26) >= 26;
  }
}
