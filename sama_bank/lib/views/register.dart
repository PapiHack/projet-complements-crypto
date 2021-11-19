import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/widgets.dart';
import '../../../utils/utils.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        return Scaffold(
          appBar: AppBar(
            title: customRedHatText(
              'Inscription',
              COLOR_WHITE,
              15.0,
              FontWeight.w700,
            ),
          ),
          body: Container(
            color: COLOR_WHITE,
            child: SingleChildScrollView(
              child: RegisterView(),
            ),
          ),
        );
      },
    );
  }
}
