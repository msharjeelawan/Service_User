import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mutwaffer_user/Helper/Constant.dart';
import 'package:mutwaffer_user/Screens/dashboard_screen.dart';
import 'package:mutwaffer_user/Screens/language_screen.dart';
import 'package:mutwaffer_user/Screens/login_screen.dart';
import 'package:mutwaffer_user/Screens/order_done_screen.dart';
import 'package:mutwaffer_user/Screens/order_summary_screen.dart';
import 'package:mutwaffer_user/Screens/order_status_screen.dart';
import 'package:mutwaffer_user/Screens/location_screen.dart';
import 'package:mutwaffer_user/Screens/notification_screen.dart';
import 'package:mutwaffer_user/Screens/order_screen.dart';
import 'package:mutwaffer_user/Screens/profile_screen.dart';
import 'package:mutwaffer_user/Screens/registration_screen.dart';
import 'package:mutwaffer_user/Screens/review_screen.dart';
import 'package:mutwaffer_user/Screens/time_selection_screen.dart';
import 'package:mutwaffer_user/Screens/topup_screen.dart';
import 'package:mutwaffer_user/Screens/wallet_screen.dart';
import 'package:mutwaffer_user/Service/firebase_notification_service.dart';
import 'package:mutwaffer_user/translations/codegen_loader.g.dart';
import 'package:mutwaffer_user/translations/locale_keys.g.dart';
import 'Helper/FirebaseCallbacks.dart';
import 'Helper/data_sync.dart';
import 'Helper/device_connectivity.dart';
import 'Screens/allorder_booking_screen.dart';
import 'Screens/change_password_screen.dart';
import 'Screens/home_screen.dart';
import 'Screens/new_password_screen.dart';
import 'Screens/otp_screen.dart';
import 'Screens/price_list.dart';
import 'Screens/service_screen.dart';
import 'Screens/share_app.dart';
import 'Screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseNotificationService().initialize();
   await EasyLocalization.ensureInitialized();
  FirebaseDatabase.instance.setPersistenceEnabled(true);

  runApp(EasyLocalization(
     assetLoader: const CodegenLoader(),
      path: 'assets/translations',
      supportedLocales: [Locale('en'), Locale('ar')],
      fallbackLocale: Locale('en'),
    
    child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<String,WidgetBuilder> routes = <String,WidgetBuilder>{
      '/home':(context)=> HomeScreen(),
      '/profile':(context)=>  ProfileScreen(),
      '/dashboard':(context)=>  DashboardScreen(),
      '/wallet':(context)=> const WalletScreen(),
      '/booking':(context)=> const BookingScreen(),
      '/notification':(context)=> const NotificationScreen(),
      '/behavior':(context)=> const BehaviorScreen(),
      '/changePassword':(context)=> ChangePasswordScreen(),
      '/orderSummary':(context)=> OrderSummaryScreen(),
      '/orderStatus':(context)=> OrderStatusScreen(),
      '/topup':(context)=> TopUpScreen(),
      '/service':(context)=> const ServiceScreen(),
      // '/order':(context)=> OrderScreen(),
      '/priceList':(context)=> const PriceListScreen(),
      '/location':(context)=> LocationScreen(),
      '/timeSelection':(context)=> TimeSelectionScreen(),
      '/orderDone':(context)=> OrderDoneScreen(),
      // '/otp':(context)=>  OTPScreen(),
      '/registration':(context)=> RegistrationScreen(),
      '/language':(context)=> const LanguageScreen(),
      '/login':(context)=> LoginScreen(),
      '/newPassword':(context)=> NewPasswordScreen(),
      '/splash': (context) => const SplashScreen(),
      '/share': (context) => ShareApp(),
    };

    FirebaseDatabase.instance.ref("jobNo").once().then((event){
      print("testig");
      print(event.snapshot.value);
    });

    DeviceConnectivityChecking.activate();

    FirebaseCallbacks.registerCallbacks(context,ifLogin: (){
      final dataSync = DataSync();
      dataSync.sync();
    });

    //  MaterialColor _col = MaterialColor(primary, swatch)
    return MaterialApp(
      locale: context.locale,
    supportedLocales: context.supportedLocales,
    localizationsDelegates: context.localizationDelegates,
      title: LocaleKeys.Mutawaffer.tr(),
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        // appBarTheme: AppBarTheme(titleTextStyle: TextStyle(color: Constant.white))
      ),
      // home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash",
      routes: routes,
    );
  }

  @override
  void dispose() {
    DataSync.removeCallBacks();
    DeviceConnectivityChecking.deactivate();
    super.dispose();
  }
}


// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     Map<String,WidgetBuilder> routes = <String,WidgetBuilder>{
//       '/home':(context)=> HomeScreen(),
//       '/profile':(context)=>  ProfileScreen(),
//       '/dashboard':(context)=>  DashboardScreen(),
//       '/wallet':(context)=> const WalletScreen(),
//       '/booking':(context)=> const BookingScreen(),
//       '/notification':(context)=> const NotificationScreen(),
//       '/behavior':(context)=> const BehaviorScreen(),
//       '/changePassword':(context)=> const ChangePasswordScreen(),
//       '/orderSummary':(context)=> OrderSummaryScreen(),
//       '/orderStatus':(context)=> OrderStatusScreen(),
//       '/topup':(context)=> TopUpScreen(),
//       '/service':(context)=> const ServiceScreen(),
//      // '/order':(context)=> OrderScreen(),
//       '/priceList':(context)=> const PriceListScreen(),
//       '/location':(context)=> LocationScreen(),
//       '/timeSelection':(context)=> TimeSelectionScreen(),
//       '/orderDone':(context)=> OrderDoneScreen(),
//      // '/otp':(context)=>  OTPScreen(),
//       '/registration':(context)=> RegistrationScreen(),
//       '/language':(context)=> const LanguageScreen(),
//       '/login':(context)=> LoginScreen(),
//       '/newPassword':(context)=> NewPasswordScreen(),
//       '/splash': (context) => const SplashScreen(),
//       '/share': (context) => ShareApp(),
//     };
//
//     FirebaseCallbacks.registerCallbacks(context,ifLogin: (){
//       final dataSync = DataSync();
//       dataSync.sync();
//     });
//
//   //  MaterialColor _col = MaterialColor(primary, swatch)
//     return MaterialApp(
//       title: LocaleKeys.Mutawaffer.tr(),
//       theme: ThemeData(
//         primarySwatch: Colors.lightGreen,
//         // appBarTheme: AppBarTheme(titleTextStyle: TextStyle(color: Constant.white))
//       ),
//       // home: HomeScreen(),
//       debugShowCheckedModeBanner: false,
//       initialRoute: "/splash",
//       routes: routes,
//     );
//   }
// }
