import 'printer_sdk_plugin_platform_interface.dart';

class PrinterSdkPlugin {
  Future<String?> getPlatformVersion() {
    return PrinterSdkPluginPlatform.instance.getPlatformVersion();
  }

  Future<void> initLPAPI() {
    return PrinterSdkPluginPlatform.instance.initLPAPI();
  }

  void initCallback(
      {Function? onPrintSuccess,
      Function? onPrintError,
      Function? onConnected,
      Function? onDisconnected}) {
    PrinterSdkPluginPlatform.instance.initCallback(
      onPrintSuccess: onPrintSuccess,
      onPrintError: onPrintError,
      onConnected: onConnected,
      onDisconnected: onDisconnected,
    );
  }
}
