
import 'printer_sdk_plugin_platform_interface.dart';

class PrinterSdkPlugin {
  Future<String?> getPlatformVersion() {
    return PrinterSdkPluginPlatform.instance.getPlatformVersion();
  }
}
