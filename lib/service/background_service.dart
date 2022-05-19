import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:http/http.dart' as http;

class BackgroundService {
  static FlutterBackgroundService? service;
  static void stop() {
    if (service != null) {
      service!.invoke("stopService");
    }
  }

  static void start() async {
    if (service != null) {
      service!.startService();
    } else {
      await init();
    }
  }

  static Future<void> init() async {
    service = FlutterBackgroundService();
    await service!.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: false,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
    service!.startService();
  }

  static bool onIosBackground(ServiceInstance serviceIOS) {
    WidgetsFlutterBinding.ensureInitialized();
    serviceIOS.on('startService').listen((event) {
      service!.startService();
    });

    return true;
  }

  static void onStart(ServiceInstance serviceInstance) {
    serviceInstance.on('stopService').listen((event) {
      serviceInstance.stopSelf();
    });
    serviceInstance.on('startService').listen((event) {
      service!.startService();
    });
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      try {
        var data = await http.get(Uri.https(
          'google.com',
          '/',
          {'online': "true"},
        ));
        print("hello world");
        if (data.statusCode == 200) {
        } else {}
      } on SocketException catch (_) {
      } catch (e) {}
    });

    // todo: send location
    // Timer.periodic(const Duration(minutes: 5), (timer) async {
    //   var location = await getLocation();
    //   try {
    //     var data = await http.get(Uri.https(
    //       'google.com',
    //       '/',
    //       {
    //         'lat': location!.latitude.toString(),
    //         'lon': location.longitude.toString()
    //       },
    //     ));
    //     if (data.statusCode == 200) {
    //     } else {}
    //   } on SocketException catch (_) {
    //   } catch (e) {}
    // });
  }
}
