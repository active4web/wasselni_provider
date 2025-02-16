import 'package:commercial_app/scr/login.dart';
import 'package:commercial_app/scr/statistics.dart';
import 'package:commercial_app/utilitie/hexToColor%D9%90Convert.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_storage/get_storage.dart';
import 'Translation/Trans.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message: ${message.messageType}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FCMConfig.instance.init(
      onBackgroundMessage: _firebaseMessagingBackgroundHandler,
      defaultAndroidChannel: AndroidNotificationChannel(
          'high_importance_channel', // same as value from android setup
          'Fcm config'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String? token = box.read('token');
    return GetMaterialApp(
        locale: LocalizationService.locale,
        translations: LocalizationService(),
        fallbackLocale: LocalizationService.fallbackLocale,
        debugShowCheckedModeBanner: false,
        title: 'وصلني',
        theme: ThemeData(
          fontFamily: 'Arbf',
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FutureBuilder<bool>(
          future: check(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(); // tstart();
              default:
                if (snapshot.hasError)
                  return tstart();
                else if (snapshot.data == false) {
                  return tstart();
                }
                return token != null
                    ? Statisticss()
                    : LoginScr(); //Statisticss();token!=null?Statisticss():
            }
          },
          initialData: false,
        ) // Statisticss():tstart()//HomePage(),ProductScr()//OfferScr()//QRClient()//
        );
  }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.first == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult.first == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  Widget tstart() {
    return Scaffold(
      body: Center(
        child: Text(
          ' لا يوجد اتصال بالإنترنت',
          style: TextStyle(color: hexToColor('#E62D2B'), fontSize: 25),
        ),
      ),
    );
  }
}
