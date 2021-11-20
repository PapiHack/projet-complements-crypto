import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/widgets.dart';
import '../utils/utils.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              bottom: TabBar(
                tabs: [
                  Tab(
                    child: customRedHatText(
                      'Identification',
                      COLOR_WHITE,
                      15.0,
                      FontWeight.w700,
                    ),
                  ),
                  Tab(
                    child: customRedHatText(
                      'OTP Décodeur',
                      COLOR_WHITE,
                      15.0,
                      FontWeight.w700,
                    ),
                  ),
                ],
              ),
              title: customRedHatText(
                'Sama Bank',
                COLOR_WHITE,
                20,
                FontWeight.w500,
              ),
            ),
            body: TabBarView(
              children: [
                SingleChildScrollView(
                  child: LoginView(),
                ),
                SingleChildScrollView(
                  child: DecoderView(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
