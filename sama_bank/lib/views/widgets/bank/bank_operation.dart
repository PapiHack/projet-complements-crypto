import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class BankOperation extends StatelessWidget {
  final String imgUrl;
  final String operationTitle;

  BankOperation({
    required this.imgUrl,
    required this.operationTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ImageWithShadow(
        url: this.imgUrl,
      ),
    );
  }
}

class ImageWithShadow extends StatelessWidget {
  final String url;

  const ImageWithShadow({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 80,
        right: 80,
        top: 25,
        bottom: 25,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(0.0, 3.0),
                  )
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 176, 229, 251),
                    Color.fromARGB(255, 235, 202, 250)
                  ],
                ),
              ),
            ),
          ),
          Image.asset(
            this.url,
          ),
        ],
      ),
    );
  }
}
