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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: customRedHatText(
                      'Bienvenue sur l\'application sama bank !',
                      Colors.black,
                      18,
                      FontWeight.bold,
                    ),
                  ),
                  BankOperation(
                    imgUrl: 'assets/images/payment-method.png',
                    operationTitle: 'Paiement',
                  ),
                  BankOperation(
                    imgUrl: 'assets/images/money-transfer.png',
                    operationTitle: 'Transfert d\'argent',
                  ),
                  BankOperation(
                    imgUrl: 'assets/images/atm-machine.png',
                    operationTitle: 'Retrait d\'argent',
                  ),
                  BankOperation(
                    imgUrl: 'assets/images/money-transaction.png',
                    operationTitle: 'Transaction',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
