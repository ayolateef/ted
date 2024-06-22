// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:developer';
// // import 'package:camera/camera.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
//
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tedfinance_mobile/core/env/environment.dart';
// // import 'package:trybe_one_m
// import 'package:flutter/services.dart';
// import 'package:tedfinance_mobile/core/env/utils/colors.dart';
// import 'package:tedfinance_mobile/core/env/utils/size_utils.dart';
// import 'package:tedfinance_mobile/providers/allproviders.dart';
// import 'package:tedfinance_mobile/theme/theme_helper.dart';
// import 'package:tedfinance_mobile/widgets/base_widget.dart';
// import 'package:tedfinance_mobile/widgets/custom_easy_loading_animation.dart';
//
// import 'core/auth/onboarding/onboarding_screen.dart';
// import 'core/auth/splash_screen.dart';
//
// // late List<CameraDescription> cameras;
// // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// //   // If you're going to use other Firebase services in the background, such as Firestore,
// //   // make sure you call `initializeApp` before using other Firebase services.
// //   await Firebase.initializeApp(
// //     options: DefaultFirebaseOptions.currentPlatform,
// //   );
// //   FirebasePushNotificationService.firebaseMessagingBackgroundHandler(message);
// // }
//
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// final GlobalKey<ScaffoldState> scaffoldGlobalKey = GlobalKey();
//  void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   //Initialize Firebase
//   //await Firebase.initializeApp();
//   //This is just nonsense commit i dont understand it just testing
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//   ]);
//
//   const String environment =
//       String.fromEnvironment("ENVIRONMENT", defaultValue: Environment.DEV);
//
//   Environment().initConfig(environment);
//   // TrybeColors().init(ThemeMode.light);
//
//   runZonedGuarded(
//     () async {
//       // await initOneSignal();
//       WidgetsFlutterBinding.ensureInitialized();
//       // await Firebase.initializeApp(
//       //   options: DefaultFirebaseOptions.currentPlatform,
//       // );
//
//       // cameras = await availableCameras();
//
//       // FlutterError.onError =
//       //     FirebaseCrashlytics.instance.recordFlutterFatalError;
//
//       // // //await Firebase.initializeApp();
//       // FirebaseMessaging messaging = FirebaseMessaging.instance;
//       // FirebaseMessaging.onBackgroundMessage(
//       //     _firebaseMessagingBackgroundHandler);
//
//       // NotificationSettings settings = await messaging.requestPermission(
//       //   alert: false,
//       //   announcement: false,
//       //   badge: true,
//       //   carPlay: false,
//       //   criticalAlert: false,
//       //   provisional: false,
//       //   sound: true,
//       // );
//
//       // print('User granted permission: ${settings.authorizationStatus}');
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       bool seen = prefs.getBool('hasViewedIntroScreens') ?? false;
//       bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
//       // TrybeColors().init(isDarkMode ? ThemeMode.dark : ThemeMode.light);
//
//       HttpOverrides.global = MyHttpOverrides();
//       ThemeHelper().changeTheme('primary');
//       WidgetsFlutterBinding.ensureInitialized();
//       runApp(MyApp(
//           seen: seen,
//           isDarkMode: isDarkMode
//       ));
//     },
//     (error, stack) =>
//
//         FirebaseCrashlytics.instance.recordError(
//       error,
//       stack,
//       fatal: true,
//     ),
//     zoneSpecification: ZoneSpecification(handleUncaughtError: (Zone self,
//         ZoneDelegate parent, Zone zone, Object error, StackTrace stackTrace) {
//       // Custom error handling logic here
//       print('Caught an error: $error');
//       // Optionally, you can rethrow the error to let the parent zone handle it
//       parent.handleUncaughtError(zone, error, stackTrace);
//     }),
//   );
//   configLoading();
// }
//
// void configLoading() {
//   EasyLoading.instance
//     ..displayDuration = const Duration(milliseconds: 2000)
//     ..indicatorType = EasyLoadingIndicatorType.fadingCircle
//     ..loadingStyle = EasyLoadingStyle.dark
//     ..indicatorSize = 45.0
//     ..radius = 10.0
//     ..progressColor = Colors.yellow
//     ..backgroundColor = Colors.green
//     ..indicatorColor = Colors.yellow
//     ..textColor = Colors.yellow
//     ..maskColor = Colors.blue.withOpacity(0.5)
//     ..userInteractions = true
//     ..dismissOnTap = false
//     ..customAnimation = CustomAnimation();
// }

// Future<void> initOneSignal() async {
//   //Remove this method to stop OneSignal Debugging
//   OneSignal.Debug.setLogLevel(OSLogLevel.herbose);
//   print("ficefsdssdsd");

//   OneSignal.initialize("a87ec6c3-a204-4095-aa4f-8a59232c9773");

// // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
//   OneSignal.Notifications.requestPermission(true);

// // OneSignal.Notifications.clearAll();

