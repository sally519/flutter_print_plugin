import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'printer_sdk_plugin_platform_interface.dart';

/// An implementation of [PrinterSdkPluginPlatform] that uses method channels.
class MethodChannelPrinterSdkPlugin extends PrinterSdkPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('printer_sdk_plugin');

  @override
  Future<void> initCallback(
      {Function? onPrintSuccess,
      Function? onPrintError,
      Function? onConnected,
      Function? onDisconnected}) async {
    methodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onPrintSuccess':
          if (onPrintSuccess != null) {
            onPrintSuccess();
          }
          break;
        case 'onPrintError':
          if (onPrintError != null) {
            onPrintError(call.arguments);
          }
          break;
        case 'onConnected':
          if (onConnected != null) {
            onConnected();
          }
          break;
        case 'onDisconnected':
          if (onDisconnected != null) {
            onDisconnected();
          }
          break;
        default:
          throw MissingPluginException('Method ${call.method} not implemented');
      }
    });
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> initLPAPI() async {
    await methodChannel.invokeMethod<String>('initLPAPI');
  }
}
