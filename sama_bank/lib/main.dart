import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'views/views.dart';
import 'config/config.dart';
import 'utils/utils.dart';

void main() async => {
      await EnvironmentConfig.load(),
      runApp(
        ProviderScope(
          child: SamaBankApp(),
        ),
      ),
    };

class SamaBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      initialRoute: Routes.LOGIN,
      home: LoginPage(),
      onGenerateRoute: Application.router.generator,
    );
  }
}
