import 'package:advdiary/app/modules/app_bar/app_bar_controller.dart';
import 'package:advdiary/app/modules/home/controllers/home_controller.dart';
import 'package:advdiary/controllers/my_drawer_controller.dart';
import 'package:advdiary/services/device_info_helper.dart';
import 'package:advdiary/theme/theme.dart';
import 'package:advdiary/utils/force_update_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'app/routes/app_pages.dart';
import 'package:timezone/data/latest_all.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  DeviceInfoHelper.initialize();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      //systemNavigationBarColor: AppColors.mainColorRed, // navigation bar color
      statusBarColor: Colors.white, // status bar color
      statusBarIconBrightness: Brightness.dark,   // Only honored in Android M and above
      statusBarBrightness: Brightness.dark,
    ),

  );

  Get.put(AppBarController()).getAppBarData();
  Get.put(MyDrawerController(), permanent: true);
  Get.put(HomeController(), permanent: true);
  Get.put(ForceUpdateController(), permanent: true);

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          locale: const Locale("en", "US"),
          fallbackLocale: const Locale("en", "US"),
          //translations: Languages(),
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          theme: CustomTheme.lightTheme,
          // darkTheme: CustomTheme.darkTheme,
          // themeMode: ThemeMode.light,
          builder: EasyLoading.init(),  // Initialize EasyLoading here

        );
      },
    ),
  );
}

// Initialize the notifications
Future<void> _initNotifications() async {
  const AndroidInitializationSettings androidInitializationSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
  InitializationSettings(android: androidInitializationSettings);

  // Initialize the FlutterLocalNotificationsPlugin
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}
