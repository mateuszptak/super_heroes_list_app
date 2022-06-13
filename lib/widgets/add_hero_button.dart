import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddHeroButton extends StatelessWidget {
  const AddHeroButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30,
        bottom: 10,
        left: 20,
        right: 20,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color.fromARGB(255, 113, 7, 85),
              width: 3,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Text(
                text,
                style: GoogleFonts.abrilFatface(
                  fontSize: 40,
                  color: const Color.fromARGB(255, 113, 7, 85),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
