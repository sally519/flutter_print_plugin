import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:printer_sdk_plugin/printer_sdk_plugin.dart';
import 'package:printer_sdk_plugin/printer_sdk_plugin_method_channel.dart';
import 'package:printer_sdk_plugin/printer_sdk_plugin_platform_interface.dart';

class MockPrinterSdkPluginPlatform
    with MockPlatformInterfaceMixin
    implements PrinterSdkPluginPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> initLPAPI() {
    // TODO: implement initLPAPI
    throw UnimplementedError();
  }

  @override
  Future<void> initCallback(
      {Function? onPrintSuccess,
      Function? onPrintError,
      Function? onConnected,
      Function? onDisconnected}) {
    // TODO: implement initCallback
    throw UnimplementedError();
  }
}

void main() {
  final PrinterSdkPluginPlatform initialPlatform =
      PrinterSdkPluginPlatform.instance;

  test('$MethodChannelPrinterSdkPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPrinterSdkPlugin>());
  });

  test('getPlatformVersion', () async {
    PrinterSdkPlugin printerSdkPlugin = PrinterSdkPlugin();
    MockPrinterSdkPluginPlatform fakePlatform = MockPrinterSdkPluginPlatform();
    PrinterSdkPluginPlatform.instance = fakePlatform;

    expect(await printerSdkPlugin.getPlatformVersion(), '42');
  });
}
