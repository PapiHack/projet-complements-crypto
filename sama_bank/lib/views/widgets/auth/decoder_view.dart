import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart';

import '../../../utils/utils.dart';
import '../../../controllers/controllers.dart';
import '../../../config/config.dart';

class DecoderView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _decoderController = DecoderController();
  final _decodedOTPCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        return Container(
          child: Form(
            key: this._formKey,
            child: Column(
              children: [
                addVerticalSpace(25),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: this._decoderController.codeToDecrypt,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (isNull(value) || value == '') {
                        return 'Le code OTP à décrypter est obligatoire';
                      }
                      if (!isNumeric(value!)) {
                        return 'Veuillez spécifier un code OTP à décoder valide svp !';
                      }
                    },
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 16,
                      color: COLOR_DARK,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintStyle: GoogleFonts.redHatDisplay(
                        fontSize: 16,
                        color: COLOR_DARK,
                      ),
                      hintText: 'Code OTP à décoder',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: COLOR_DARK,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: COLOR_DARK,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                ),
                addVerticalSpace(15),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    enabled: false,
                    enableInteractiveSelection: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: this._decodedOTPCodeController,
                    keyboardType: TextInputType.text,
                    validator: (value) {},
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 16,
                      color: COLOR_DARK,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintStyle: GoogleFonts.redHatDisplay(
                        fontSize: 16,
                        color: COLOR_DARK,
                      ),
                      hintText: 'Valeur du Code OTP après décodage',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: COLOR_DARK,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: COLOR_DARK,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                ),
                addVerticalSpace(5),
                Container(
                  margin: EdgeInsets.all(15),
                  child: InkWell(
                    child: customTextButton(
                      COLOR_GREEN,
                      'Décoder',
                      18,
                      FontWeight.w500,
                      () => {},
                    ),
                  ),
                ),
                addVerticalSpace(10),
                customOutlinedButton(
                  'Se connecter',
                  COLOR_GREEN,
                  16,
                  FontWeight.w500,
                  () => Application.router.navigateTo(
                    context,
                    Routes.SIGN_IN,
                  ),
                ),
                addVerticalSpace(5),
                customOutlinedButton(
                  'S\'inscrire',
                  COLOR_GREEN,
                  16,
                  FontWeight.w500,
                  () => Application.router.navigateTo(
                    context,
                    Routes.REGISTER,
                  ),
                ),
                addVerticalSpace(10),
              ],
            ),
          ),
        );
      },
    );
  }
}
