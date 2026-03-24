import 'dart:io';

import 'package:bonsoir/bonsoir.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_udid/flutter_udid.dart';

/// Allows to get the Bonsoir service corresponding to the current device.
class DefaultAppService {
  /// The "OS" attribute.
  static const String attributeOs = 'os';

  /// The "UUID" attribute.
  static const String attributeUuid = 'uuid';

  /// The "service type" attribute
  static const String serviceType = '_filesync._tcp';

  /// The default app service.
  static late BonsoirService _service;
  static late BonsoirBroadcast broadcast;

  /// Returns the default app service instance.
  static BonsoirService get service => _service;

  /// Initializes the Bonsoir service instance.
  static Future initialize() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String name;
    String os;
    if (Platform.isAndroid) {
      name = (await deviceInfo.androidInfo).model;
      os = 'Android';
    } else if (Platform.isIOS) {
      name = (await deviceInfo.iosInfo).localizedModel;
      os = 'iOS';
    } else if (Platform.isMacOS) {
      name = (await deviceInfo.macOsInfo).computerName;
      os = 'macOS';
    } else if (Platform.isWindows) {
      name = (await deviceInfo.windowsInfo).computerName;
      os = 'Windows';
    } else if (Platform.isLinux) {
      name = (await deviceInfo.linuxInfo).name;
      os = 'Linux';
    } else {
      name = 'Flutter';
      os = 'Unknown';
    }

    _service = BonsoirService(
      name: name,
      type: serviceType,
      port: 4000,
      attributes: {attributeOs: os, attributeUuid: await FlutterUdid.udid},
    );

    // broadcast = BonsoirBroadcast(service: _service);
    // await broadcast.initialize();
    // await broadcast.start();
  }
}