//   OneSignal.User.pushSubscription.addObserver((state) {
//     print("onesingidinfo");
//     print(OneSignal.User.pushSubscription.optedIn);
//     print(OneSignal.User.pushSubscription.id);
//     print(OneSignal.User.pushSubscription.token);
//     print(state.current.jsonRepresentation());
//   });

//   OneSignal.Notifications.addPermissionObserver((state) {
//     print("Has permission " + state.toString());
//   });

//   OneSignal.Notifications.addClickListener((event) {
//     print(
//         'NOTIFICATION CLICK LISTENER CALLED WITH EVENT: ${event.notification.jsonRepresentation().toString()}');
//     var payload = event.notification.jsonRepresentation();

//     Map<String, dynamic> parsedPayload = json.decode(payload);

//     NotificationItem item =
//         NotificationItem.fromJson(parsedPayload["custom"]["a"]);
//     NotificationRouterService.router(item, navigatorKey.currentContext!);
//   });

//   OneSignal.Notifications.addForegroundWillDisplayListener((event) {
//     print(
//         'FORENOTIFICATION WILL DISPLAY LISTENER CALLED WITH: ${event.notification.jsonRepresentation()}');

//     /// Display Notification, preventDefault to not display
//     // event.preventDefault();

//     // /// Do async work

//     // /// notification.display() to display after preventing default
//     // event.notification.display();
//   });
// }

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }
//
// class MyApp extends StatefulWidget {
//   final bool seen;
//   final bool isDarkMode;
//
//   const MyApp({Key? key, required this.seen, required this.isDarkMode})
//       : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   int? userId;
//   @override
//   void initState() {
//     super.initState();
//     setObjectKey();
//     // LocalPushNotificationService.init();
//     // FirebasePushNotificationService.init();
//
//     // final config = OkHiAppConfiguration(
//     //   branchId: Environment().config.OKIHI_BRANCH_ID,
//     //   clientKey: Environment().config.OKIHI_CLIENT_ID,
//     //   env: Environment().config.OKIHI_ENV,
//     //   notification: OkHiAndroidNotification(
//     //     title: TextLiterals.okHiTitle,
//     //     text: TextLiterals.okHiText,
//     //     channelId: "okhi",
//     //     channelName: "OkHi",
//     //     channelDescription: "Verification alerts",
//     //   ),
//     // );
//     // OkHi.initialize(config).then((result) async {
//     //   debugPrint(
//     //       result.toString()); // returns true if initialization is successfull
//     // });
//
//     // TrybeColors().addListener(() {
//     //   themeListener();
//     // });
//   }
//
//   setObjectKey() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final int id = prefs.getInt('userId') ?? 0;
//     print("sssaasuas $id");
//     setState(() {
//       userId = id;
//     });
//   }
//
//   // @override
//   // void dispose() {
//   //   super.dispose();
//   //   TrybeColors().removeListener(() {
//   //     themeListener();
//   //   });
//   // }
//
//   themeListener() {
//     print("Yes we changed the theme");
//     if (mounted) {
//       setState(() {});
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //very important
//     print("enviornmmet ${Environment.getEnv()}");
//     debugInvertOversizedImages = true;
//     return Sizer(builder: (context, orientation, deviceType) {
//       return StreamProvider<InternetConnectionStatus>(
//         initialData: InternetConnectionStatus.connected,
//         create: (_) {
//           return InternetConnectionChecker().onStatusChange;
//         },
//         child: StreamBuilder<QuerySnapshot>(
//             stream: FirebaseFirestore.instance
//                 .collection('app_settings')
//                 .snapshots(),
//             builder: (context, snapshot) {
//               try {
//                 print(
//                     "top level rebuild initiated.... ${snapshot.data?.docs.first.data()}");
//                 if (Environment.getEnv() == Environment.PROD) {
//                   if (snapshot.data?.docs.first.data() != null) {
//                     log("disiiid");
//                     log("${snapshot.data?.docs.first.data()!.toString()}");
//                     gotoEmergencyScreen(
//                         context,
//                         snapshot.data?.docs.first.data()
//                             as Map<String, dynamic>);
//                   }
//                 }
//               } catch (e) {
//                 print("erroroiuhhjf");
//                 print(e.toString());
//                 // printty(s.toString());
//               }
//               return MaterialApp(
//                 themeMode: ThemeMode.dark,
//                 theme: ThemeData(
//                   primaryColor: AppColors.PrimaryColor
//                 ),
//                // theme: theme,
//                 builder: (context, child) {
//                   final MediaQueryData data = MediaQuery.of(context);
//
//                   return MultiProvider(
//                     key: ObjectKey(userId),
//                     builder: EasyLoading.init(),
//                     providers: allProviders,
//                     child: MediaQuery(
//                         data: data.copyWith(
//                           textScaler: const TextScaler.linear(1),
//                         ),
//                         child: BaseWidget(
//                           child: child!,
//                         )),
//                   );
//                 },
//                 navigatorKey: navigatorKey,
//                 key: scaffoldGlobalKey,
//                 title: "TED FINANCE",
//                 debugShowCheckedModeBanner: false,
//                 localizationsDelegates: const [
//                   // GlobalMaterialLocalizations.delegate,
//                   // GlobalWidgetsLocalizations.delegate,
//                   // //DefaultCupertinoLocalizations.delegate,
//                   // GlobalCupertinoLocalizations
//                   //     .delegate, // Add global cupertino localiztions.
//                 ],
//                 locale: const Locale('en', 'US'), // Current locale
//                 supportedLocales: const [
//                   Locale('en', 'US'), // English
//                   Locale('th', 'TH'), // Thai
//                 ],
//
//                 //home: EmployeeAndSelfEmployedAddressInfo(),
//                 //home: SendMoneyToNonTryber(),
//                 //home: WalletUpgradeAccount(),
//                 //home: UserInterests(), //
//                 //home: TransactionHistoryDetails(),
//                 // home: CameraExampleHome(),
//                 // home: CameraApp(),Menu
//                 navigatorObservers: const <NavigatorObserver>[
//                   // AnalyticService.getAnalyticObser()
//                 ],
//                 // home: IosTest(),${Utilities.dayWithSuffixMonthAndYear(DateTime.tryParse(eventVM.singleEvent!.startDate) ?? DateTime.now())}
//                 //
//                 // onGenerateRoute: TrybeOneRouter.generateRoute,
//
//                 home:
//                     widget.seen == true ? const SplashScreen() : const OnboardingScreen (),
//                 // home: EmergencyScreen(),
//
//               );
//             }),
//       );
//     });
//   }
//
//   gotoEmergencyScreen(context, data) async {
//     // EmergencyModel emergencyModel = EmergencyModel.fromJson(data);
//     // var verionN = await Utilities.appInfo();
//
//     // print("versionapp,${verionN} ddsd ${emergencyModel}");
//
//     // if (emergencyModel.enable!) {
//     //   bool isNavigate = false;
//
//     //   if (emergencyModel.isLocked!) {
//     //     isNavigate = true;
//     //   }
//     //   if (Platform.isAndroid && emergencyModel.hersion != verionN["version"]) {
//     //     isNavigate = true;
//     //   }
//     //   if (Platform.isIOS && emergencyModel.hersionIos != verionN["version"]) {
//     //     isNavigate = true;
//     //   }
//     //   if (isNavigate) {
//     //     Navigator.pushNamedAndRemoveUntil(
//     //         navigatorKey.currentContext ?? context,
//     //         RouteLiterals.emergencyRoute,
//     //         arguments: emergencyModel,
//     //         (route) => false);
//     //   }
//     // }
//   }
// }

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tedfinance_mobile/core/Dashboard/routes.dart';
import 'package:tedfinance_mobile/core/env/environment.dart';
import 'package:tedfinance_mobile/core/env/utils/colors.dart';
import 'package:tedfinance_mobile/providers/allproviders.dart';

