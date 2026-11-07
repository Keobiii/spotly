import 'package:flutter/material.dart';

import 'core/router/app_router.dart';

class Spotly extends StatelessWidget {
  const Spotly({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Spotly',
      routerConfig: appRouter,
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blue),
    );
  }
}
