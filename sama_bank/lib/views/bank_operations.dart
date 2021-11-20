import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/widgets.dart';
import '../../../utils/utils.dart';

class BankOperationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: customRedHatText(
              'Opérations Bancaires Disponibles',
              COLOR_WHITE,
              15.0,
              FontWeight.w700,
            ),
          ),
          body: Container(
            color: COLOR_WHITE,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Text('Bienvenue sur l\'application sama bank !'),
            ),
          ),
        );
      },
    );
  }
}