import 'package:tedfinance_mobile/providers/auth_provider.dart';
import 'package:tedfinance_mobile/shared/models/auth_models/user.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/navigation_service.dart';
import 'package:tedfinance_mobile/shared/navigations/routes/router.dart';
import 'package:tedfinance_mobile/shared/util/storage.dart';
import 'package:tedfinance_mobile/theme/theme_helper.dart';
import 'core/auth/routes.dart';
import 'core/env/app_config.dart';
import 'core/env/utils/size_utils.dart';

// List<CameraDescription>? cameras;
 Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();



  //cameras = await availableCameras();
  //await Firebase.initializeApp();
  //Crashlytics.instance.initialize();

  const String environment =
      String.fromEnvironment("ENVIRONMENT", defaultValue: Environment.DEV);

  Environment().initConfig(environment);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
       const Directionality(
          textDirection: TextDirection.ltr,
          child: MyApp()));
}

class MyApp extends StatefulWidget {

  const MyApp({Key? key,}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int? userId;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> scaffoldGlobalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    setObjectKey();
  }

  setObjectKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int id = prefs.getInt('userId') ?? 0;
    print("sssaasuas $id");
    setState(() {
      userId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TED FINANCE",
      themeMode: ThemeMode.light,
      theme: ThemeData(
          primaryColor: const Color(0xffCE2ACD),
          hoverColor: AppColors.primaryColor
        // Define other theme properties if needed
      ),
      home: MultiProvider(
        key: ObjectKey(userId),
        builder: EasyLoading.init(),
        providers: allProviders,
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1),
          ),
          child: ScreenUtilInit(
            useInheritedMediaQuery: true,
            designSize: const Size(454, 982),
            builder: (BuildContext context, child) => GestureDetector(
              onTap: () {
                // ...
              },
              child: Navigator(
                key: navigatorKey,
                onGenerateRoute: routes,
                initialRoute:AuthRoutes.initial
               // DashboardRoutes.uploadFiles
              //  DashboardRoutes.kycProgress
              ),
            ),
          ),
        ),
      ),
    );
  }
}
