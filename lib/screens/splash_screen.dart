import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.blue),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Image.asset("lib/assets/images/logo_rounded.png"),
          ),
          Text(
            "Mosaic",
            style: GoogleFonts.getFont('Rum Raisin',
                color: Colors.white, letterSpacing: 12, fontSize: 70),
          )
        ],
      ),
    );
  }
}
