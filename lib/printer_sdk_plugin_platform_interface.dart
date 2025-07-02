import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'printer_sdk_plugin_method_channel.dart';

abstract class PrinterSdkPluginPlatform extends PlatformInterface {
  /// Constructs a PrinterSdkPluginPlatform.
  PrinterSdkPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static PrinterSdkPluginPlatform _instance = MethodChannelPrinterSdkPlugin();

  /// The default instance of [PrinterSdkPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelPrinterSdkPlugin].
  static PrinterSdkPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PrinterSdkPluginPlatform] when
  /// they register themselves.
  static set instance(PrinterSdkPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> initLPAPI() {
    throw UnimplementedError('initLPAPI() has not been implemented.');
  }

  Future<void> initCallback(
      {Function? onPrintSuccess,
      Function? onPrintError,
      Function? onConnected,
      Function? onDisconnected}) {
    throw UnimplementedError('initLPAPI() has not been implemented.');
  }
}
