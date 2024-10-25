import 'package:flutter/material.dart';
import 'package:test_news_app/features/main_page/presentation/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'NewYork Times',
      debugShowCheckedModeBanner: false,
      home: MainPage(),
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
