package com.example.printer_sdk_plugin;

import androidx.annotation.NonNull;

import com.dothantech.lpapi.LPAPI;
import com.dothantech.printer.IDzPrinter;
import com.dothantech.printer.IDzPrinter.PrintProgress;
import com.dothantech.printer.IDzPrinter.PrinterAddress;
import com.dothantech.printer.IDzPrinter.PrinterState;
import com.dothantech.printer.IDzPrinter.ProgressInfo;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * PrinterSdkPlugin
 */
public class PrinterSdkPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private LPAPI api;
    // LPAPI 打印机操作相关的回调函数。
    private final LPAPI.Callback mCallback = new LPAPI.Callback() {

        //****************************************************************************************************************************************
        // 所有回调函数都是在打印线程中被调用，因此如果需要刷新界面，需要发送消息给界面主线程，以避免互斥等繁琐操作。
        //****************************************************************************************************************************************

        // 打印机连接状态发生变化时被调用
        @Override
        public void onStateChange(PrinterAddress arg0, PrinterState arg1) {
            final PrinterAddress printer = arg0;
            switch (arg1) {
                case Connected:
                case Connected2:
                    // 打印机连接成功，发送通知，刷新界面提示
                    Map<String, Object> args = new HashMap<>();
                    args.put("msg", "打印机连接成功");
                    channel.invokeMethod("onPrintSuccess", args);
                    break;

                case Disconnected:
                    // 打印机连接失败、断开连接，发送通知，刷新界面提示
                    break;

                default:
                    break;
            }
        }

        // 蓝牙适配器状态发生变化时被调用
        @Override
        public void onProgressInfo(ProgressInfo arg0, Object arg1) {
        }

        @Override
        public void onPrinterDiscovery(PrinterAddress printerAddress, Object o) {

        }

        // 打印标签的进度发生变化是被调用
        @Override
        public void onPrintProgress(PrinterAddress address, IDzPrinter.PrintData bitmapData, PrintProgress progress, Object addiInfo) {
            switch (progress) {
                case Success:
                    // 打印标签成功，发送通知，刷新界面提示
                    break;

                case Failed:
                    // 打印标签失败，发送通知，刷新界面提示
                    break;

                default:
                    break;
            }
        }
    };

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "printer_sdk_plugin");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "getPlatformVersion":
                result.success("Android 9988" + android.os.Build.VERSION.RELEASE);
                break;
            case "initLPAPI":
                this.api = LPAPI.Factory.createInstance(mCallback);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }
}
