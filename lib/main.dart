import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_news_app/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      title: 'NewYork Times',
      debugShowCheckedModeBanner: false,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:auto_route/auto_route.dart';
// import 'router.gr.dart';  // Generated file

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final _appRouter = AppRouter();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       routerDelegate: _appRouter.delegate(),
//       routeInformationParser: _appRouter.defaultRouteParser(),
//     );
//   }
// }
