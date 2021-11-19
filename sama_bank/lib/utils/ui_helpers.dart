import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'utils.dart';

class UIHelpers {
  static showSnackbar({
    required GlobalKey<ScaffoldMessengerState> key,
    required String message,
    Color? backgroundColor,
    Color? textColor,
    required String label,
    required Function() action,
  }) =>
      key.currentState?.showSnackBar(
        SnackBar(
          content: customRedHatText(
            message,
            Colors.black,
            14,
            FontWeight.normal,
          ),
          backgroundColor: backgroundColor,
          action: SnackBarAction(
            label: label,
            onPressed: action,
          ),
        ),
      );

  static getSnackbar({
    required String message,
    Color? backgroundColor,
    Color? textColor,
    required String label,
    required Function() action,
  }) =>
      SnackBar(
        content: customRedHatText(
          message,
          Colors.black,
          14,
          FontWeight.normal,
        ),
        backgroundColor: backgroundColor,
        action: SnackBarAction(
          label: label,
          onPressed: action,
        ),
      );
}

Text customRedHatText(
    String text, Color color, double size, FontWeight weight) {
  return Text(
    text,
    style: GoogleFonts.redHatDisplay(
      color: color,
      fontSize: size,
      fontWeight: weight,
    ),
  );
}

TextButton customTextButton(
  Color color,
  String text,
  double textSize,
  FontWeight weight,
  VoidCallback handler,
) {
  return TextButton(
    onPressed: handler,
    style: ButtonStyle(
      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
      backgroundColor: MaterialStateProperty.all<Color>(color),
      foregroundColor: MaterialStateProperty.all<Color>(color),
    ),
    child: Center(
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: weight,
          fontSize: textSize,
          color: Colors.white,
        ),
      ),
    ),
  );
}

OutlinedButton customOutlinedButton(
  String text,
  Color color,
  double size,
  FontWeight weight,
  VoidCallback handler,
) {
  return OutlinedButton(
    onPressed: handler,
    style: ButtonStyle(
      side: MaterialStateProperty.all(BorderSide.none),
    ),
    child: Text(
      text,
      style: GoogleFonts.redHatText(
        color: color,
        fontSize: size,
        fontWeight: weight,
      ),
    ),
  );
}

TextField customTextfield(String label, Color color, bool password,
    TextEditingController? controller) {
  return TextField(
    controller: controller,
    obscureText: password,
    decoration: InputDecoration(
      labelText: label,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: color),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: color),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: color),
      ),
    ),
  );
}

TextStyle addTextStyle(
    Color color, double size, FontWeight weight, String font) {
  return TextStyle(
      color: color, fontSize: size, fontWeight: weight, fontFamily: font);
}

Widget addVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget addHorizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

/*
 ********************* COLORS
*/

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

// ignore: non_constant_identifier_names
Color COLOR_WHITE = HexColor('#ffffff');
// ignore: non_constant_identifier_names
Color COLOR_GREEN = HexColor('#2bae00');
// ignore: non_constant_identifier_names
Color COLOR_BLUE = HexColor('#2f4dea');
// ignore: non_constant_identifier_names
Color COLOR_LIGHT_BLUE = HexColor('#4285f4');
// ignore: non_constant_identifier_names
Color COLOR_DARK = HexColor('#373844');
