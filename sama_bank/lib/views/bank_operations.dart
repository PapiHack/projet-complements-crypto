import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/widgets.dart';
import '../../../utils/utils.dart';
import '../../../config/config.dart';

class BankOperationsPage extends StatelessWidget {
  void _onLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: customRedHatText(
          'Voulez-vous vraiment vous déconnecter ?',
          Colors.black,
          14,
          FontWeight.normal,
        ),
        elevation: 24.0,
        actions: [
          customOutlinedButton(
            'Non',
            COLOR_BLUE,
            13,
            FontWeight.normal,
            () => Navigator.pop(context),
          ),
          customOutlinedButton(
            'Oui',
            COLOR_BLUE,
            13,
            FontWeight.normal,
            () => Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.LOGIN,
              (r) => false,
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

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
            actions: [
              Padding(
                padding: EdgeInsets.only(
                  right: 8,
                ),
                child: GestureDetector(
                  onTap: () => this._onLogout(context),
                  child: Icon(
                    Icons.logout_outlined,
                  ),
                ),
              ),
            ],
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
