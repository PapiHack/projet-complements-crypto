import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import '../../views/views.dart';

Handler loginHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
      LoginPage(),
);

Handler registerHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
      RegisterPage(),
);

Handler signInHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
      SignInPage(),
);

Handler bankOperationsHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
      BankOperationsPage(),
);
